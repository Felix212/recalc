/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysMsgDelivery;

/**
 * Repository class for {@link SysMsgDelivery}.
 *
 * @author Andreas Morgenstern
 */
public interface SysMsgDeliveryRepository extends PagingAndSortingRepository<SysMsgDelivery, Integer> {

	/**
	 * Loads messages for a given topic and queue (login user name).
	 *
	 * @param ctopics The topic names.
	 * @param cqueue The queue (login) name.
	 * @return the messages for the user with the given topic.
	 */
	// @EntityGraph(attributePaths = { "sysMsgMessages" }) // TODO iri: NPE: https://hibernate.atlassian.net/browse/HHH-9230 fixed in 5.0.4
	@Query("select s from SysMsgDelivery s where s.id.cqueue=:cqueue and s.csessionid is null and s.sysMsgMessages.ctopic in (:ctopics)")
	List<SysMsgDelivery> findByCtopicInAndCqueue(@Param("cqueue") String cqueue, @Param("ctopics") String... ctopics);

	/**
	 * Loads the first 100 messages for a given topic and queue (login user name).
	 *
	 * @param ctopics The topic names.
	 * @param cqueue The queue (login) name.
	 * @return the messages for the user with the given topic.
	 */
	List<SysMsgDelivery> findFirst100ByIdCqueueAndSysMsgMessagesCtopicInOrderByDtimestamp(@Param("cqueue") String cqueue,
			@Param("ctopics") String... ctopics);

}
