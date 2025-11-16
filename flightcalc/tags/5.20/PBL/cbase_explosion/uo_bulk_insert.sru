HA$PBExportHeader$uo_bulk_insert.sru
forward
global type uo_bulk_insert from transaction
end type
end forward

global type uo_bulk_insert from transaction
end type
global uo_bulk_insert uo_bulk_insert

type prototypes
FUNCTION string pf_bulk_ins_cen_out_master (LONGLONG lll_arg1[], &
													long ll_arg2[], &
													long ll_arg3[], &
													long ll_arg4[], &
									 				long ll_arg5[], &
													long ll_arg6[], &
													long ll_arg7[], &
													string ls_arg8[], &
													string ls_arg9[], &
													string ls_arg10[], &
													double ll_arg11[], &
													long ll_arg12[], &
													long ll_arg13[], &
													long ll_arg14[], &
													double ll_arg15[], &
													long ll_arg16[], &
													datetime ld_arg17[], &
													long ll_arg18[], &
													long ll_arg19[], &
													long ll_arg20[], &
													long ll_arg21[], &
													long ll_arg22[], &
													long ll_arg23[], &
													long ll_arg24[], &
													long ll_arg25[], &
													string ls_arg26[], &
													long ll_arg27[], &
													string ls_arg28[], &
													string ls_arg29[], &
													long ll_arg30[], &
													string ls_arg31[], &
													long ll_arg32[], &
													string ls_arg33[], &
													double ll_arg34[], &
													double ll_arg35[], &
													double ll_arg36[], &
													double ll_arg37[], &
													double ll_arg38[], &
													double ll_arg39[], &
													double ll_arg40[], &
													long ll_arg41[], &
													string ls_arg42[], &
													LONGLONG lll_arg43[], &
													LONGLONG lll_arg44[], &
													long ll_arg45[], &
													long ll_arg46[], &
													long ll_arg47[], &
													long ll_arg48[], &
													string ls_arg49[], &
													string ls_arg50[], &
													string ls_arg51[]) RPCFUNC alias for "cbase.CBASE_EXPLOSION.pf_bulk_ins_cen_out_master"
end prototypes

type variables
string is_caccount[]
string is_cclass[]
string is_ccode[]
string is_ccustomer_pl[]
string is_ccustomer_pl_text[]
string is_cdef_storage_location[]
string is_cgoods_recipient[]
string is_cloadinglist[]
string is_cpackinglist[]
string is_cpost_type_short[]
string is_csales_rel[]
string is_ctext[]
string is_cunit[]
datetime id_dtimestamp[]
long il_naccount_key[]
long il_naction[]
LONGLONG ill_nancestor_detail_key[]
long il_nancestor_index_key[]
long il_narea_key[]
decimal idec_nbilling_price[]
long il_nclass_number[]
decimal idec_ncost_price[]
LONGLONG ill_ndetail_key[]
decimal idec_ndiscount[]
long il_nfreq_key[]
long il_nhandling_id[]
long il_nlevel[]
long il_nmanual_input[]
LONGLONG ill_nmaster_detail_key[]
long il_nmaster_index_key[]
long il_npackinglist_key[]
long il_nparams_key1[]
long il_nparams_key2[]
long il_nparams_key3[]
long il_nparams_min[]
long il_npercent[]
long il_npl_detail_key[]
long il_npl_index_key[]
long il_npl_kind_key[]
long il_npl_type[]
decimal idec_nportfee[]
decimal idec_nquantity[]
long il_nreckoning[]
decimal idec_nremittanceprice[]
decimal idec_nreserve[]
long il_nresult_key[]
decimal idec_nsales_price[]
long il_nstatus[]
long il_nsysaccount_key[]
long il_ntransaction[]
long il_nvat_key[]
long il_nvat_key_portfee[]
decimal idec_nvat_value[]
long il_nvat_value_portfee[]
long il_nworkstation_key[]

Long il_rows_loaded

end variables

forward prototypes
public function long of_load_arrays (datastore lds_data)
public function integer of_connect (transaction arg_transaction)
public function string of_bulk_insert ()
end prototypes

