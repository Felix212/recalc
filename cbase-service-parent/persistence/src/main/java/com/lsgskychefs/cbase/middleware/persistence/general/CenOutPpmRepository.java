/*
 * CenOutCommentRepository.java
 *
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpm;
import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmFlights;

/**
 * Repository class.
 *
 * @author Andreas Morgenstern
 */
public interface CenOutPpmRepository extends PagingAndSortingRepository<CenOutPpm, Long> {

	/**
	 * Finds a <code>CenOutPpm</code> by its nbatch_seq attribute.
	 *
	 * @param batchSeq The nbatch_seq attribute.
	 * @return The matching <code>CenOutPpm</code> or null.
	 */
	CenOutPpm findFirstByNbatchSeq(Long batchSeq);

	/**
	 * Finds a <code>CenOutPpm</code> by its nbatch_seq attribute.
	 *
	 * @param batchSeq
	 * @return
	 */
	CenOutPpm findFirstByNbatchSeqProdLabel(Long batchSeq);

	/**
	 * Finds a <code>CenOutPpm</code> by its nbatch_seq or nbatch_seq_prod_label attribute.
	 * 
	 * @param batchSeq
	 * @param batchSeqProdLabel
	 * @return
	 */
	CenOutPpm findFirstByNbatchSeqOrNbatchSeqProdLabel(Long batchSeq, Long batchSeqProdLabel);

	/**
	 * Finds all <code>CenOutPpms</code> by its nbatch_seq attribute.
	 *
	 * @param batchSeq The nbatch_seq attribute.
	 * @return The matching <code>CenOutPpms</code> or null.
	 */
	List<CenOutPpm> findByNbatchSeq(Long batchSeq);

	/**
	 * Finds all <code>CenOutPpms</code> by its nbatch_seq attribute and makes sure that reserves (ntransaction == -1) are selected last.
	 *
	 * @param batchSeq The nbatch_seq attribute.
	 * @return The matching <code>CenOutPpms</code> or null.
	 */
	List<CenOutPpm> findByNbatchSeqOrderByCenOutPpmFlightsIdNtransactionDesc(Long batchSeq);

	/**
	 * Finds all <code>CenOutPpms</code> by its nbatch_seq attribute order by departuretime.
	 * 
	 * @param batchSeq
	 * @return
	 */
	List<CenOutPpm> findByNbatchSeqOrderByCenOutPpmFlightsDdepartureTime(Long batchSeq);

	/**
	 * Finds all <code>CenOutPpms</code> by its nbatch_seq attribute order by ramptime.
	 * 
	 * @param batchSeq
	 * @return
	 */
	List<CenOutPpm> findByNbatchSeqOrderByCenOutPpmFlightsDrampTime(Long batchSeq);

	/**
	 * Retrieves a list of those <code>CenOutPpm</code> elements that match the given nbatch_seq attribute and have a
	 * <code>CenOutHistory</code>.
	 *
	 * @param batchSeq The nbatch_seq attribute.
	 * @return The matching <code>CenOutPpm</code> elements having a history.
	 */
	@Query("SELECT p FROM CenOutPpm p, CenOutHistory h WHERE "
			+ "p.nbatchSeq in :batchSeq "
			+ "AND p.cenOutPpmFlights.id.nresultKey=h.id.nresultKey "
			+ "AND p.cenOutPpmFlights.id.ntransaction=h.id.ntransaction")
	List<CenOutPpm> findWithCorrellatedHistory(@Param("batchSeq") Long batchSeq);

	/**
	 * Filter {@link CenOutPpm} by given parameters.
	 *
	 * @param cpackinglist packinglist value
	 * @param dprodDate production date
	 * @param npltimeframeIndex index value
	 * @return the list of {@link CenOutPpm}
	 */
	List<CenOutPpm> findByCpackinglistAndDprodDateAndNpltimeframeIndexOrderByNbatchNo(String cpackinglist, Date dprodDate,
			Long npltimeframeIndex);

