SELECT	om.ndetail_key,
			ti.nto_itemlist_key,
			ti.ncategory_key,
			tc.ccategory,
			ti.nclass_number,
			om.cclass,
			ti.nsort,
			ti.nmodule_type,
			ti.npackinglist_index_key,
			om.cpackinglist,
			pl.ctext,
			om.nquantity
 FROM	cen_out_meals				om,
			cen_out						co,
			loc_unit_to_itemlist		ti,
			loc_unit_to_categories	tc,
			cen_packinglists			pl
WHERE	1=1
AND		om.nresult_key = :arg_result_key
AND		om.ninput_from_top_off = 1
AND		om.nresult_key = co.nresult_key
AND		co.cunit = ti.cunit
AND		co.nairline_key = ti.nairline_key
AND		om.nclass_number = ti.nclass_number
AND		om.npackinglist_index_key = ti.npackinglist_index_key
AND		ti.dvalid_from <= co.ddeparture
AND		ti.dvalid_to >= co.ddeparture
AND		ti.npackinglist_index_key = pl.npackinglist_index_key
AND		pl.dvalid_from <= co.ddeparture
AND		pl.dvalid_to >= co.ddeparture
AND		ti.ncategory_key = tc.ncategory_key