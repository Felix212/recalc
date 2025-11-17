SELECT	sys_units.*
FROM	sys_units
WHERE	cclient = :arg_cclient
AND (	cunit IN (	SELECT	sys_role_grp_restr_unit.cunit
					FROM	sys_role_grp_restr_unit,
							sys_role_grp_restr_supp,
							sys_role_groups_detail
					WHERE	sys_role_grp_restr_unit.nrole_gr_restr_supp_key = sys_role_grp_restr_supp.nrole_gr_restr_supp_key
					AND		sys_role_grp_restr_supp.nuser_id = :arg_nuser
					AND (	sys_role_grp_restr_supp.nsupplier_key = :arg_nsupplier OR (:arg_nsupplier IS NULL AND sys_role_grp_restr_supp.nsupplier_key = sys_units.nsupplier_key))
					AND		sys_role_grp_restr_supp.nrole_groupkey = sys_role_groups_detail.nrole_groupkey
					AND		sys_role_groups_detail.nrole_id = :arg_nrole
				)
		)
OR	  (	cunit IN (	SELECT	sys_roles_restr_unit.cunit
					FROM	sys_roles_restr_unit, sys_roles_restr_supp
					WHERE	sys_roles_restr_unit.nrole_restr_supp_key = sys_roles_restr_supp.nrole_restr_supp_key
					AND (	sys_roles_restr_supp.nsupplier_key = :arg_nsupplier OR (:arg_nsupplier IS NULL AND sys_roles_restr_supp.nsupplier_key = sys_units.nsupplier_key))
					AND		sys_roles_restr_supp.nuser_id = :arg_nuser
					AND sys_roles_restr_supp.nrole_id = :arg_nrole
				)
		)
OR	(	nsupplier_key IN (	SELECT	sys_roles_restr_supp.nsupplier_key
							FROM	sys_roles_restr_supp
							WHERE(	sys_roles_restr_supp.nsupplier_key = :arg_nsupplier OR (:arg_nsupplier IS NULL AND sys_roles_restr_supp.nsupplier_key = sys_units.nsupplier_key))
							AND		sys_roles_restr_supp.nuser_id = :arg_nuser
							AND		sys_roles_restr_supp.nrole_id = :arg_nrole
						)
	AND	(	SELECT	COUNT (*)
			FROM	sys_roles_restr_unit,
					sys_roles_restr_supp
			WHERE	sys_roles_restr_unit.nrole_restr_supp_key = sys_roles_restr_supp.nrole_restr_supp_key
			AND	(	sys_roles_restr_supp.nsupplier_key = :arg_nsupplier OR (:arg_nsupplier IS NULL AND sys_roles_restr_supp.nsupplier_key = sys_units.nsupplier_key))
			AND		sys_roles_restr_supp.nuser_id = :arg_nuser
			AND		sys_roles_restr_supp.nrole_id = :arg_nrole
		) = 0
	)
OR	(	nsupplier_key IN (	SELECT	sys_role_grp_restr_supp.nsupplier_key
							FROM	sys_role_grp_restr_supp, sys_role_groups_detail
							WHERE	sys_role_grp_restr_supp.nuser_id = :arg_nuser
							AND (   sys_role_grp_restr_supp.nsupplier_key = :arg_nsupplier OR (:arg_nsupplier IS NULL AND sys_role_grp_restr_supp.nsupplier_key = sys_units.nsupplier_key))
							AND		sys_role_grp_restr_supp.nrole_groupkey = sys_role_groups_detail.nrole_groupkey
							AND		sys_role_groups_detail.nrole_id = :arg_nrole
						)
	AND	(	SELECT	COUNT (*)
			FROM	sys_role_grp_restr_unit,
					sys_role_grp_restr_supp,
					sys_role_groups_detail
			WHERE	sys_role_grp_restr_unit.nrole_gr_restr_supp_key = sys_role_grp_restr_supp.nrole_gr_restr_supp_key
			AND		sys_role_grp_restr_supp.nuser_id = :arg_nuser
			AND	(	sys_role_grp_restr_supp.nsupplier_key = :arg_nsupplier OR (:arg_nsupplier IS NULL AND sys_role_grp_restr_supp.nsupplier_key = sys_units.nsupplier_key))
			AND		sys_role_grp_restr_supp.nrole_groupkey = sys_role_groups_detail.nrole_groupkey
			AND		sys_role_groups_detail.nrole_id = :arg_nrole
		) = 0
	)
OR	(	(	SELECT	COUNT (*)
			FROM	sys_role_grp_restr_unit,
					sys_role_grp_restr_supp,
					sys_role_groups_detail
			WHERE	sys_role_grp_restr_unit.nrole_gr_restr_supp_key = sys_role_grp_restr_supp.nrole_gr_restr_supp_key
			AND		sys_role_grp_restr_supp.nuser_id = :arg_nuser
			AND	(	sys_role_grp_restr_supp.nsupplier_key = :arg_nsupplier OR (:arg_nsupplier IS NULL AND sys_role_grp_restr_supp.nsupplier_key = sys_units.nsupplier_key))
			AND		sys_role_grp_restr_supp.nrole_groupkey = sys_role_groups_detail.nrole_groupkey
			AND		sys_role_groups_detail.nrole_id = :arg_nrole
		) = 0
	AND (	SELECT	COUNT (*)
			FROM	sys_roles_restr_unit,
					sys_roles_restr_supp
			WHERE	sys_roles_restr_unit.nrole_restr_supp_key = sys_roles_restr_supp.nrole_restr_supp_key
			AND	(	sys_roles_restr_supp.nsupplier_key = :arg_nsupplier OR (:arg_nsupplier IS NULL AND sys_roles_restr_supp.nsupplier_key = sys_units.nsupplier_key))
			AND		sys_roles_restr_supp.nuser_id = :arg_nuser
			AND		sys_roles_restr_supp.nrole_id = :arg_nrole
		) = 0
	AND	(	SELECT	COUNT (*)
			FROM	sys_role_grp_restr_supp,
					sys_role_groups_detail
			WHERE	sys_role_grp_restr_supp.nuser_id = :arg_nuser
			AND		sys_role_grp_restr_supp.nrole_groupkey = sys_role_groups_detail.nrole_groupkey
			AND		sys_role_groups_detail.nrole_id = :arg_nrole
		) = 0
	AND	(	SELECT	COUNT (*)
			FROM	sys_roles_restr_supp
			WHERE	sys_roles_restr_supp.nuser_id = :arg_nuser
			AND		sys_roles_restr_supp.nrole_id = :arg_nrole
		) = 0
	)
OR (	:arg_nsupplier IS NULL AND :arg_nuser IS NULL AND :arg_nrole IS NULL)