	/**
	 * Retrieves a list of those <code>CenOutPpm</code> elements that match the given cpackinglist attribute and prodate between dat1 and
	 * dat2
	 * 
	 * @param cpackinglist
	 * @param dprodDate1
	 * @param dprodDate2
	 * @return the list of {@link CenOutPpm}
	 */
	@Query("SELECT p FROM CenOutPpm p WHERE "
			+ "p.cpackinglist = :cpackinglist "
			+ "AND p.dprodDate >= :dprodDate1 "
			+ "AND p.dprodDate <= :dprodDate2")
	List<CenOutPpm> findByCpackinglistAndDprodDates(@Param("cpackinglist") String cpackinglist,
			@Param("dprodDate1") Date dprodDate1,
			@Param("dprodDate2") Date dprodDate2);

	/**
	 * Retrieves a list of those <code>CenOutPpm</code> elements that match the given cpackinglist attribute and flights are departures
	 * between dat1 and dat2
	 * 
	 * @param cpackinglist
	 * @param ddepDate1
	 * @param ddepDate2
	 * @return the list of {@link CenOutPpm}
	 */
	@Query("SELECT p FROM CenOutPpm p WHERE "
			+ "p.cpackinglist = :cpackinglist "
			+ "AND p.cenOutPpmFlights.ddepartureTime >= :ddepDate1 "
			+ "AND p.cenOutPpmFlights.ddepartureTime <= :ddepDate2")
	List<CenOutPpm> findByCpackinglistAndDdepDates(@Param("cpackinglist") String cpackinglist, @Param("ddepDate1") Date ddepDate1,
			@Param("ddepDate2") Date ddepDate2);

	/**
	 * Retrieves a list of <code>CenOutPpm</code> elements that are in the given batch sequence list
	 *
	 * @param nbatchSeq List of all batch sequence numbers
	 * @return the list of {@link CenOutPpm}
	 */
	List<CenOutPpm> findByNbatchSeqIn(Set<Long> nbatchSeq);

	/**
	 * Returns the Quantity to be produced for the whole Batch
	 *
	 * @param nbatchSeq Batch sequence number
	 * @return Quantity to be produced
	 */
	@Query("SELECT SUM(p.nquantityProd) FROM CenOutPpm p WHERE p.nbatchSeq=:batchSeq")
	BigDecimal getBatchQuantityByNbatchSeq(@Param("batchSeq") Long nbatchSeq);

	/**
	 * Get all WorkOrders for production date and shift(schedule)
	 *
	 * @param dprodDate production date
	 * @param nworkscheduleIndex work shift
	 * @return the list of {@link CenOutPpm} (WorkOrders)
	 */
	// @EntityGraph(attributePaths = { "cenOutPpmFlights" }) //TODO iri: NPE: https://hibernate.atlassian.net/browse/HHH-9230 fixed in 5.0.4
	@Query("SELECT c FROM CenOutPpm c, LocPlTimeFrame tf "
			+ "JOIN tf.locUnitWsSchedule schedule "
			+ "WHERE c.npltimeframeIndex = tf.npltimeframeIndex "
			+ "AND schedule.nworkscheduleIndex in :nworkscheduleIndex "
			+ "AND c.dprodDate = :dprodDate ")
	List<CenOutPpm> findByProdDatAndSchedule(@Param("dprodDate") Date dprodDate,
			@Param("nworkscheduleIndex") Long... nworkscheduleIndex);

	/**
	 * List of all {@link CenOutPpm} for given Flight and Itemlist
	 * 
	 * @param npackinglistIndexKey the index key
	 * @param npackinglistDetailKey the detail key
	 * @param cenOutPpmFlight the flight
	 * @return List of {@link CenOutPpm}
	 */
	List<CenOutPpm> findByNpackinglistIndexKeyAndNpackinglistDetailKeyAndCenOutPpmFlights(final Long npackinglistIndexKey,
			final Long npackinglistDetailKey, final CenOutPpmFlights cenOutPpmFlight);

	/**
	 * List of all {@link CenOutPpm} for given Flight and Itemlist WITHOUT Validity
	 * 
	 * @param npackinglistIndexKey the index key
	 * @param cenOutPpmFlight the flight
	 * @return List of {@link CenOutPpm}
	 */
	List<CenOutPpm> findByNpackinglistIndexKeyAndCenOutPpmFlights(final Long npackinglistIndexKey, final CenOutPpmFlights cenOutPpmFlight);

