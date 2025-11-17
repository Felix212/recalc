/*
 * Copyright (c) 2015-2015 Lufthansa Industry Solutions AS GmbH. All Rights Reserved.
 *
 */
package com.lsgskychefs.cbase.middleware.base.business;

import com.lsgskychefs.cbase.middleware.persistence.domain.SysRoles;

/**
 * All CBASE user roles {@link SysRoles}
 *
 * @author U524036
 */
public enum CbaseRole {
	/** Master Role for all apps */
	APP_ALL(30000, "CBASEapps ALL"),
	/** Role for all item list specific functionality */
	ITEM_LIST(30001, "CBASEapps Item Lists"),
	/** Role for all delivery specific functionality */
	APP_DELIVERY(30002, "CBASEapps Delivery"),
	/** Role for all flight tracker specific functionality */
	FLIGHT_TRACKER(30003, "CBASEapps FlightTracker"),
	/** Role for all top off specific functionality */
	TOP_OFF(30004, "CBASEapps TopOff"),
	/** Role for all flight check specific functionality */
	FLIGHT_CHECK(30006, "CBASEapps FlightCheck"),

	/** Role for all workorder specific functionality */
	WORKORDER(30007, "CBASEapps WorkOrder"),
	/** Role for all workorder_status specific functionality */
	WORKORDER_STATUS(30008, "CBASEapps WorkOrderStatus"),
	/** Role for all workorder_overview specific functionality */
	WORKORDER_OVERVIEW(30009, "CBASEapps WorkOrderOverview"),
	/** Role for all VPS (workorder) specific functionality */
	VPS(30010, "CBASEapps VPS"),
	/** Role for all Podcheck (workorder) specific functionality */
	PODCHECK(30011, "CBASEapps Podcheck"),
	/** Role for all Trailpoint (workorder) specific functionality */
	TRAILPOINT(30012, "CBASEapps Trailpoint"),
	/** Role for all TrayAssembly (workorder) specific functionality */
	TRAYASSEMBLY(30013, "CBASEapps TrayAssembly"),
	/** Role for all EquipmentSupply (workorder) specific functionality */
	EQUIPMENTSUPPLY(30014, "CBASEapps EquipmentSupply"),
	/** Role for all Supervisor (workorder) specific functionality */
	SUPERVISOR(30015, "CBASEapps Supervisor"),
	/** Role for all ManagementOverview (workorder) specific functionality */
	MANAGEMENT_OVERVIEW(30016, "CBASEapps ManagementOverview"),
	/** Role for all Foodpacking (workorder) specific functionality */
	FOODPACKING(30017, "CBASEapps Foodpacking"),
	/** Role functionality ? */
	WORKORDERSTATUS_CHANGE_SETTINGS(30018, "CBASEapps Workorderstatus Change Settings"),
	/** Role for all Billingstatus specific functionality */
	BILLINGSTATUS(30019, "CBASEapps BillingStatus"),
	/** Role for all RPC shopfloor specific functionality */
	RPC_SHOPFLOOR(30020, "CBASEapps RPC Shopfloor"),
	/** Role for all Ramp Check (workorder) specific functionality */
	RAMP_CHECK(30021, "CBASEapps Ramp Check"),
	/** Role for all Shiftmanager Dashboard (workorder) specific functionality */
	SHIFTMANAGER_DASHBOARD(30022, "CBASEapps Shiftmanager Dashboard"),
	/** Role for all SCO App (workorder) specific functionality */
	SCO(30023, "CBASEapps CSO"),
	/** Role for all VPS Galley Check (workorder) specific functionality */
	GALLEY_CHECK(30024, "CBASEapps VPS Galley Check"),
	/** Role for all Floorplan (workorder) specific functionality */
	FLOORPLAN(30025, "CBASEapps Floorplan"),
	/** Role for delete Floorplan (workorder) specific functionality */
	FLOORPLAN_DELETE(11317, "CBASEapps Delete Floorplan"),
	/** Role for all Chiller (workorder) specific functionality */
	CHILLER(30026, "CBASEapps Chiller"),
	/** Role for all Flight Commissioning (workorder) specific functionality */
	FLIGHT_COMMISSIONING(30027, "CBASEapps Flight Commissioning"),
	/** Role for all Pre Production (workorder) specific functionality */
	PRE_PRODUCTION(30028, "CBASEapps Pre Production"),
	/** Role for all Flight Commissioning (workorder) specific functionality */
	DISALLOW_WEB_LOGIN(66667, "Disallow Web Login"),
	/** Special role for workorder supervisors (ehaccp). */
	EHACCP_SUPERVISOR(11301, "eHACCP Supervisor"),
	/** Special role for WorkOrder - move workorder */
	WORKORDER_MOVE(11310, "CBASEapps WorkOrder move"),
	/** Special role for WorkOrder - plan shift */
	WORKORDER_PLAN_SHIFT(11311, "CBASEapps WorkOrder plan shift"),
	/** Special role for WorkOrder - enter sequence */
	WORKORDER_ENTER_SEQUENCE(11312, "CBASEapps WorkOrder enter sequence"),
	/** Special role for WorkOrder - enter employee */
	WORKORDER_ENTER_EMPLOYEE(11313, "CBASEapps WorkOrder enter employee"),
	/** Role for Helpdesk related functions */
	HELPDESK(21000, "Helpdesk");