public function long of_load_arrays (datastore lds_data);/*
* Objekt : uo_bulk_insert
* Methode: of_load_arrays (Function)
* Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
* Datum  : 07.03.2012
*
* Argument(e):
*
* Beschreibung: F$$HEX1$$fc00$$ENDHEX$$llt die Arrays f$$HEX1$$fc00$$ENDHEX$$r die PLSQL Bulk Update Funktion
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        KLaus F$$HEX1$$f600$$ENDHEX$$rster    07.03.2012    Erstellung
*   1.1        Klaus Winckler   18.12.2012    Wertebereich LONGLONG
*
* Return: 
*   Anzahl  Zeilen im Array
*/

Long a, i, ll_row, ll_rows, ll_dummy[]
string	ls_dummy[]
decimal ld_dummy[]

ll_rows = lds_data.RowCount()

for i = 1 to ll_rows
	Setnull(ll_dummy[i])	 
	Setnull(ls_dummy[i])
	Setnull(ld_dummy[i])
	
next


is_caccount 					= lds_data.object.caccount[1, ll_rows]
is_cclass 						= lds_data.object.cclass[1, ll_rows]
is_ccode 						= ls_dummy
is_ccustomer_pl 				= lds_data.object.ccustomer_pl[1, ll_rows]
is_ccustomer_pl_text 			= lds_data.object.ccustomer_pl_text[1, ll_rows]
is_cdef_storage_location 	= lds_data.object.cdef_storage_location[1, ll_rows]
is_cgoods_recipient 			= lds_data.object.cgoods_recipient[1, ll_rows]
is_cloadinglist 					= lds_data.object.cloadinglist[1, ll_rows]
is_cpackinglist 					= lds_data.object.cpackinglist[1, ll_rows]
is_cpost_type_short 			= lds_data.object.cpost_type_short[1, ll_rows]
is_csales_rel 					= lds_data.object.csales_rel[1, ll_rows]
is_ctext 							= lds_data.object.ctext[1, ll_rows]
is_cunit 							= lds_data.object.cunit[1, ll_rows]
id_dtimestamp 					= lds_data.object.dtimestamp[1, ll_rows]
il_naccount_key 				= lds_data.object.naccount_key[1, ll_rows]
il_naction 						= lds_data.object.naction[1, ll_rows]
ill_nancestor_detail_key 		= lds_data.object.nancestor_detail_key[1, ll_rows] // Wertebereich
il_nancestor_index_key 		= lds_data.object.nancestor_index_key[1, ll_rows]
il_narea_key 					= lds_data.object.narea_key[1, ll_rows]
idec_nbilling_price 				= ld_dummy
il_nclass_number 				= lds_data.object.nclass_number[1, ll_rows]
idec_ncost_price 				= ld_dummy
ill_ndetail_key 					= lds_data.object.ndetail_key[1, ll_rows]  // Wertebereich 
idec_ndiscount	 				= ld_dummy
il_nfreq_key 					= lds_data.object.nfreq_key[1, ll_rows]
il_nhandling_id 					= lds_data.object.nhandling_id[1, ll_rows]
il_nlevel 							= lds_data.object.nlevel[1, ll_rows]
il_nmanual_input 				= ll_dummy
ill_nmaster_detail_key 		= lds_data.object.nmaster_detail_key[1, ll_rows] // Wertebereich
il_nmaster_index_key 			= lds_data.object.nmaster_index_key[1, ll_rows]
il_npackinglist_key 			= lds_data.object.npackinglist_key[1, ll_rows]
il_nparams_key1 				= lds_data.object.nparams_key1[1, ll_rows]
il_nparams_key2 				= lds_data.object.nparams_key2[1, ll_rows]
il_nparams_key3 				= lds_data.object.nparams_key3[1, ll_rows]
il_nparams_min 					= lds_data.object.nparams_min[1, ll_rows]
il_npercent 						= lds_data.object.npercent[1, ll_rows]
il_npl_detail_key 				= lds_data.object.npl_detail_key[1, ll_rows]
il_npl_index_key 				= lds_data.object.npl_index_key[1, ll_rows]
il_npl_kind_key 					= lds_data.object.npl_kind_key[1, ll_rows]
il_npl_type 						= lds_data.object.npl_type[1, ll_rows]
idec_nportfee 					= ld_dummy
idec_nquantity 					= lds_data.object.nquantity[1, ll_rows]
il_nreckoning 					= lds_data.object.nreckoning[1, ll_rows]
idec_nremittanceprice 		= ld_dummy
idec_nreserve 					= lds_data.object.nreserve[1, ll_rows]
il_nresult_key 					= lds_data.object.nresult_key[1, ll_rows]
idec_nsales_price 				= ld_dummy
il_nstatus 						= lds_data.object.nstatus[1, ll_rows]
il_nsysaccount_key 			= ll_dummy
il_ntransaction 					= lds_data.object.ntransaction[1, ll_rows] 
il_nvat_key 						= ld_dummy
il_nvat_key_portfee 			= ld_dummy
idec_nvat_value 				= ld_dummy
il_nvat_value_portfee 		= ld_dummy
il_nworkstation_key 			= lds_data.object.nworkstation_key[1, ll_rows]

