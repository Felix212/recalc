  SELECT cen_packinglist_index_a.cpackinglist,
         cen_packinglists_b.ctext,
         cen_packinglist_detail.nquantity,
         cen_packinglist_pictures.npicture_index_key
    FROM cen_packinglist_detail,
         cen_packinglists cen_packinglists_a,
         cen_packinglist_index cen_packinglist_index_a,
         cen_packinglists cen_packinglists_b,
         cen_packinglist_pictures,
         cen_packinglist_index cen_packinglist_index_b,
         cen_pictures
   WHERE ( cen_packinglists_a.npackinglist_index_key = cen_packinglist_pictures.npackinglist_index_key (+)) and
         ( cen_packinglists_a.npackinglist_detail_key = cen_packinglist_pictures.npackinglist_detail_key (+)) and
         ( cen_packinglist_pictures.npicture_index_key = cen_pictures.npicture_index_key (+)) and
         ( cen_packinglist_detail.npackinglist_index_key = cen_packinglists_a.npackinglist_index_key ) and
         ( cen_packinglists_a.npackinglist_detail_key = cen_packinglist_detail.npackinglist_detail_key ) and
         ( cen_packinglist_detail.ndetail_key = cen_packinglist_index_a.npackinglist_index_key ) and
         ( cen_packinglists_b.npackinglist_index_key = cen_packinglist_index_a.npackinglist_index_key ) and
         ( cen_packinglist_index_b.npackinglist_index_key = cen_packinglists_a.npackinglist_index_key ) and
         ( ( cen_packinglists_a.npackinglist_index_key = :arg_index ) AND
         ( cen_packinglists_a.dvalid_from <= :arg_date ) AND
         ( cen_packinglists_a.dvalid_to >= :arg_date ) AND
         ( cen_packinglists_b.dvalid_from <= :arg_date ) AND
         ( cen_packinglists_b.dvalid_to >= :arg_date ) AND
         ( cen_packinglist_detail.dvalid_from <= :arg_date ) AND
         ( cen_packinglist_detail.dvalid_to >= :arg_date ) AND
         ( cen_packinglist_detail.nreckoning in ( :arg_reckoning )  OR
          -1 in ( :arg_reckoning ) ) )
ORDER BY cen_packinglist_detail.nsort ASC

/** comment */
/**
 * remove columns from original query 'dw_uo_dl_packinglist_contents', not needed here
 */
