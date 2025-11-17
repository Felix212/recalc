/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMealsHistory;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutMealsHistoryId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository for CEN_OUT_MEALS_HISTORY table - historical meal data.
 *
 * <p>Tracks changes to meal data over time for audit and comparison purposes.
 *
 * @author Migration Team
 */
@Repository
public interface CenOutMealsHistoryRepository extends JpaRepository<CenOutMealsHistory, CenOutMealsHistoryId> {

	/**
	 * Find meal history for a specific flight.
	 *
	 * @param resultKey The flight result key
	 * @return List of historical meal records
	 */
	@Query("SELECT mh FROM CenOutMealsHistory mh " +
			"WHERE mh.id.nresultKey = :resultKey " +
			"ORDER BY mh.id.ntransaction DESC, mh.id.ndetailKey ASC")
	List<CenOutMealsHistory> findByResultKey(@Param("resultKey") Long resultKey);

	/**
	 * Find meal history for a specific transaction.
	 *
	 * @param resultKey The flight result key
	 * @param transactionKey The transaction key
	 * @return List of meal history records for that transaction
	 */
	@Query("SELECT mh FROM CenOutMealsHistory mh " +
			"WHERE mh.id.nresultKey = :resultKey " +
			"AND mh.id.ntransaction = :transactionKey " +
			"ORDER BY mh.id.ndetailKey ASC")
	List<CenOutMealsHistory> findByResultKeyAndTransaction(
			@Param("resultKey") Long resultKey,
			@Param("transactionKey") Long transactionKey);

	/**
	 * Find latest meal history for comparison.
	 *
	 * @param resultKey The flight result key
	 * @return Latest meal history records
	 */
	@Query("SELECT mh FROM CenOutMealsHistory mh " +
			"WHERE mh.id.nresultKey = :resultKey " +
			"AND mh.id.ntransaction = (" +
			"    SELECT MAX(mh2.id.ntransaction) FROM CenOutMealsHistory mh2 " +
			"    WHERE mh2.id.nresultKey = :resultKey" +
			") " +
			"ORDER BY mh.id.ndetailKey ASC")
	List<CenOutMealsHistory> findLatestByResultKey(@Param("resultKey") Long resultKey);
}
