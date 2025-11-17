SELECT DISTINCT 
	cen_airline_accounts.caccount               	  AS  cen_air_caccount                ,
	cen_galley.cgalley                          	  AS  cen_gal_cgalley                 ,
	cen_galley.nsort                                  AS  cen_gal_nsort                   ,
    cen_loadinglist_index.cloadinglist          	  AS  cen_ll_idx_cloadinglist         ,
	cen_loadinglist_index.nloadinglist_key      	  AS  cen_ll_idx_nloadinglist_key     ,
	cen_loadinglists.cactioncode                	  AS  cen_ll_cactioncode              ,
	cen_loadinglists.cadd_on_text               	  AS  cen_ll_cadd_on_text             ,
	nvl(cen_loadinglists.cclass, ' ')              	  AS  cen_ll_cclass                   ,
	cen_loadinglists.cgoods_recipient           	  AS  cen_ll_cgoods_recipient         ,
	nvl(cen_loadinglists.csales_rel, ' ')             AS  cen_ll_csales_rel               ,
	cen_loadinglists.nbelly_container           	  AS  cen_ll_nbelly_container         ,
	cen_loadinglists.nloadinglist_detail_key          AS  cen_ll_nloadinglist_detail_key  ,
	cen_loadinglists.nloadinglist_index_key           AS  cen_ll_nloadinglist_index_key   ,
	cen_loadinglists.nquantity                  	  AS  cen_ll_nquantity                ,
	nvl(cen_loadinglists.nreckoning, 0)            	  AS  cen_ll_nreckoning               ,
	cen_packinglist_index.cpackinglist          	  AS  cen_pl_idx_cpackinglist         ,
	cen_packinglist_index.npackinglist_index_key      AS  cen_pl_idx_npl_index_key        ,
	cen_packinglist_index.npl_kind_key          	  AS  cen_pl_idx_npl_kind_key         ,
	cen_packinglists.ccustomer_pl               	  AS  cen_pl_ccustomer_pl             ,
	cen_packinglists.ccustomer_text             	  AS  cen_pl_ccustomer_text           ,
	nvl(cen_packinglists.cdef_storage_location, ' ')  AS  cen_pl_cdef_storage_location    ,
	cen_packinglists.ctext                      	  AS  cen_pl_ctext                    ,
	cen_packinglists.ctext_short                	  AS  cen_pl_ctext_short              ,
	cen_packinglists.cunit                      	  AS  cen_pl_cunit                    ,
	cen_packinglists.naccount_key               	  AS  cen_pl_naccount_key             ,
	cen_packinglists.npackinglist_detail_key    	  AS  cen_pl_npackinglist_detail_key  ,
	cen_packinglists.npackinglist_key                 AS  cen_pl_npackinglist_key         ,
	cen_stowage.cplace                          	  AS  cen_stow_cplace                 ,
	cen_stowage.cstowage							  AS  cen_stow_cstowage               ,
	cen_stowage.npage                           	  AS  cen_stow_npage                  ,
	cen_stowage.nstowage_key                    	  AS  cen_stow_nstowage_key           ,
	cen_stowage.nsort                                 AS  cen_stow_nsort                  ,
	sys_product_category.ctext					      AS  sys_prod_cprod_cat_text         ,
	' '                                               AS  compute_onload_text
FROM cen_loadinglists
	JOIN cen_loadinglist_index ON cen_loadinglist_index.nloadinglist_index_key = cen_loadinglists.nloadinglist_index_key
	JOIN cen_out_handling on cen_out_handling.cloadinglist = cen_loadinglist_index.cloadinglist
	JOIN cen_packinglist_index ON cen_packinglist_index.npackinglist_index_key = cen_loadinglists.npackinglist_index_key
	JOIN cen_packinglists ON cen_packinglists.npackinglist_index_key = cen_packinglist_index.npackinglist_index_key
	LEFT JOIN cen_airline_accounts ON cen_airline_accounts.naccount_key = cen_packinglists.naccount_key
	JOIN cen_stowage ON cen_stowage.nstowage_key = cen_loadinglists.nstowage_key
	JOIN cen_galley ON cen_galley.ngalley_key = cen_stowage.ngalley_key
	LEFT JOIN sys_product_category ON sys_product_category.csap_code = cen_packinglists.cprod_cat
WHERE :arg_reference_date BETWEEN cen_loadinglist_index.dvalid_from AND cen_loadinglist_index.dvalid_to
	AND cen_out_handling.nresult_key = :arg_result_key AND cen_out_handling.nhandling_id = :arg_handling_id
	AND :arg_reference_date BETWEEN cen_packinglists.dvalid_from AND cen_packinglists.dvalid_to
	AND :arg_reference_time BETWEEN cen_loadinglists.ctime_from AND cen_loadinglists.ctime_to
	AND cen_loadinglists.cfrequency like '%' || to_char(:arg_reference_date, 'D') || '%'
	AND cen_loadinglists.cactioncode <> 'C'
	AND NOT EXISTS (SELECT nexclude_key
				FROM loc_unit_ll_exclude ex
				WHERE :arg_ll_exclude = '1'
					AND ex.cunit = :arg_unit
					AND ex.cloadinglist = cen_out_handling.cloadinglist
					AND :arg_reference_date BETWEEN dvalid_from AND dvalid_to)
ORDER BY cen_galley.nsort ASC, cen_stowage.nsort ASC