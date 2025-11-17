/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMeals;

/**
 * Repository class.
 *
 * @author Ingo Rietzschel - U125742
 * @author Dirk Bunk - U200035
 */
public interface CenOutMealsRepository extends PagingAndSortingRepository<CenOutMeals, Long> {

	/**
	 * List of meals from flight, which not added from TOP OFF application.
	 *
	 * @param nresultKey nresultKey
	 * @param nmoduleType module type
	 * @return list of meals
	 */
	@Query("SELECT meal FROM CenOutMeals meal "
			+ "WHERE meal.nresultKey = :nresultKey "
			+ "AND meal.nmoduleType = :nmoduleType "
			+ "AND ( meal.ninputFromTopOff IS NULL OR meal.ninputFromTopOff != 1)")
	List<CenOutMeals> findTopOffMeals(@Param("nresultKey") final long nresultKey, @Param("nmoduleType") final int nmoduleType);

	/**
	 * List of meals from flight with picture.
	 *
	 * @param nresultKey the flight key
	 * @return list of meals
	 */
	@EntityGraph(attributePaths = { "cenPackinglists.cenPackinglistPictures.cenPictures" })
	@Query("SELECT meal FROM CenOutMeals meal "
			+ "JOIN meal.cenPackinglists packinglist "
			+ "JOIN packinglist.cenPackinglistPictures packinglistPicture  "
			+ "JOIN packinglistPicture.cenPictures picture "
			+ "WHERE meal.nresultKey = :nresultKey "
			+ "AND meal.nmoduleType = 0 ")
	List<CenOutMeals> findByMealsWithPictures(@Param("nresultKey") long nresultKey);

	/**
	 * List of meals for a flight and module type.
	 * 
	 * @param nresultKey the flight key
	 * @param nmoduleType the module type
	 * @return list of meals
	 */
	@Query("SELECT meal FROM CenOutMeals meal "
			+ "WHERE meal.nresultKey = :nresultKey "
			+ "AND meal.nmoduleType = :nmoduleType "
			+ "ORDER BY nclassNumber, ncoverPrio, chandlingText, nprio")
	List<CenOutMeals> findMealsExtra(@Param("nresultKey") final long nresultKey, @Param("nmoduleType") final int nmoduleType);

	/**
	 * List of meals for a flight.
	 * 
	 * @param nresultKey the flight key
	 * @return list of meals
	 */
	List<CenOutMeals> findByNresultKeyOrderByNclassNumberAscNcoverPrioAscNprioAsc(@Param("nresultKey") long nresultKey);
}
