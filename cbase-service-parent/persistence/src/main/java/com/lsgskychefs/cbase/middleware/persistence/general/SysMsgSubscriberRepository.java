/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysMsgSubscriber;

/**
 * Repository class for {@link SysMsgSubscriber}.
 *
 * @author Andreas Morgenstern
 */
public interface SysMsgSubscriberRepository extends PagingAndSortingRepository<SysMsgSubscriber, Integer> {

	/**
	 * Loads <code>SysMsgSubscriber</code> objects for a given topic.
	 *
	 * @param ctopic The topic.
	 * @return a list of <code>SysMsgSubscriber</code> with the given topic.
	 */
	@Query("select s from SysMsgSubscriber s where s.id.ctopic=:ctopic")
	List<SysMsgSubscriber> findByCtopic(@Param("ctopic") String ctopic);

	/**
	 * Loads <code>SysMsgSubscriber</code> objects for a given topic and queue.
	 *
	 * @param ctopic The topic names.
	 * @param cqueue The queue (login) name.
	 * @return a list of <code>SysMsgSubscriber</code> with the given topic.
	 */
	@Query("select s from SysMsgSubscriber s where s.id.ctopic=:ctopic and s.id.cqueue=:cqueue")
	List<SysMsgSubscriber> findByCtopicAndCqueue(@Param("ctopic") String ctopic, @Param("cqueue") String cqueue);

	/**
	 * Delete {@link SysMsgSubscriber} for given topic and queue(user)
	 *
	 * @param ctopic The topic names.
	 * @param cqueue The queue (login) name.
	 * @return count of deleted {@link SysMsgSubscriber}.
	 */
	int deleteByIdCtopicAndIdCqueue(String ctopic, String cqueue);
}
