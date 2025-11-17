SELECT DISTINCT
    cen_out_md_lo.ngalley_key  ngalley_key,
    cen_out_md_lo.nstowage_key nstowage_key,
    cen_out_md_lo.cgalley      cgalley,
    cen_out_md_lo.cstowage     cstowage,
    cen_out_md_lo.cplace       cplace,
    cen_out_md_lo.cpackinglist cpl_in_stowage,
    'none'                     cpl_meal_header,
    cen_out_md_lo.ctext_pckl   ctext_stowage,
    cen_out_md_lo.nquantity    nquantity,
    0 						   nquantity_act,
    null                       cclass,
	null	                       nclass_number,
    contents.cpackinglist      cpackinglist,
    contents.ctext             ctext_content,
    contents.npackinglist_key  npackinglist_key,
    contents.clevel            clevel,
    contents.ctype             cpackinglist_type,
    contents.nlevel            nlevel,
    'Standardload'             ctype
FROM
    cen_out,
    cen_out_md_lo,
    TABLE (cbase_general.pf_explode_packinglist(cen_out_md_lo.npackinglist_index_key,
    cen_out.ddeparture , 1, 1)) contents
WHERE
    cen_out.nresult_key = cen_out_md_lo.nresult_key
AND cen_out.nresult_key = :arg_result_key
AND trim(contents.cpackinglist) <> 'Z'
UNION
SELECT DISTINCT
    cen_out_md.ngalleykey   ngalley_key,
    cen_out_md.nstowagekey  nstowage_key,
    cen_galley.cgalley      cgalley,
    cen_stowage.cstowage    cstowage,
    cen_stowage.cplace      cplace,
    cen_out_md.cpackinglist cpl_stowage,
    (
        SELECT
            pp1.cpackinglist
        FROM
            cen_packinglist_index pp1
        WHERE
            pp1.npackinglist_index_key = cen_packinglist_index.npackinglist_index_key)
                                cpl_meal_header,
    cen_out_md.ctext2           ctext_stowage,
    cen_out_md_co.nquantity     nquantity,
	meals_act.nquantity_act     nquantity_act,
    cen_out_md_co.cclass        cclass,
	cen_out_md_co.nclass_number nclass_number,
    contents.cpackinglist       cpl_content ,
    contents.ctext              ctext_content,
    contents.npackinglist_key   npackinglist_key,
    contents.clevel             clevel,
    contents.ctype              cpackinglist_type,
    contents.nlevel             nlevel,
    'Mealload'                  ctype
FROM
    cen_galley,
    cen_out,
    cen_out_md,
    cen_packinglist_index,
    cen_stowage,
    cen_out_md_co,
    TABLE (cbase_general.pf_explode_packinglist(cen_packinglist_index.npackinglist_index_key,
    cen_out.ddeparture , 1, 1)) contents,
    (SELECT cpackinglist, SUM(nquantity) nquantity_act from cen_out_meals WHERE nresult_key = :arg_result_key AND nbilling_status IN (0,1) GROUP BY cpackinglist) meals_act
WHERE
    cen_out_md.nresult_key = cen_out.nresult_key
AND cen_out_md.nstowagekey = cen_stowage.nstowage_key
AND cen_stowage.ngalley_key = cen_galley.ngalley_key
AND cen_out_md_co.nresult_key = cen_out_md.nresult_key
AND cen_out_md_co.ntransaction = cen_out_md.ntransaction
AND cen_out_md_co.narray_count = cen_out_md.narray_count
AND cen_out_md_co.cpackinglist = cen_packinglist_index.cpackinglist
AND cen_out_md_co.cpackinglist = meals_act.cpackinglist
AND cen_out.nresult_key = :arg_result_key
AND trim(contents.cpackinglist) <> 'Z'
ORDER BY
    nstowage_key,
    ctype,
    ctext_content