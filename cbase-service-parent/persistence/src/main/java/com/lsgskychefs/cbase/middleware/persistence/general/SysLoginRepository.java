/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysLogin;

/**
 * Repository class for {@link SysLogin}.
 *
 * @author Ingo Rietzschel - U125742
 */
public interface SysLoginRepository extends PagingAndSortingRepository<SysLogin, Integer> {

	/**
	 * Load user by username.
	 *
	 * @param cusername the user name
	 * @return the user or null
	 */
	SysLogin findByCusername(String cusername);

	/**
	 * load all users for a role they have directly. To get the entire list of authorized users you need to get
	 * {@link #findUsersByGroupRole(Integer)} also
	 *
	 * @param nroleId the role id
	 * @return List of users
	 */
	@Query("SELECT user FROM SysLogin user "
			+ "JOIN user.sysLoginRoleses sysLoginRoleses "
			+ "WHERE "
			+ "sysLoginRoleses.sysRoles.nroleId = :nroleId")
	List<SysLogin> findUsersByDirectRole(@Param("nroleId") final Integer nroleId);

	/**
	 * load all users for a role they have through group assignment To get the entire list of authorized users you need to get
	 * {@link #findUsersByDirectRole(Integer)} also
	 *
	 * @param nroleId the user
	 * @return List of users
	 */
	@Query("SELECT user FROM SysLogin user "
			+ "JOIN user.sysRoleGroupses sysRoleGroups "
			+ "JOIN sysRoleGroups.sysRoleGroupsDetails sysRoleGroupsDetails "
			+ "WHERE "
			+ "sysRoleGroupsDetails.sysRoles.nroleId = :nroleId")
	List<SysLogin> findUsersByGroupRole(@Param("nroleId") final Integer nroleId);

	/**
	 * Find all login data
	 * 
	 * @return List of {@link SysLogin}
	 */
	List<SysLogin> findAllByOrderByClastname();

}
