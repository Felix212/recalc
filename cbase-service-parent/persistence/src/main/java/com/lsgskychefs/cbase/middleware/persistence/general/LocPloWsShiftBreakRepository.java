/*
 * Copyright (c) 2015-2018 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocPloShift;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocPloWsShiftBreak;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocPloWsShiftBreakId;

/**
 * Repository class for {@link LocPloWsShiftBreak} object/table.
 *
 * @author Paola Lera - U116198
 */
public interface LocPloWsShiftBreakRepository extends PagingAndSortingRepository<LocPloWsShiftBreak, LocPloWsShiftBreakId> {

	/**
	 * Delete {@link LocPloWsShiftBreak} by given workstation and shift key.
	 *
	 * @param nworkstationKey, workstation key
	 * @param nshiftKey, shift key
	 */
	void deleteByIdNworkstationKeyAndIdNshiftKey(final long nworkstationKey, final long nshiftKey);

	/**
	 * Delete {@link LocPloWsShiftBreak} by given workstation
	 * 
	 * @param nworkstationKey, workstation key
	 */
	void deleteByIdNworkstationKey(final long nworkstationKey);

	/**
	 * Find data of type {@link LocPloWsShiftBreak} by given workstation and shift key.
	 *
	 * @param nworkstationKey, workstation key
	 * @param nshiftKey, shift key
	 * @return List of {@link LocPloWsShiftBreak}
	 */
	List<LocPloWsShiftBreak> findByIdNworkstationKeyAndIdNshiftKey(final long nworkstationKey, final long nshiftKey);

	/**
	 * Find shifts for workstation
	 * 
	 * @param nworkstationKey, workstation key
	 * @return List of {@link LocPloShift}
	 */
	@Query("SELECT DISTINCT wsShiftBreak.locPloShift FROM LocPloWsShiftBreak wsShiftBreak WHERE "
			+ "wsShiftBreak.id.nworkstationKey = :nworkstationKey "
			+ "ORDER BY wsShiftBreak.locPloShift.cshift ASC")
	List<LocPloShift> findShiftsForWorkstation(@Param("nworkstationKey") long nworkstationKey);

}
