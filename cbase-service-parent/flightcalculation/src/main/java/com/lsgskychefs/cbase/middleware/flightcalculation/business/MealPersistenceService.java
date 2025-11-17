/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.business;

import com.lsgskychefs.cbase.middleware.flightcalculation.dto.MealCalculationContext;
import com.lsgskychefs.cbase.middleware.flightcalculation.persistence.*;
import com.lsgskychefs.cbase.middleware.persistence.domain.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Service for persisting meal and handling calculations to the database.
 *
 * <p>PowerBuilder equivalent methods from uo_generate.sru:
 * <ul>
 *   <li>uf_save_meals() - Save meal calculations</li>
 *   <li>uf_save_handling() - Save handling calculations</li>
 *   <li>uf_save_history() - Save historical records</li>
 *   <li>uf_delete_previous() - Delete previous calculations</li>
 *   <li>uf_commit_changes() - Commit transaction</li>
 * </ul>
 *
 * <p>This service:
 * <ul>
 *   <li>Saves calculated meals to CEN_OUT_MEALS</li>
 *   <li>Saves handling to CEN_OUT_HANDLING</li>
 *   <li>Creates history records for audit trail</li>
 *   <li>Manages transactional integrity</li>
 *   <li>Handles deletion of previous calculations</li>
 * </ul>
 *
 * @author Migration Team
 */
@Service
public class MealPersistenceService {

	private static final Logger LOGGER = LoggerFactory.getLogger(MealPersistenceService.class);

	private final CenOutMealsRepository mealsRepository;
	private final CenOutHandlingRepository handlingRepository;
	private final CenOutMealsHistoryRepository mealsHistoryRepository;
	private final CenOutHandlingHistoryRepository handlingHistoryRepository;

	@Autowired
	public MealPersistenceService(
			CenOutMealsRepository mealsRepository,
			CenOutHandlingRepository handlingRepository,
			CenOutMealsHistoryRepository mealsHistoryRepository,
			CenOutHandlingHistoryRepository handlingHistoryRepository) {
		this.mealsRepository = mealsRepository;
		this.handlingRepository = handlingRepository;
		this.mealsHistoryRepository = mealsHistoryRepository;
		this.handlingHistoryRepository = handlingHistoryRepository;
	}

	/**
	 * Save meal calculations with full transaction management.
	 *
	 * <p>PowerBuilder: uf_save_meals() + uf_commit_changes()
	 *
	 * <p>This method:
	 * <ol>
	 *   <li>Saves current meals to history</li>
	 *   <li>Deletes current meals</li>
	 *   <li>Inserts new meal calculations</li>
	 *   <li>Commits transaction</li>
	 * </ol>
	 *
	 * @param context Meal calculation context
	 * @param newMeals Newly calculated meals
	 * @return Number of meals saved
	 */
	@Transactional
	public int saveMealCalculations(
			MealCalculationContext context,
			List<CenOutMeals> newMeals) {

		Long resultKey = context.getResultKey();
		Long transactionKey = context.getTransactionKey();

		LOGGER.info("Saving {} meal calculations for result_key={}, transaction_key={}",
				newMeals != null ? newMeals.size() : 0, resultKey, transactionKey);

		if (newMeals == null || newMeals.isEmpty()) {
			LOGGER.warn("No meals to save for result_key={}", resultKey);
			return 0;
		}

		// Step 1: Save current meals to history
		saveMealsToHistory(resultKey, transactionKey);

		// Step 2: Delete current meals
		deletePreviousMeals(resultKey);

		// Step 3: Insert new meals
		int savedCount = 0;
		for (CenOutMeals meal : newMeals) {
			// Ensure result_key is set
			if (meal.getId() == null) {
				CenOutMealsId id = new CenOutMealsId();
				id.setNresultKey(resultKey);
				id.setNdetailKey(generateDetailKey());
				meal.setId(id);
			}

			// Save meal
			mealsRepository.save(meal);
			savedCount++;

			LOGGER.debug("Saved meal: detail_key={}, code={}, class={}, quantity={}",
					meal.getNdetailKey(), meal.getCmealCode(), meal.getCclass(),
					meal.getNquantity());
		}

		LOGGER.info("Saved {} meals for result_key={}", savedCount, resultKey);

		// Update context
		context.setCurrentMeals(new ArrayList<>(newMeals));

		return savedCount;
	}

