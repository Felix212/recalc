/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.Date;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysMsgDelivery;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysMsgMessages;

/**
 * Repository class for {@link SysMsgMessages}.
 *
 * @author Andreas Morgenstern
 */
public interface SysMsgMessagesRepository extends PagingAndSortingRepository<SysMsgMessages, Integer> {

	/**
	 * Delete all SysMsgMessages objects that do not have any SysMsgDelivery objects connected.
	 *
	 * @return the number of deleted message objects without delivery.
	 */
	@Modifying
	@Query("delete from SysMsgMessages s where s.sysMsgDeliveries is empty")
	int deleteMessagesWithoutDeliveries();

	/**
	 * Delete all older {@link SysMsgDelivery}.
	 *
	 * @param dtimestamp the deletion date
	 * @return the count of deleted messages
	 */
	@Modifying
	@Query("delete from SysMsgMessages s where s.dtimestamp < :dtimestamp")
	int deleteByDtimestamp(@Param("dtimestamp") Date dtimestamp);

}