	/** If the password is expired the user has not this role */
	public static final String ROLE_PWD_NOT_EXPIRED = "PASSWORD_NOT_EXPIRED";

	/** ROLE_PREFIX */
	public static final String ROLE_PREFIX = "ROLE_";

	/** anonymous role. */
	public static final String ROLE_ANONYMOUS = "ANONYMOUS";

	/** ID for Role */
	private int roleId;

	/** role name with prefix */
	private String roleName;

	/**
	 * Get the role with prefix. If the prefix exist, the role is returned. All blanks will be replaced by '_' and string is convert to
	 * upper case.
	 * <ul>
	 * <li>NAME -> ROLE_NAME
	 * <li>ROLE_VALUE -> ROLE_VALUE
	 * <li>VALUE_ROLE_T -> ROLE_VALUE_ROLE_T
	 * <li>name test -> ROLE_NAME_TEST
	 * </ul>
	 *
	 * @param role the role name
	 * @return the role with prefix
	 */
	public static String roleWithPrefix(final String role) {
		if (role.startsWith(CbaseRole.ROLE_PREFIX)) {
			return role.replace(" ", "_").toUpperCase();
		}
		return CbaseRole.ROLE_PREFIX + role.replace(" ", "_").toUpperCase();
	}

	/**
	 * if you have to find the right CbaseRole by a string value
	 * 
	 * @param role id or name of the role. e.g. 30000/"CBASEapps ALL"
	 * @return CbaseRole enum
	 */
	public static CbaseRole getByStringOrId(final String role) {
		for (final CbaseRole enumRole : CbaseRole.values()) {
			if (Integer.toString(enumRole.roleId).equals(role) || enumRole.roleName.equalsIgnoreCase(CbaseRole.roleWithPrefix(role))) {
				return enumRole;
			}
		}

		return null;
	}

	/**
	 * Private Constructor
	 *
	 * @param roleId The ID
	 * @param roleName the name of role
	 */
	CbaseRole(final int roleId, final String roleName) {
		this.roleId = roleId;
		this.roleName = CbaseRole.roleWithPrefix(roleName);
	}

	/**
	 * Gets the ID for the role
	 *
	 * @return the ID
	 */
	public int getRoleId() {
		return roleId;
	}

	/**
	 * The role name, inclusive the role prefix('ROLE_').
	 *
	 * @return the role name
	 */
	public String getRoleName() {
		return roleName;
	}

}
