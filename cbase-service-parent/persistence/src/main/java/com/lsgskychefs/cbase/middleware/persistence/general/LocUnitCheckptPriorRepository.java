/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.Date;
import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitCheckptPrior;
import com.lsgskychefs.cbase.middleware.persistence.domain.LocUnitCheckptPriorId;

/**
 * Repository class for {@link LocUnitCheckptPrior} object/table.
 *
 * @author Alex Schaab - U524036
 */
public interface LocUnitCheckptPriorRepository extends PagingAndSortingRepository<LocUnitCheckptPrior, LocUnitCheckptPriorId> {

	/**
	 * Get the list of all predecessors from given Checkpoint
	 * 
	 * @param ncheckpointKey the given checkpoint
	 * @param refDateFrom validity
	 * @param refDateTo validity
	 * @return predecessors
	 */
	List<LocUnitCheckptPrior> findByIdNcheckpointKeyAndIdDvalidfromBeforeAndDvalidtoAfter(Long ncheckpointKey, Date refDateFrom,
			Date refDateTo);
}