	/**
	 * List of all flights for given flight and sector
	 * 
	 * @param nresultKey
	 * @param nsectorKey
	 * @return List of {@link CenOutPpm}
	 */
	List<CenOutPpm> findByCenOutPpmFlightsIdNresultKeyAndNsectorKey(long nresultKey, long nsectorKey);

	/**
	 * List of all orders for flight and shift that are 'trolleys/carts' = have a stowage
	 * 
	 * @param nresultKey
	 * @param nppmSchedKey
	 * @return List of {@link CenOutPpm}
	 */
	List<CenOutPpm> findByCenOutPpmFlightsIdNresultKeyAndCenOutPpmSchedNppmSchedKeyAndCgalleyNotNullOrderByNgalleySortAscNstowageSortAsc(
			long nresultKey,
			long nppmSchedKey);
	
	/**
	 * List of all orders for flight and shift that are 'trolleys/carts' and are out-dated/not needed anymore
	 * 
	 * @param nresultKey
	 * @param nppmSchedKey
	 * @return List of {@link CenOutPpm}
	 */
	List<CenOutPpm> findByCenOutPpmFlightsIdNresultKeyAndCenOutPpmSchedNppmSchedKeyAndNdisposeTrueOrderByNgalleySortAsc(
			long nresultKey,
			long nppmSchedKey);

	/**
	 * List of all orders for flight and Packinglist
	 * 
	 * @param nresultKey
	 * @param npackinglistIndexKey
	 * @return List of {@link CenOutPpm}
	 */
	List<CenOutPpm> findByCenOutPpmFlightsIdNresultKeyAndNpackinglistIndexKey(long nresultKey,
			long npackinglistIndexKey);

	/**
	 * List of started other Batches from this user and shift with nquantityProd > 0
	 * 
	 * @param nbatchSeq
	 * @param cuserLock
	 * @return List of {@link CenOutPpm}
	 */
	@Query("SELECT c FROM CenOutPpm c, CenOutPpm c2 "
			+ "WHERE c.cenOutPpmSched.nppmSchedKey = c2.cenOutPpmSched.nppmSchedKey "
			+ "AND c2.nbatchSeq = :nbatchSeq "
			+ "AND c.nbatchSeq != :nbatchSeq "
			+ "AND c.nstatus = 10 "
			+ "AND c.nquantityProd > 0 "
			+ "AND c.cuserLock = :cuserLock")
	List<CenOutPpm> findStartedBatch(@Param("nbatchSeq") Long nbatchSeq,
			@Param("cuserLock") String cuserLock);

	/**
	 * List of the same Batches that where already produced. e.g. by Batch Split the remaining qty is moved to a new batch with increased
	 * BatchNo
	 * 
	 * @param nbatchSeq the batch you want to check if there where previous ones
	 * @return List of {@link CenOutPpm}
	 */
	@Query("SELECT previous FROM CenOutPpm previous, CenOutPpm current "
			+ "WHERE previous.cenOutPpmSched.nppmSchedKey = current.cenOutPpmSched.nppmSchedKey "
			+ "AND current.nbatchSeq = :nbatchSeq "
			+ "AND previous.nbatchSeq != :nbatchSeq "
			+ "AND previous.cpackinglist = current.cpackinglist "
			+ "AND previous.dprodDate = current.dprodDate "
			+ "AND previous.nbatchNo < current.nbatchNo")
	List<CenOutPpm> findPreviousBatches(@Param("nbatchSeq") Long nbatchSeq);

	/**
	 * List of open Batches for a Shift
	 * 
	 * @param nppmSchedKey
	 * @return List of {@link CenOutPpm}
	 */
	@Query("SELECT c FROM CenOutPpm c "
			+ "WHERE c.cenOutPpmSched.nppmSchedKey = :nppmSchedKey "
			+ "AND c.nstatus < 20 "
			+ "ORDER BY c.nbatchSeq")
	List<CenOutPpm> findOpenBatches(@Param("nppmSchedKey") Long nppmSchedKey);

	/**
	 * Find by Fligth and Stowage
	 * 
	 * @param nresultKey
	 * @param nstowageKey
	 * @return List<CenOutPpm>
	 */
	@Query("SELECT cop FROM CenOutPpm cop "
			+ "JOIN cop.cenOutPpmFlights cenOutFlights "
			+ "JOIN cop.cenOutPpmFlights.id cenOutFlightsId "
			+ "WHERE cop.nstowageKey = :nstowageKey "
			+ "AND cenOutFlightsId.nresultKey = :nresultKey ")
	List<CenOutPpm> findByFlightAndStowage(@Param("nresultKey") long nresultKey, @Param("nstowageKey") long nstowageKey);

