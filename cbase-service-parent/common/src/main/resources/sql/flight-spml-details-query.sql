
  SELECT "CEN_OUT_SPML"."NMASTER_KEY",
         "CEN_OUT_SPML"."NTRANSACTION",
         "CEN_OUT_SPML"."NRESULT_KEY",
         "CEN_OUT_SPML"."NCLASS_NUMBER",
         "CEN_OUT_SPML"."CCLASS",
         "CEN_OUT_SPML"."NPRIO",
         "CEN_OUT_SPML"."NSPML_KEY",
         "CEN_OUT_SPML"."CSPML",
         "CEN_OUT_SPML"."CNAME",
         "CEN_OUT_SPML"."CADD_TEXT",
         "CEN_OUT_SPML"."CREMARK",
         "CEN_OUT_SPML"."NQUANTITY",
         "CEN_OUT_SPML"."NQUANTITY_OLD",
         "CEN_OUT_SPML"."NMANUAL_INPUT",
         "CEN_OUT_SPML"."NDEDUCTION",
         "CEN_OUT_SPML"."DTIMESTAMP",
         "CEN_OUT_SPML"."NSTATUS",
         "CEN_OUT_SPML"."CDESCRIPTION",
         "CEN_OUT_SPML"."NTOPOFF",
         "CEN_OUT_SPML"."NSTATIONENTRY",
         "CEN_OUT_SPML"."CSEAT",
         "CEN_OUT_SPML_DETAIL"."CPACKINGLIST",
         "CEN_OUT_SPML_DETAIL"."CMEAL_CONTROL_CODE",
         "CEN_OUT_SPML_DETAIL"."CPRODUCTION_TEXT",
         "CEN_OUT_SPML_DETAIL"."CTEXT",
         "CEN_OUT_SPML_DETAIL"."NQUANTITY" as detail_nquantity,
         "CEN_PACKINGLIST_PICTURES"."NPICTURE_INDEX_KEY",
         "CEN_OUT_SPML_DETAIL"."NPACKINGLIST_INDEX_KEY",
         "CEN_OUT_SPML_DETAIL"."NPACKINGLIST_DETAIL_KEY"
    FROM "CEN_OUT_SPML",
         "CEN_OUT_SPML_DETAIL",
         "CEN_PACKINGLIST_PICTURES"
   WHERE ( cen_out_spml_detail.npackinglist_index_key = cen_packinglist_pictures.npackinglist_index_key (+)) and
         ( cen_out_spml_detail.npackinglist_detail_key = cen_packinglist_pictures.npackinglist_detail_key (+)) and
         ( "CEN_OUT_SPML"."NMASTER_KEY" = "CEN_OUT_SPML_DETAIL"."NMASTER_KEY" ) and
         ( ( cen_out_spml.nmaster_key = :arg_master_key ) ) and
         ( cen_out_spml_detail.nbilling_status in (0,1))
ORDER BY "CEN_OUT_SPML"."NCLASS_NUMBER" ASC,
         "CEN_OUT_SPML"."NPRIO" ASC,
         "CEN_OUT_SPML"."CSPML" ASC