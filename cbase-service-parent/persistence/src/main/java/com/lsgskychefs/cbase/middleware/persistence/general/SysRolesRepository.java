/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysLogin;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysRoles;

/**
 * Repository class for {@link SysRoles}
 *
 * @author Ingo Rietzschel - U125742
 */
public interface SysRolesRepository extends PagingAndSortingRepository<SysRoles, Integer> {

	/**
	 * Method to filter {@link SysRoles} with {@link Specification}
	 *
	 * @param sysLogin the name of user to checked
	 * @return filtered {@link SysRoles} or empty List
	 */
	@Query("SELECT roles FROM SysRoles roles "
			+ "JOIN roles.sysRoleGroupsDetails roleGroupsDetails "
			+ "JOIN roleGroupsDetails.sysRoleGroups.sysLogins sysLogins "
			+ "WHERE "
			+ "sysLogins.nuserId = :#{#user.nuserId}")
			List<SysRoles> findGroupRoleByUser(@Param("user") SysLogin sysLogin);

	/**
	 * Load all roles by given user.
	 *
	 * @param sysLogin the user
	 * @return users roles
	 */
	@Query("SELECT roles FROM SysRoles roles "
			+ "JOIN roles.sysLoginRoleses loginRoles "
			+ "WHERE "
			+ "loginRoles.sysLogin.nuserId = :#{#user.nuserId}")
			List<SysRoles> findDirectRoleByUser(@Param("user") SysLogin sysLogin);

}