	/**
	 * Save handling calculations with full transaction management.
	 *
	 * <p>PowerBuilder: uf_save_handling() + uf_commit_changes()
	 *
	 * @param context Meal calculation context
	 * @param newHandling Newly calculated handling
	 * @return Number of handling records saved
	 */
	@Transactional
	public int saveHandlingCalculations(
			MealCalculationContext context,
			List<CenOutHandling> newHandling) {

		Long resultKey = context.getResultKey();
		Long transactionKey = context.getTransactionKey();

		LOGGER.info("Saving {} handling calculations for result_key={}, transaction_key={}",
				newHandling != null ? newHandling.size() : 0, resultKey, transactionKey);

		if (newHandling == null || newHandling.isEmpty()) {
			LOGGER.warn("No handling to save for result_key={}", resultKey);
			return 0;
		}

		// Step 1: Save current handling to history
		saveHandlingToHistory(resultKey, transactionKey);

		// Step 2: Delete current handling
		deletePreviousHandling(resultKey);

		// Step 3: Insert new handling
		int savedCount = 0;
		for (CenOutHandling handling : newHandling) {
			// Ensure result_key is set
			if (handling.getId() == null) {
				CenOutHandlingId id = new CenOutHandlingId();
				id.setNresultKey(resultKey);
				id.setNdetailKey(generateDetailKey());
				handling.setId(id);
			}

			// Save handling
			handlingRepository.save(handling);
			savedCount++;

			LOGGER.debug("Saved handling: detail_key={}, code={}, class={}, quantity={}",
					handling.getId().getNdetailKey(), handling.getChandlingCode(),
					handling.getCclass(), handling.getNquantity());
		}

		LOGGER.info("Saved {} handling records for result_key={}", savedCount, resultKey);

		// Update context
		context.setCurrentHandling(new ArrayList<>(newHandling));

		return savedCount;
	}

	/**
	 * Save current meals to history.
	 *
	 * <p>PowerBuilder: uf_save_history() for meals
	 *
	 * @param resultKey Flight result key
	 * @param transactionKey Transaction key for versioning
	 */
	@Transactional
	public void saveMealsToHistory(Long resultKey, Long transactionKey) {
		if (transactionKey == null) {
			LOGGER.debug("No transaction key, skipping history save for result_key={}", resultKey);
			return;
		}

		// Find current meals
		List<CenOutMeals> currentMeals = mealsRepository.findByResultKey(resultKey);

		if (currentMeals.isEmpty()) {
			LOGGER.debug("No current meals to save to history for result_key={}", resultKey);
			return;
		}

		LOGGER.info("Saving {} meals to history for result_key={}, transaction_key={}",
				currentMeals.size(), resultKey, transactionKey);

		// Create history records
		for (CenOutMeals meal : currentMeals) {
			CenOutMealsHistory history = convertMealToHistory(meal, transactionKey);
			mealsHistoryRepository.save(history);
		}

		LOGGER.debug("Saved {} meal history records", currentMeals.size());
	}

	/**
	 * Save current handling to history.
	 *
	 * <p>PowerBuilder: uf_save_history() for handling
	 *
	 * @param resultKey Flight result key
	 * @param transactionKey Transaction key for versioning
	 */
	@Transactional
	public void saveHandlingToHistory(Long resultKey, Long transactionKey) {
		if (transactionKey == null) {
			LOGGER.debug("No transaction key, skipping history save for result_key={}", resultKey);
			return;
		}

		// Find current handling
		List<CenOutHandling> currentHandling = handlingRepository.findByResultKey(resultKey);

		if (currentHandling.isEmpty()) {
			LOGGER.debug("No current handling to save to history for result_key={}", resultKey);
			return;
		}

		LOGGER.info("Saving {} handling records to history for result_key={}, transaction_key={}",
				currentHandling.size(), resultKey, transactionKey);

		// Create history records
		for (CenOutHandling handling : currentHandling) {
			CenOutHandlingHistory history = convertHandlingToHistory(handling, transactionKey);
			handlingHistoryRepository.save(history);
		}

		LOGGER.debug("Saved {} handling history records", currentHandling.size());
	}

	/**
	 * Delete previous meal calculations.
	 *
	 * <p>PowerBuilder: uf_delete_previous() for meals
	 *
	 * @param resultKey Flight result key
	 */
	@Transactional
	public void deletePreviousMeals(Long resultKey) {
		LOGGER.info("Deleting previous meals for result_key={}", resultKey);

		int deletedCount = mealsRepository.deleteByResultKey(resultKey);

		LOGGER.info("Deleted {} previous meal records for result_key={}", deletedCount, resultKey);
	}

	/**
	 * Delete previous handling calculations.
	 *
	 * <p>PowerBuilder: uf_delete_previous() for handling
	 *
	 * @param resultKey Flight result key
	 */
	@Transactional
	public void deletePreviousHandling(Long resultKey) {
		LOGGER.info("Deleting previous handling for result_key={}", resultKey);

		int deletedCount = handlingRepository.deleteByResultKey(resultKey);

		LOGGER.info("Deleted {} previous handling records for result_key={}",
				deletedCount, resultKey);
	}