//SetNull(il_nresult_key[1])

return Upperbound(il_nworkstation_key)
end function

public function integer of_connect (transaction arg_transaction);/*
* Objekt : uo_bulk_insert
* Methode: of_connect (Function)
* Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
* Datum  : 07.03.2012
*
* Argument(e):
*
* Beschreibung:  Bulk Update Funktion
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        KLaus F$$HEX1$$f600$$ENDHEX$$rster    07.03.2012    Erstellung
*
* Return: 
*   0 = OK, & -1 = Fehler
*/

this.ServerName 	= arg_transaction.ServerName
this.DBMS 			= arg_transaction.DBMS
this.DBParm 		= arg_transaction.DBParm
this.LogPass 		= arg_transaction.LogPass 
this.LogId 			= arg_transaction.LogId 	
this.AutoCommit 	= arg_transaction.AutoCommit

connect using this;

if this.SQLCode <> 0 then
	return -1
end if

return 0
end function

public function string of_bulk_insert ();/*
* Objekt : uo_bulk_insert
* Methode: of_bulk_update (Function)
* Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
* Datum  : 07.03.2012
*
* Argument(e):
*
* Beschreibung:  Bulk Update Funktion
*
* $$HEX1$$c400$$ENDHEX$$nderungshistorie:
*   Version    Wer          Wann          Was und warum
*   1.0        KLaus F$$HEX1$$f600$$ENDHEX$$rster    07.03.2012    Erstellung
*   1.1        Klaus Winckler   18.12.2012    Wertebereich LONGLONG
*
* Return: 
*   0 = OK, & -1 = Fehler
*/
String ls_ret
ls_ret = pf_bulk_ins_cen_out_master( this.ill_ndetail_key, &          
										this.il_ntransaction, &          
										this.il_nresult_key, &           
										this.il_npl_type, &              
										this.il_npl_index_key, &         
										this.il_npl_detail_key, &        
										this.il_nfreq_key, &             
										this.is_cpackinglist, &          
										this.is_ctext, &                 
										this.is_cunit, &                 
										this.idec_nquantity, &             
										this.il_naction, &               
										this.il_narea_key, &             
										this.il_nworkstation_key, &      
										this.idec_nreserve, &              
										this.il_nreckoning, &            
										this.id_dtimestamp, &            
										this.il_nstatus, &              
										this.il_nhandling_id, &          
										this.il_npl_kind_key, &          
										this.il_npackinglist_key, &      
										this.il_nmaster_index_key, &     
										this.il_nlevel, &                
										this.il_npercent, &              
										this.il_nancestor_index_key, &   
										this.is_cloadinglist, &          
										this.il_nmanual_input, &         
										this.is_ccustomer_pl, &          
										this.is_ccustomer_pl_text, &     
										this.il_naccount_key, &          
										this.is_caccount, &              
										this.il_nsysaccount_key, &       
										this.is_ccode, &                 
										this.idec_nsales_price, &          
										this.idec_nbilling_price, &        
										this.idec_nremittanceprice, &      
										this.idec_ndiscount, &             
										this.idec_nportfee, &              
										this.idec_nvat_value, &            
										this.idec_ncost_price, &           
										this.il_nclass_number, &         
										this.is_cclass, &                
										this.ill_nmaster_detail_key, &    
										this.ill_nancestor_detail_key, &  
										this.il_nparams_key1, &          
										this.il_nparams_key2, &          
										this.il_nparams_key3, &          
										this.il_nparams_min, &           
										this.is_csales_rel, &            
										this.is_cgoods_recipient, &      
										this.is_cdef_storage_location)

return ls_ret
end function

on uo_bulk_insert.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_bulk_insert.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

