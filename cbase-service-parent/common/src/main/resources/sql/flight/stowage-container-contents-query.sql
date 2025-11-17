SELECT CEN_OUT_MEALS.NPACKINGLIST_INDEX_KEY,
       CEN_OUT_MEALS.NPACKINGLIST_DETAIL_KEY,
       CEN_OUT_MD_CO.CPACKINGLIST,
       CEN_OUT_MD_CO.CTEXT,
       CEN_OUT_MD_CO.NQUANTITY,
       CEN_OUT_MD_CO.NCLASS_NUMBER,
       CEN_OUT_MD_CO.CCLASS,
       CEN_OUT_MD_CO.CMEAL_CONTROL_CODE,
       CEN_OUT_MD_CO.CPL_TYPE,
       DECODE (CEN_OUT_MEALS.NMODULE_TYPE, 0, 'Meal', 'Additional')   CTYPE,
       SUM(CEN_OUT_MEALS.nquantity)  nquantity_act                       
  FROM cen_out_meals,
       cen_out_md,
       cen_out_md_co
WHERE cen_out_md.nresult_key = cen_out_meals.nresult_key
   AND cen_out_md_co.nresult_key = cen_out_md.nresult_key
   AND cen_out_md_co.ntransaction = cen_out_md.ntransaction
   AND cen_out_md_co.narray_count = cen_out_md.narray_count
   AND CEN_OUT_MD_CO.CPACKINGLIST = cen_out_meals.cpackinglist
   AND cen_out_meals.nbilling_status IN (0,1)
   AND cen_out_md.nstowagekey= :arg_stowage_key
   AND cen_out_md.nresult_key = :arg_result_key
   and CEN_OUT_MD.NTRANSACTION =:arg_transaction
group by CEN_OUT_MEALS.NPACKINGLIST_INDEX_KEY,
         CEN_OUT_MEALS.NPACKINGLIST_DETAIL_KEY,
         CEN_OUT_MD_CO.CPACKINGLIST,
         CEN_OUT_MD_CO.CTEXT,
         CEN_OUT_MD_CO.NQUANTITY,
         CEN_OUT_MD_CO.NCLASS_NUMBER,
         CEN_OUT_MD_CO.CCLASS,
         CEN_OUT_MD_CO.CMEAL_CONTROL_CODE,
         CEN_OUT_MD_CO.CPL_TYPE,
         CEN_OUT_MEALS.NMODULE_TYPE
   
union all
 
SELECT cen_out_spml_detail.NPACKINGLIST_INDEX_KEY,
       cen_out_spml_detail.NPACKINGLIST_DETAIL_KEY,
       CEN_OUT_MD_CO.CPACKINGLIST,
       CEN_OUT_MD_CO.CTEXT,
       CEN_OUT_MD_CO.NQUANTITY,
       CEN_OUT_MD_CO.NCLASS_NUMBER,
       CEN_OUT_MD_CO.CCLASS,
       CEN_OUT_MD_CO.CMEAL_CONTROL_CODE,
       CEN_OUT_MD_CO.CPL_TYPE,
       'SPML'   CTYPE,
       SUM(cen_out_spml_detail.nquantity) nquantity_act                       
  FROM cen_out_md,
       cen_out_md_co,
       cen_out_spml_detail,
       cen_out_spml
 WHERE cen_out_md_co.nresult_key = cen_out_md.nresult_key
   AND cen_out_md_co.ntransaction = cen_out_md.ntransaction
   AND cen_out_md_co.narray_count = cen_out_md.narray_count
   and cen_out_md_co.nresult_key = CEN_OUT_SPML.nresult_key 
   AND CEN_OUT_SPML.NMASTER_KEY = CEN_OUT_SPML_DETAIL.NMASTER_KEY
   and CEN_OUT_SPML_DETAIL.NBILLING_STATUS IN (0,1)
   and CEN_OUT_SPML_DETAIL.CPACKINGLIST = CEN_OUT_MD_CO.CPACKINGLIST
   AND cen_out_md.nstowagekey= :arg_stowage_key
   AND cen_out_md.nresult_key = :arg_result_key
   and CEN_OUT_MD.NTRANSACTION =:arg_transaction
group by cen_out_spml_detail.NPACKINGLIST_INDEX_KEY,
         cen_out_spml_detail.NPACKINGLIST_DETAIL_KEY,
         CEN_OUT_MD_CO.CPACKINGLIST,
         CEN_OUT_MD_CO.CTEXT,
         CEN_OUT_MD_CO.NQUANTITY,
         CEN_OUT_MD_CO.NCLASS_NUMBER,
         CEN_OUT_MD_CO.CCLASS,
         CEN_OUT_MD_CO.CMEAL_CONTROL_CODE,
         CEN_OUT_MD_CO.CPL_TYPE