	/**
	 * Save both meals and handling in a single transaction.
	 *
	 * <p>PowerBuilder: Combined uf_save_meals() + uf_save_handling()
	 *
	 * @param context Meal calculation context
	 * @param newMeals Newly calculated meals
	 * @param newHandling Newly calculated handling
	 * @return Persistence result with counts
	 */
	@Transactional
	public PersistenceResult saveAll(
			MealCalculationContext context,
			List<CenOutMeals> newMeals,
			List<CenOutHandling> newHandling) {

		Long resultKey = context.getResultKey();

		LOGGER.info("Saving all calculations for result_key={}", resultKey);

		PersistenceResult result = new PersistenceResult();

		// Save meals
		if (context.isCalculateMeals() && newMeals != null && !newMeals.isEmpty()) {
			int mealCount = saveMealCalculations(context, newMeals);
			result.setMealsSaved(mealCount);
		}

		// Save handling
		if (context.isCalculateHandling() && newHandling != null && !newHandling.isEmpty()) {
			int handlingCount = saveHandlingCalculations(context, newHandling);
			result.setHandlingSaved(handlingCount);
		}

		result.setSuccess(true);

		LOGGER.info("Persistence complete: {} meals, {} handling for result_key={}",
				result.getMealsSaved(), result.getHandlingSaved(), resultKey);

		return result;
	}

	/**
	 * Convert meal record to history record.
	 *
	 * @param meal Meal record
	 * @param transactionKey Transaction key
	 * @return History record
	 */
	private CenOutMealsHistory convertMealToHistory(CenOutMeals meal, Long transactionKey) {
		CenOutMealsHistory history = new CenOutMealsHistory();

		// Set composite key
		CenOutMealsHistoryId id = new CenOutMealsHistoryId();
		id.setNresultKey(meal.getId().getNresultKey());
		id.setNdetailKey(meal.getId().getNdetailKey());
		id.setNtransaction(transactionKey);
		history.setId(id);

		// Copy all fields
		history.setCmealCode(meal.getCmealCode());
		history.setCclass(meal.getCclass());
		history.setNquantity(meal.getNquantity());
		history.setNprio(meal.getNprio());
		history.setNsequence(meal.getNsequence());
		history.setNgalleyPosition(meal.getNgalleyPosition());
		history.setCgalleyCode(meal.getCgalleyCode());
		history.setNcompartment(meal.getNcompartment());
		history.setCdescription(meal.getCdescription());
		history.setNhandlingMealKey(meal.getNhandlingMealKey());
		history.setNhandlingDetailKey(meal.getNhandlingDetailKey());

		// Set timestamp
		history.setDsaved(new Date());

		return history;
	}

	/**
	 * Convert handling record to history record.
	 *
	 * @param handling Handling record
	 * @param transactionKey Transaction key
	 * @return History record
	 */
	private CenOutHandlingHistory convertHandlingToHistory(
			CenOutHandling handling,
			Long transactionKey) {

		CenOutHandlingHistory history = new CenOutHandlingHistory();

		// Set composite key
		CenOutHandlingHistoryId id = new CenOutHandlingHistoryId();
		id.setNresultKey(handling.getId().getNresultKey());
		id.setNdetailKey(handling.getId().getNdetailKey());
		id.setNtransaction(transactionKey);
		history.setId(id);

		// Copy all fields
		history.setChandlingCode(handling.getChandlingCode());
		history.setCclass(handling.getCclass());
		history.setNquantity(handling.getNquantity());
		history.setNprio(handling.getNprio());
		history.setCdescription(handling.getCdescription());
		history.setNhandlingTypeKey(handling.getNhandlingTypeKey());

		// Set timestamp
		history.setDsaved(new Date());

		return history;
	}

	/**
	 * Generate unique detail key.
	 *
	 * <p>In production, this would use a database sequence.
	 *
	 * @return Detail key
	 */
	private Long generateDetailKey() {
		return System.currentTimeMillis();
	}

	/**
	 * Result of persistence operations.
	 */
	public static class PersistenceResult {
		private boolean success;
		private int mealsSaved;
		private int handlingSaved;
		private String errorMessage;

		public boolean isSuccess() {
			return success;
		}

		public void setSuccess(boolean success) {
			this.success = success;
		}

		public int getMealsSaved() {
			return mealsSaved;
		}

		public void setMealsSaved(int mealsSaved) {
			this.mealsSaved = mealsSaved;
		}

		public int getHandlingSaved() {
			return handlingSaved;
		}

		public void setHandlingSaved(int handlingSaved) {
			this.handlingSaved = handlingSaved;
		}

		public String getErrorMessage() {
			return errorMessage;
		}

		public void setErrorMessage(String errorMessage) {
			this.errorMessage = errorMessage;
		}
	}
}
