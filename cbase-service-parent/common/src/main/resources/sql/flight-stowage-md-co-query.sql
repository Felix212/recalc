  SELECT "CEN_OUT_MD_CO"."CPACKINGLIST",
         "CEN_OUT_MD_CO"."CTEXT",
         "CEN_OUT_MD_CO"."NQUANTITY",
         "CEN_OUT_MD_CO"."CCLASS",
         "CEN_OUT_MD_CO"."CMEAL_CONTROL_CODE",
         "CEN_PACKINGLIST_PICTURES"."NPICTURE_INDEX_KEY",
         1 nmeal_flag,
         "CEN_PACKINGLISTS"."NPACKINGLIST_INDEX_KEY",
         "CEN_PACKINGLISTS"."NPACKINGLIST_DETAIL_KEY",
         "CEN_PACKINGLISTS"."CTEXT_SHORT"
    FROM "CEN_OUT_MD_CO",
         "CEN_OUT_MD",
         "CEN_PACKINGLIST_INDEX",
         "CEN_PACKINGLIST_PICTURES",
         "CEN_PACKINGLISTS"
   WHERE ( cen_packinglists.npackinglist_index_key = cen_packinglist_pictures.npackinglist_index_key (+)) and
         ( cen_packinglists.npackinglist_detail_key = cen_packinglist_pictures.npackinglist_detail_key (+)) and
         ( "CEN_OUT_MD"."NTRANSACTION" = "CEN_OUT_MD_CO"."NTRANSACTION" ) and
         ( "CEN_PACKINGLISTS"."NPACKINGLIST_INDEX_KEY" = "CEN_PACKINGLIST_INDEX"."NPACKINGLIST_INDEX_KEY" ) and
         ( "CEN_OUT_MD_CO"."CPACKINGLIST" = "CEN_PACKINGLIST_INDEX"."CPACKINGLIST" ) and
         ( "CEN_OUT_MD_CO"."NRESULT_KEY" = "CEN_OUT_MD"."NRESULT_KEY" ) and
         ( "CEN_OUT_MD"."NARRAY_COUNT" = "CEN_OUT_MD_CO"."NARRAY_COUNT" ) and
         ( ( cen_out_md.nresult_key = :arg_result_key ) AND
         ( cen_out_md.ntransaction = :arg_transaction ) AND
         ( cen_out_md.nstowagekey = :arg_stowage_key ) AND
         ( cen_out_md.nbelly = :arg_belly ) AND
         ( cen_packinglists.dvalid_from <= :arg_date ) AND
         ( cen_packinglists.dvalid_to >= :arg_date ) )