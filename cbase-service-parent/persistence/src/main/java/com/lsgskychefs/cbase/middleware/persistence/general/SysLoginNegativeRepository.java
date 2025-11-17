/*
 * Copyright (c) 2015-2016 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import org.springframework.data.repository.PagingAndSortingRepository;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysLoginNegativ;

/**
 * Repository class for {@link SysLoginNegativ} object/table.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface SysLoginNegativeRepository extends PagingAndSortingRepository<SysLoginNegativ, String> {

	/**
	 * Search if the given password is not allowed.
	 *
	 * @param password to check against not allowed passwords
	 * @return the {@link SysLoginNegativ} or {@code null}
	 */
	SysLoginNegativ findByCpasswordIgnoreCase(String password);
}
