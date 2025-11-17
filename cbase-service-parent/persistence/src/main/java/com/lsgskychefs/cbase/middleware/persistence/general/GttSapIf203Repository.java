/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.GttSapIf203;

/**
 * Repository class for {@link GttSapIf203} entity/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface GttSapIf203Repository extends PagingAndSortingRepository<GttSapIf203, Long> {

	/**
	 * Get all {@link GttSapIf203} ordered by ddeparture, csumFlag, citem, cairline, cpackinglist.
	 *
	 * @return all entries
	 */
	List<GttSapIf203> findAllByOrderByDdepartureAscCsumFlagAscCitemAscCairlineAscCpackinglistAsc();
}
