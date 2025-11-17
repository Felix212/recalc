  SELECT 
         "CEN_OUT_MEALS"."NTRANSACTION",   
         "CEN_OUT_MEALS"."NRESULT_KEY",   
         "CEN_OUT_MEALS"."NCOVER_KEY",   
         "CEN_OUT_MEALS"."CCOVER_TEXT",   
         "CEN_OUT_MEALS"."NCLASS_NUMBER",   
         "CEN_OUT_MEALS"."CCLASS",   
         "CEN_OUT_MEALS"."NRESERVE_QUANTITY",   
         "CEN_OUT_MEALS"."NRESERVE_TYPE",   
         "CEN_OUT_MEALS"."NTOPOFF_QUANTITY",   
         "CEN_OUT_MEALS"."NTOPOFF_TYPE",   
         "CEN_OUT_MEALS"."NMODULE_TYPE",   
         "CEN_OUT_MEALS"."NPACKINGLIST_INDEX_KEY",   
         "CEN_OUT_MEALS"."CPACKINGLIST",   
         "CEN_OUT_MEALS"."CUNIT",    
         "CEN_OUT_MEALS"."CPRODUCTION_TEXT",   
         "CEN_OUT_MEALS"."NQUANTITY_GROUP",   
         "CEN_OUT_MEALS"."CREMARK",   
         "CEN_OUT_MEALS"."NPAX",   
         "CEN_OUT_MEALS"."NPAX_MANUAL",   
         SUM("CEN_OUT_MEALS"."NQUANTITY") AS "NQUANTITY",    
         SUM("CEN_OUT_MEALS"."NQUANTITY_OLD") AS "NQUANTITY_OLD",  
         "CEN_OUT_MEALS"."NMANUAL_INPUT",   
         "CEN_OUT_MEALS"."NMANUAL_PROCESSING",   
         "CEN_OUT_MEALS"."DTIMESTAMP",   
         "CEN_OUT_MEALS"."NSTATUS",   
         "CEN_OUT_MEALS"."CDESCRIPTION",  
         SUM("CEN_OUT_MEALS"."NQUANTITY1") AS "NQUANTITY1", 
         SUM("CEN_OUT_MEALS"."NQUANTITY2") AS "NQUANTITY2", 
         SUM("CEN_OUT_MEALS"."NQUANTITY3") AS "NQUANTITY3", 
         SUM("CEN_OUT_MEALS"."NQUANTITY4") AS "NQUANTITY4", 
         SUM("CEN_OUT_MEALS"."NQUANTITY5") AS "NQUANTITY5", 
         SUM("CEN_OUT_MEALS"."NQUANTITY6") AS "NQUANTITY6", 
         SUM("CEN_OUT_MEALS"."NQUANTITY7") AS "NQUANTITY7", 
         "CEN_OUT_MEALS"."NSPML_QUANTITY",   
         "CEN_OUT_MEALS"."NPLTYPE_KEY",   
         "CEN_OUT_MEALS"."NPL_KIND_KEY",   
         "CEN_OUT_MEALS"."NPACKINGLIST_KEY",   
         "CEN_OUT_MEALS"."NPACKINGLIST_DETAIL_KEY",   
         "CEN_OUT_MEALS"."CTEXT",    
         "CEN_OUT_MEALS"."CCUSTOMER_PL",   
         "CEN_OUT_MEALS"."CCUSTOMER_TEXT",   
         "CEN_PICTURES"."NPICTURE_INDEX_KEY",   
         "CEN_PACKINGLISTS"."CTEXT_SHORT"
  
    FROM "CEN_OUT_MEALS",
         "CEN_PACKINGLIST_PICTURES",
         "CEN_PICTURES",
         "CEN_PACKINGLISTS"
         
   WHERE ( cen_out_meals.npackinglist_index_key = cen_packinglist_pictures.npackinglist_index_key (+)) and  
         ( cen_out_meals.npackinglist_detail_key = cen_packinglist_pictures.npackinglist_detail_key (+)) and  
         ( cen_packinglist_pictures.npicture_index_key = cen_pictures.npicture_index_key (+)) and  
         ( "CEN_OUT_MEALS"."NPACKINGLIST_INDEX_KEY" = "CEN_PACKINGLISTS"."NPACKINGLIST_INDEX_KEY" ) and  
         ( "CEN_OUT_MEALS"."NPACKINGLIST_DETAIL_KEY" = "CEN_PACKINGLISTS"."NPACKINGLIST_DETAIL_KEY" ) and  
         ( ( cen_out_meals.nresult_key = :arg_result_key ) AND  
         ( cen_out_meals.nmodule_type = :arg_module ) ) AND
         ( cen_out_meals.cclass = :arg_class OR :arg_class = '-1') AND
         ( cen_out_meals.nbilling_status in (0,1))
     
   GROUP BY 
         "CEN_OUT_MEALS"."NTRANSACTION",   
         "CEN_OUT_MEALS"."NRESULT_KEY",   
         "CEN_OUT_MEALS"."NCOVER_KEY",   
         "CEN_OUT_MEALS"."CCOVER_TEXT",   
         "CEN_OUT_MEALS"."NCLASS_NUMBER",   
         "CEN_OUT_MEALS"."CCLASS",   
         "CEN_OUT_MEALS"."NRESERVE_QUANTITY",   
         "CEN_OUT_MEALS"."NRESERVE_TYPE",   
         "CEN_OUT_MEALS"."NTOPOFF_QUANTITY",   
         "CEN_OUT_MEALS"."NTOPOFF_TYPE",   
         "CEN_OUT_MEALS"."NMODULE_TYPE",     
         "CEN_OUT_MEALS"."NPACKINGLIST_INDEX_KEY",   
         "CEN_OUT_MEALS"."CPACKINGLIST",   
         "CEN_OUT_MEALS"."CUNIT",   
         "CEN_OUT_MEALS"."CPRODUCTION_TEXT",   
         "CEN_OUT_MEALS"."NQUANTITY_GROUP",   
         "CEN_OUT_MEALS"."CREMARK",   
         "CEN_OUT_MEALS"."NPAX",   
         "CEN_OUT_MEALS"."NPAX_MANUAL",   
         "CEN_OUT_MEALS"."NMANUAL_INPUT",   
         "CEN_OUT_MEALS"."NMANUAL_PROCESSING",   
         "CEN_OUT_MEALS"."DTIMESTAMP",   
         "CEN_OUT_MEALS"."NSTATUS",   
         "CEN_OUT_MEALS"."CDESCRIPTION",   
         "CEN_OUT_MEALS"."NSPML_QUANTITY",   
         "CEN_OUT_MEALS"."NPLTYPE_KEY",   
         "CEN_OUT_MEALS"."NPL_KIND_KEY",   
         "CEN_OUT_MEALS"."NPACKINGLIST_KEY",   
         "CEN_OUT_MEALS"."NPACKINGLIST_DETAIL_KEY",   
         "CEN_OUT_MEALS"."CTEXT", 
         "CEN_OUT_MEALS"."CCUSTOMER_PL",   
         "CEN_OUT_MEALS"."CCUSTOMER_TEXT",   
         "CEN_PICTURES"."NPICTURE_INDEX_KEY",   
         "CEN_PACKINGLISTS"."CTEXT_SHORT"
         
   ORDER BY "CEN_OUT_MEALS"."NCLASS_NUMBER" ASC,
         "CEN_OUT_MEALS"."CTEXT"