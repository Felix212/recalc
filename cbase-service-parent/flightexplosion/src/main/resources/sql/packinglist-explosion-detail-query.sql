SELECT 
	plsdetail.npackinglist_index_key,
    plsdetail.ndetail_key,
    plstype.npackinglist_key,
    plstype.ctext,
    plskind.ckind,
    plskind.nuse_reserve,
    plsb.npacking_list_level,
    plsb.npackinglist_detail_key,
    plsb.cunit,
    plsb.ctext AS cpl_text,
    plsb.ctext_short AS cpl_text_short,
    plsb.ctext_short2 AS cpl_text_short2,
    plsb.ccustomer_pl,
    plsb.ccustomer_text,
    plsb.cdef_storage_location,
    plsdetail.nreckoning,
    plsdetail.nnumber_packages,
    plsdetail.nquantity,
    plsdetail.csales_rel,
    plsdetail.cgoods_recipient,
    plsidx.cpackinglist,
    plsidx.npl_kind_key,
    plsmat.nmaterial_index_key,
    plarea.nworkstation_key,
    plarea.narea_key,
    plarea.npl_area_key,
    airacc.caccount,
    airacc.naccount_key,
    pltf.npltimeframe_index,
    pltf.nbatch,
    pltf.noffset,
    pltf.nworkschedule_index,
    pltfflight.noffset nflight_offset,
    pltfflight.nworkschedule_index AS nflight_workschedule_index,
    pltfflight.npltf_flight_index_group,
    pltfflight.npltf_flight_index,
    prodcat.ctext AS cprod_cat_text
FROM cen_packinglist_detail plsdetail
    JOIN cen_packinglist_index plsidx ON plsidx.npackinglist_index_key = plsdetail.ndetail_key
    JOIN cen_packinglists plsa ON plsa.npackinglist_index_key = plsdetail.npackinglist_index_key AND plsa.npackinglist_detail_key = plsdetail.npackinglist_detail_key AND :arg_date BETWEEN plsa.dvalid_from AND plsa.dvalid_to
    JOIN cen_packinglists plsb ON plsb.npackinglist_index_key = plsdetail.ndetail_key AND :arg_date BETWEEN plsb.dvalid_from AND plsb.dvalid_to
    JOIN cen_packinglist_types plstype ON plstype.npackinglist_key = plsb.npackinglist_key
    JOIN sys_packinglist_kinds plskind ON plskind.npl_kind_key = plsidx.npl_kind_key
    LEFT JOIN sys_product_category prodcat ON prodcat.csap_code = plsb.cprod_cat
    LEFT JOIN cen_packinglist_material plsmat ON plsmat.npackinglist_index_key = plsb.npackinglist_index_key AND plsmat.npackinglist_detail_key = plsb.npackinglist_detail_key
    LEFT JOIN loc_unit_pl_areas plarea ON plarea.npackinglist_index_key = plsb.npackinglist_index_key AND plarea.cunit = :arg_csc AND :arg_date BETWEEN plarea.dvalid_from AND plarea.dvalid_to   
    LEFT JOIN cen_airline_accounts airacc ON airacc.naccount_key = plsb.naccount_key
    LEFT JOIN (
        SELECT 
            pltf.npackinglist_index_key, 
            pltf.npltimeframe_index,
            pltf.nbatch,
            pltf.noffset,
            pltf.nworkschedule_index  
        FROM loc_pl_time_frame pltf
            JOIN loc_pl_time_frame_variant pltfvar ON pltfvar.nvariant_index = pltf.nvariant 
            JOIN loc_unit_ppm_validities ppmval ON ppmval.nvalid_index =  pltfvar.nvalid_index
            JOIN loc_unit_prod_time_frame prodtf ON prodtf.nprodtimeframe_index = pltf.nprodtimeframe_index AND prodtf.nvalid_index = ppmval.nvalid_index 
        WHERE 
            ((:arg_check_boarding_unit = 1 AND ppmval.cunit = pltf.cunit AND :arg_csc IN (pltf.cunit, pltf.cboarding_unit))
            	OR (:arg_check_boarding_unit <> 1 AND ppmval.cunit = :arg_csc))
            AND :arg_calc_date - pltf.noffset BETWEEN ppmval.dvalid_from AND ppmval.dvalid_to
            AND :arg_calc_time BETWEEN prodtf.ctimefrom AND prodtf.ctimeto
            AND prodtf.nairline_key = :arg_airline_key 
            AND pltfvar.cfrequency LIKE '%' || TO_CHAR(:arg_calc_date - :arg_iso_offset - pltf.noffset, 'D') || '%'
    ) pltf ON pltf.npackinglist_index_key = plsb.npackinglist_index_key
    LEFT JOIN (
        SELECT 
            pltfflight.npackinglist_index_key, 
            pltfflight.nworkschedule_index,   
            pltfflight.noffset,
            pltfflight.npltf_flight_index_group,
            pltfflight.npltf_flight_index
        FROM loc_pl_time_frame_flight pltfflight
            JOIN loc_unit_ppm_validities ppmval ON ppmval.nvalid_index = pltfflight.nvalid_index
            JOIN cen_out co ON co.cairline = pltfflight.cairline AND co.nflight_number = pltfflight.nflight_number 
                AND co.csuffix = pltfflight.csuffix AND co.ctlc_from = pltfflight.ctlc_from AND co.ctlc_to = pltfflight.ctlc_to 
                AND ((:arg_check_boarding_unit = 1 AND co.cunit IN (pltfflight.cunit, pltfflight.cboarding_unit))
                	OR (:arg_check_boarding_unit <> 1 AND co.cunit = pltfflight.cunit))
        WHERE :arg_calc_date - pltfflight.noffset BETWEEN ppmval.dvalid_from AND ppmval.dvalid_to
            AND pltfflight.nfreq = TO_CHAR(co.ddeparture - :arg_iso_offset, 'D') 
            AND co.nresult_key = :arg_result_key
    ) pltfflight ON pltfflight.npackinglist_index_key = plsb.npackinglist_index_key
WHERE plsdetail.npackinglist_index_key IN (:arg_index)
    AND :arg_date BETWEEN plsdetail.dvalid_from AND plsdetail.dvalid_to
    AND plsb.npacking_list_level <> 3
    AND plsidx.cpackinglist NOT LIKE 'Z%'
ORDER BY plsdetail.npackinglist_index_key, plsdetail.nsort ASC