	/**
	 * Find all rows of a flight with Stowagekey
	 * 
	 * @param nresultKey
	 * @return List<CenOutPpm>
	 */
	@Query("SELECT cop FROM CenOutPpm cop "
			+ "JOIN cop.cenOutPpmFlights cenOutFlights "
			+ "JOIN cop.cenOutPpmFlights.id cenOutFlightsId "
			+ "WHERE cop.nstowageKey > 0 "
			+ "AND cenOutFlightsId.nresultKey = :nresultKey ")
	List<CenOutPpm> findByFlightWithStowage(@Param("nresultKey") long nresultKey);

	/**
	 * Find all StowageKeys for a Packinglist
	 * 
	 * @param nresultKey
	 * @param npackinglistIndexKey
	 * @return List<Long>
	 */
	@Query("SELECT DISTINCT cop.nstowageKey  FROM CenOutPpm cop "
			+ "JOIN cop.cenOutPpmCos copc "
			+ "JOIN cop.cenOutPpmFlights cenOutFlights "
			+ "JOIN cop.cenOutPpmFlights.id cenOutFlightsId "
			+ "WHERE cenOutFlightsId.nresultKey = :nresultKey "
			+ "AND copc.npackinglistIndexKey = :npackinglistIndexKey ")
	List<Long> findStowageKeysForPackinglist(@Param("nresultKey") long nresultKey,
			@Param("npackinglistIndexKey") long npackinglistIndexKey);

	/**
	 * Find all Stowages who are not okay
	 * 
	 * @param nresultKey
	 * @return List<CenOutPpm>
	 */
	@Query("SELECT cop FROM CenOutPpm cop "
			// + "JOIN cop.cenOutPpmCos cenOutPpmCos "
			+ "JOIN cop.cenOutPpmFlights cenOutFlights "
			+ "JOIN cop.cenOutPpmFlights.id cenOutFlightsId "
			+ "WHERE cop.nstowageKey > 0 "
			+ "AND cop.ncsoStatus = 10 "
			+ "AND cenOutFlightsId.nresultKey = :nresultKey ")
	List<CenOutPpm> findByFlightWithNotOkayStowage(@Param("nresultKey") long nresultKey);

	/**
	 * Get the Check States of the flight
	 * 
	 * @param nresultKey
	 * @return all States
	 */
	@Query("SELECT DISTINCT cop.ncsoStatus  FROM CenOutPpm cop "
			+ "JOIN cop.cenOutPpmFlights cenOutFlights "
			+ "JOIN cop.cenOutPpmFlights.id cenOutFlightsId "
			+ "WHERE cenOutFlightsId.nresultKey = :nresultKey "
			+ "AND cop.nstowageKey is not null "
			+ "ORDER BY cop.ncsoStatus desc")
	List<Integer> findCsoStatus(@Param("nresultKey") long nresultKey);

	/**
	 * Get the <code>CenOutPpm</code> elements by result key, transaction, container kinds and container units
	 * 
	 * @param nresultKey
	 * @param ntransaction
	 * @param nplKindKeys
	 * @param cunits
	 * @return the list of {@link CenOutPpm}
	 */
	List<CenOutPpm> findByCenOutPpmFlightsIdNresultKeyAndCenOutPpmFlightsIdNtransactionAndNplKindKeyInAndCunitIn(
			Long nresultKey,
			Long ntransaction,
			List<Long> nplKindKeys,
			List<String> cunits);
	

	/**
	 * Get the <code>CenOutPpm</code> elements by result key, transaction, cgalley, cstowage and cplace
	 * 
	 * @param nresultKey
	 * @param ntransaction
	 * @param cgalley
	 * @param cstowage
	 * @param cplace
	 * @return
	 */
	List<CenOutPpm> findByCenOutPpmFlightsIdNresultKeyAndCenOutPpmFlightsIdNtransactionAndCgalleyAndCstowageAndCplaceStartsWith(
			Long nresultKey,
			Long ntransaction,
			String cgalley,
			String cstowage,
			String cplace);
	
}
