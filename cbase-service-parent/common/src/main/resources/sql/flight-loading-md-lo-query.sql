  SELECT DISTINCT "CEN_OUT_MD_LO"."CGALLEY",
         "CEN_OUT_MD_LO"."CSTOWAGE",
         "CEN_OUT_MD_LO"."CPLACE",
         "CEN_OUT_MD_LO"."CCLASS",
         "CEN_OUT_MD_LO"."CPACKINGLIST",
         "CEN_OUT_MD_LO"."CLOADINGLIST",
         "CEN_OUT_MD_LO"."CTEXT_PCKL",
         "CEN_OUT_MD_LO"."CUNIT",
         "CEN_OUT_MD_LO"."NQUANTITY",
         "CEN_OUT_MD_LO"."NBELLY_CONTAINER",
         "CEN_OUT_MD_CO"."CPACKINGLIST" as "MD_CO_CPACKINGLIST" ,
         "CEN_OUT_MD_CO"."NQUANTITY" as "MD_CO_NQUANTITY",
         "CEN_OUT_MD_CO"."CTEXT" as "MD_CO_CTEXT",
         "CEN_OUT_MD_CO"."CREMARK" as "MD_CO_CREMARK",
         "CEN_OUT_MD_CO"."CPL_TYPE" as "MD_CO_CPL_TYPE",
         "CEN_OUT_MD_CO"."CCLASS" as "MD_CO_CCLASS",
         "CEN_OUT_MD_CO"."CMEAL_CONTROL_CODE" as "MD_CO_CMEAL_CONTROL_CODE",
         "CEN_OUT_MD_CO"."NSPML" as "MD_CO_NSPML",
         "CEN_OUT_MD_LO"."NSTOWAGE_KEY",
         "CEN_OUT_MD_LO"."NPACKINGLIST_INDEX_KEY",
         "CEN_OUT_MD_LO"."NPACKINGLIST_DETAIL_KEY",
         "CEN_PACKINGLIST_PICTURES"."NPICTURE_INDEX_KEY",
         "CEN_OUT_MD_LO"."NAPPROVED",
         "CEN_OUT_MD_LO"."CTEXT_SHORT"
    FROM "CEN_OUT_MD_LO",
         "CEN_OUT_MD",
         "CEN_OUT_MD_CO",
         "CEN_PACKINGLIST_PICTURES",
         "CEN_PACKINGLIST_INDEX"
   WHERE ( cen_out_md_lo.nresult_key = cen_out_md.nresult_key (+)) and
         ( cen_out_md_lo.nstowage_key = cen_out_md.nstowagekey (+)) and
         ( cen_out_md_lo.nbelly_container = cen_out_md.nbelly (+)) and
         ( cen_out_md_co.nresult_key (+) = cen_out_md.nresult_key) and
         ( cen_out_md_co.ntransaction (+) = cen_out_md.ntransaction) and
         ( cen_out_md_co.narray_count (+) = cen_out_md.narray_count) and
         ( cen_out_md_lo.npackinglist_index_key = cen_packinglist_pictures.npackinglist_index_key (+))  and
         ( cen_out_md_lo.nloadinglist_detail_key = cen_packinglist_pictures.npackinglist_detail_key (+)) and
         ( ( cen_out_md_lo.nresult_key = :arg_result_key ) AND
         ( cen_out_md_lo.ntransaction = :arg_transaction ) AND
         (cen_out_md_lo.nstowage_key = :arg_stowage_key OR
         :arg_stowage_key IS NULL) )