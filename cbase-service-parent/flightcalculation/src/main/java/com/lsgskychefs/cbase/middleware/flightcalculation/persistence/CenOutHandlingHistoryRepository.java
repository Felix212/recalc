/*
 * Copyright (c) 2025 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 */
package com.lsgskychefs.cbase.middleware.flightcalculation.persistence;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutHandlingHistory;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutHandlingHistoryId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Repository for CEN_OUT_HANDLING_HISTORY table - historical handling data.
 *
 * <p>Tracks changes to handling instructions over time for audit and comparison.
 *
 * @author Migration Team
 */
@Repository
public interface CenOutHandlingHistoryRepository extends JpaRepository<CenOutHandlingHistory, CenOutHandlingHistoryId> {

	/**
	 * Find handling history for a specific flight.
	 *
	 * @param resultKey The flight result key
	 * @return List of historical handling records
	 */
	@Query("SELECT hh FROM CenOutHandlingHistory hh " +
			"WHERE hh.id.nresultKey = :resultKey " +
			"ORDER BY hh.id.ntransaction DESC, hh.nprio ASC")
	List<CenOutHandlingHistory> findByResultKey(@Param("resultKey") Long resultKey);

	/**
	 * Find handling history for a specific transaction.
	 *
	 * @param resultKey The flight result key
	 * @param transactionKey The transaction key
	 * @return List of handling history records for that transaction
	 */
	@Query("SELECT hh FROM CenOutHandlingHistory hh " +
			"WHERE hh.id.nresultKey = :resultKey " +
			"AND hh.id.ntransaction = :transactionKey " +
			"ORDER BY hh.nprio ASC")
	List<CenOutHandlingHistory> findByResultKeyAndTransaction(
			@Param("resultKey") Long resultKey,
			@Param("transactionKey") Long transactionKey);

	/**
	 * Find latest handling history for comparison.
	 *
	 * @param resultKey The flight result key
	 * @return Latest handling history records
	 */
	@Query("SELECT hh FROM CenOutHandlingHistory hh " +
			"WHERE hh.id.nresultKey = :resultKey " +
			"AND hh.id.ntransaction = (" +
			"    SELECT MAX(hh2.id.ntransaction) FROM CenOutHandlingHistory hh2 " +
			"    WHERE hh2.id.nresultKey = :resultKey" +
			") " +
			"ORDER BY hh.nprio ASC")
	List<CenOutHandlingHistory> findLatestByResultKey(@Param("resultKey") Long resultKey);
}
