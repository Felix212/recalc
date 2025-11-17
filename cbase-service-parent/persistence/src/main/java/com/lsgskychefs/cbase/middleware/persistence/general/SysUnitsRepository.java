/*
 * Copyright (c) 2017 Lufthansa Industry Solutions BS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.persistence.general;

import java.util.List;

import javax.persistence.StoredProcedureQuery;

import org.springframework.stereotype.Repository;

import com.lsgskychefs.cbase.middleware.persistence.CbaseMiddlewareRepository;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpContextResetUserRole;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpContextRole;
import com.lsgskychefs.cbase.middleware.persistence.constant.CbaseMiddlewareDbConstants.PpContextUser;
import com.lsgskychefs.cbase.middleware.persistence.domain.SysUnits;

/**
 * Repository class for {@link SysUnits} object/table.
 * 
 * @author U009907
 */
@Repository
public class SysUnitsRepository extends CbaseMiddlewareRepository {

	/**
	 * Gets the Unit list based on User- and Role-ID
	 * 
	 * @param nroleId
	 * @param nuserId
	 * @return
	 */
	public List<SysUnits> getSysUnitsByRoleId(final Long nroleId, final Long nuserId) {

		StoredProcedureQuery query = this.em.createNamedStoredProcedureQuery(PpContextUser.PP_CONTEXT_USER)
				.setParameter(PpContextUser.P_USER_ID, nuserId);

		query.execute();

		query = this.em.createNamedStoredProcedureQuery(PpContextRole.PP_CONTEXT_ROLE)
				.setParameter(PpContextRole.P_ROLE_ID, nroleId);

		query.execute();

		final List<SysUnits> sysUnits = findAll(SysUnits.class);

		query = this.em.createNamedStoredProcedureQuery(PpContextResetUserRole.PP_CONTEXT_RESET_USERROLE);

		query.execute();

		return sysUnits;
	}

	/**
	 * Get units for active airline
	 * 
	 * @param cairline the airline for which to get the units for
	 * @return list of units for active airline
	 */
	public List<String> findUnitsForActiveAirlines(final String cairline) {
		return this.em.createQuery(
				"SELECT DISTINCT su.cunit " +
						"FROM SysUnits su " +
						"JOIN su.cenAirlineUnits cau " +
						"WHERE cau.cenAirlines.cairline = :cairline " +
						"AND su.nnonSky = 0",
				String.class)
				.setParameter("cairline", cairline)
				.getResultList();
	}

	/**
	 * Get units by client
	 * 
	 * @param cclient, the cclient
	 * @return List of {@link SysUnits}
	 */
	public List<SysUnits> findUnitsByCclient(final String cclient) {
		return this.em.createQuery("SELECT su " +
				"FROM SysUnits su " +
				"WHERE su.cclient = :arg_client " +
				"ORDER BY su.ctext ASC, su.cunit ASC",
				SysUnits.class)
				.setParameter("arg_client", cclient)
				.getResultList();
	}

}
