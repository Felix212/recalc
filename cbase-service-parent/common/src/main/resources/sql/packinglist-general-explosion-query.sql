select tab_pl.npackinglist_index_key,
		tab_pl.npackinglist_detail_key,
		tab_pl.cpackinglist,
		tab_pl.nlevel,
		tab_pl.npackinglist_key,
		tab_pl.clevel,
		tab_pl.ctype,
		tab_pl.nsort,
		tab_pl.nquantity	,
		tab_pl.cunit,
		tab_pl.nquantity_cal,
		tab_pl.nreckoning,
		tab_pl.nworkstation_key,
		tab_pl.narea_key,
		tab_pl.ctext
from table (CBASE_GENERAL.PF_EXPLODE_PACKINGLIST(:arg_index, :arg_date, :arg_include_self, :arg_base_quantity)) tab_pl,
			cen_packinglists
where  tab_pl.npackinglist_index_key = cen_packinglists.npackinglist_index_key and
		tab_pl.npackinglist_detail_key = cen_packinglists.npackinglist_detail_key and
		trim(cpackinglist) <> 'Z'
order by nsort		
