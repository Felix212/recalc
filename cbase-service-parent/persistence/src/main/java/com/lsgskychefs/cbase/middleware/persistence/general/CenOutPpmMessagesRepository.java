/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */

package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.CenOutPpmMessages;

/**
 * Repository class.
 *
 * @author Alex Schaab
 */
public interface CenOutPpmMessagesRepository extends PagingAndSortingRepository<CenOutPpmMessages, Long> {

	/**
	 * Finds all <code>CenOutPpmMessages</code> by nbatch_seq attribute Ordered By Message Key.
	 *
	 * @param nbatchSeq The nbatch_seq attribute
	 * @return List of <code>CenOutPpmMessage</code>.
	 */
	List<CenOutPpmMessages> findAllByNbatchSeqOrderByNmessKeyAsc(Long nbatchSeq);

}
