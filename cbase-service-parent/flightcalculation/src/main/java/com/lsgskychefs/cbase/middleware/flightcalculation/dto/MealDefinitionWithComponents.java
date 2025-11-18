/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.dto;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenMeals;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenMealsDetail;

import java.util.List;

/**
 * DTO combining a meal definition header with its component details.
 *
 * <p>PowerBuilder Architecture:
 * <ul>
 *   <li>CenMeals = Meal header (e.g., "Business Class Lunch")</li>
 *   <li>CenMealsDetail[] = Components (appetizer, main, dessert, etc.)</li>
 * </ul>
 *
 * <p>This DTO represents the complete meal definition needed for component-level
 * calculation. Each component will become one CenOutMeals output record.
 *
 * @author Migration Team
 */
public class MealDefinitionWithComponents {

	private final CenMeals mealHeader;
	private final List<CenMealsDetail> components;

	/**
	 * Create a meal definition with components.
	 *
	 * @param mealHeader The meal header (reserves, topoffs, class, etc.)
	 * @param components The meal components (individual items, each becomes one output record)
	 */
	public MealDefinitionWithComponents(CenMeals mealHeader, List<CenMealsDetail> components) {
		if (mealHeader == null) {
			throw new IllegalArgumentException("mealHeader cannot be null");
		}
		if (components == null || components.isEmpty()) {
			throw new IllegalArgumentException("components cannot be null or empty");
		}
		this.mealHeader = mealHeader;
		this.components = components;
	}

	/**
	 * Get the meal header containing reserves, topoffs, and class information.
	 *
	 * @return Meal header
	 */
	public CenMeals getMealHeader() {
		return mealHeader;
	}

	/**
	 * Get the list of components for this meal.
	 *
	 * <p>Each component has:
	 * <ul>
	 *   <li>nspml_deduction - Flag indicating if SPMLs should be deducted</li>
	 *   <li>npercentage - Component percentage (0-100)</li>
	 *   <li>nprio - Priority/sequence number</li>
	 *   <li>ncomponent_group - Grouping identifier</li>
	 *   <li>ncalc_id - Calculation type</li>
	 * </ul>
	 *
	 * @return List of components ordered by priority
	 */
	public List<CenMealsDetail> getComponents() {
		return components;
	}

	/**
	 * Get component count.
	 *
	 * @return Number of components
	 */
	public int getComponentCount() {
		return components.size();
	}

	/**
	 * Get meal key.
	 *
	 * @return Meal header key
	 */
	public Long getMealKey() {
		return mealHeader.getNhandlingMealKey();
	}

	/**
	 * Get service class.
	 *
	 * @return Class code (Y, C, F, etc.)
	 */
	public String getClassCode() {
		return mealHeader.getCclass();
	}

	@Override
	public String toString() {
		return "MealDefinitionWithComponents{" +
				"mealKey=" + getMealKey() +
				", class=" + getClassCode() +
				", componentCount=" + getComponentCount() +
				'}';
	}
}
