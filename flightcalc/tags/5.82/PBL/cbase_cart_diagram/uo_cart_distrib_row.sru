HA$PBExportHeader$uo_cart_distrib_row.sru
forward
global type uo_cart_distrib_row from nonvisualobject
end type
end forward

global type uo_cart_distrib_row from nonvisualobject
end type
global uo_cart_distrib_row uo_cart_distrib_row

type variables
/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode:  (Declaration)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
* none
*
* Return: none
*
*
*
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*  19.11.2009	1.1           Ulrich Paudler     Drawerfood und Traynonfood eingebaut
*  07.12.2010	1.2           Oliver H$$HEX1$$f600$$ENDHEX$$fer       Drawer Multi Rung
*
*************************************************************/
CONSTANT Long EMPTY					= 0
CONSTANT Long DRAWER					= 1
CONSTANT Long TRAY					= 2
CONSTANT Long DRAWERFOOD			= 3
CONSTANT Long TRAYNONFOOD			= 4
CONSTANT Long BLOCKED				= 9
CONSTANT Long DRAWER_MULTI_RUNG	= 13
CONSTANT Long NOSPACELEFT			= -9999999


private:
				Long		il_Length
				Long		ilOrder
				Long		ilType

Public		n_doc_gen_settings	inv_doc_gen_settings
Protected	s_distrib_items		istr_item[]
Public		Long		il_Disable_Debug = 1 //0
Public		Boolean	ib_use_doc_gen_settings
Public		String	is_user
Public		String	is_section = ""
Protected	String	isCartDiagramComponentDisplay = ""
PUBLIC		Boolean	ib_suppress_qty_1 = FALSE

end variables

forward prototypes
public function long of_get_order ()
public function long of_set_order (long arg_l_order)
public function long of_set_type (long arg_l_type)
public function string of_get_row_item ()
public function long of_get_type ()
public function long of_get_row (ref s_distrib_items ref_str_item[])
public function long of_set_item (s_distrib_items arg_str_item[])
public function long of_combine_item ()
public function long of_get_limit ()
public function long of_check_row_limit (s_distrib_item_props arg_str_props)
public function long of_check_row_limit ()
public function long of_get_count_limit ()
public function long of_set_length (long arg_l_length)
public function long of_get_length ()
public function long of_get_reserved_length ()
public function long of_get_unused_length ()
public function long of_check_row (long arg_l_length)
public function long of_check_row_item (s_distrib_item_props arg_str_props, long al_min_fit_factor)
public function integer of_compress ()
public function string of_profilestring (string suser, string ssection, string skey, string sdefault)
public function string of_get_item_description (s_component arg_str_component)
public function integer of_include_subitems (ref s_distrib_items rastr_items[])
public function long of_add_row_item (long arg_l_length, string arg_s_item, long arg_l_show, s_distrib_item_sub astr_sub[])
public function long of_get_row_without_sub (ref s_distrib_items ref_str_item[])
public function long of_add_row_item (long arg_l_length, string arg_s_item, long arg_l_show, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text)
public function long of_set_row_item (long arg_l_length, string arg_s_item, long arg_l_show, long arg_l_index, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text, boolean ab_bold, string as_code)
public function integer of_extend_array ()
end prototypes

public function long of_get_order ();/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_get_order (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
* none
*
* Return: long
*
*
* R$$HEX1$$fc00$$ENDHEX$$ckgabe der Order der Row
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/


return ilOrder
	


end function

public function long of_set_order (long arg_l_order);/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_set_order (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
* long arg_l_order
*
* Return: long
*
*
* Order der Row setzen, die Order wird bei der Mahlzeitenverteilung verwendet
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

ilOrder = arg_l_order

return ilOrder
	


end function

public function long of_set_type (long arg_l_type);/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_set_type (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
* long arg_l_type
*
* Return: long
*
*
* Typ des Einschubs setzen
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*  08.12.2010	1.1           Oliver H$$HEX1$$f600$$ENDHEX$$fer       Typ MULTI RUNG hinzu
*
*************************************************************/

choose case arg_l_type
	case TRAY, DRAWERFOOD
		ilType = arg_l_type

	case DRAWER_MULTI_RUNG
		ilType = arg_l_type
	
	case else
		ilType = EMPTY
		
end choose

return ilType
	


end function

public function string of_get_row_item ();/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_get_row_item (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
*
* Return: long
*
*
* Items einer Row aneinander ketten und zur$$HEX1$$fc00$$ENDHEX$$ckgeben
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

String	ls_Item = ""
long		ll_Count, ll_Index

ll_Count = upperbound(istr_item)
for ll_Index = 1 to ll_Count
	if len(ls_Item) = 0 then 
		ls_Item = istr_item[ll_Index].sitem
	else
		ls_Item =", " + istr_item[ll_Index].sitem
	end if
next


Return  ls_Item
	


end function

public function long of_get_type ();/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_get_type (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
*
* Return: long
*
*
* Typ des Einschubs in dieser Row zur$$HEX1$$fc00$$ENDHEX$$ckgeben
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

return ilType
	


end function

public function long of_get_row (ref s_distrib_items ref_str_item[]);/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_get_row (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* ref s_distrib_row ref_str_row[]
*
* Return: long
*
*
* Attribute der Row ermitteln und per Referenz zur$$HEX1$$fc00$$ENDHEX$$ckgeben 
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

Integer	li_Succ

// L$$HEX1$$fc00$$ENDHEX$$cken Schliessen
li_Succ = of_compress()

// Inhalte hineintricksen
li_Succ = of_include_subitems(ref_str_item)


Return  upperbound(istr_item)
	


end function

public function long of_set_item (s_distrib_items arg_str_item[]);/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_set_item (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* s_distrib_items arg_str_item[]
*
* Return: long
*
*
* Attribute der Row setzen. Diese werden bei 
* der Mahlzeitenverteilung als Verteilungsfilter verwendet
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler    Erstellung
*  14.01.2010	1.1           Ulrich Paudler    lcount hinzu
*
*************************************************************/

Long llIndex

if il_Disable_Debug = 0 Then
		f_trace("uo_cart_distrib_row.of_set_item  upperbound(arg_str_item)=" + String( upperbound(arg_str_item)))
	end if

for llindex = 1 to upperbound(arg_str_item)
	if il_Disable_Debug = 0 Then
		f_trace("uo_cart_distrib_row.of_set_item Row " + String(llindex))
	end if
	
	istr_item[llindex].str_prop.stext 					= arg_str_item[llindex].str_prop.stext 
	istr_item[llindex].str_prop.smeal_control_code	= arg_str_item[llindex].str_prop.smeal_control_code
	istr_item[llindex].str_prop.sclass 					= arg_str_item[llindex].str_prop.sclass 
	istr_item[llindex].str_prop.lspml 					= arg_str_item[llindex].str_prop.lspml 
	istr_item[llindex].str_prop.llimit					= arg_str_item[llindex].str_prop.llimit
	
	istr_item[llindex].str_prop.lremaining				= arg_str_item[llindex].str_prop.llimit
	
	if il_Disable_Debug = 0 Then
		If not isnull(arg_str_item[llindex].str_prop.sclass) and TRIM(arg_str_item[llindex].str_prop.sclass) > "" then
			f_trace("uo_cart_distrib_row.of_set_item " + istr_item[llindex].str_prop.stext + " / " + istr_item[llindex].str_prop.smeal_control_code &
					+ " / " + istr_item[llindex].str_prop.sclass +"/"+ String(istr_item[llIndex].str_prop.llimit) +  "x/" + String(istr_item[llIndex].str_prop.lremaining ))	
		Else
			If Trim(istr_item[llindex].str_prop.stext) > "" Then
				f_trace("uo_cart_distrib_row.of_set_item " + istr_item[llindex].str_prop.stext + " / " + istr_item[llindex].str_prop.smeal_control_code)
			End If
		End If
	end if
next


return llindex
	


end function

public function long of_combine_item ();/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_combine_item (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 16.11.2009
* Argument(e):
* s_distrib_items arg_str_item[]
*
* Return: long
*
*
* Zusammenfassen von Items, Gleiche Items werden summiert.
* Dient der Anzeige der Items z.b. 5 x HM1234
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  16.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

Long		ll_Index
Long		ll_InnerIndex
Long  	ll_MaxIndex


ll_MaxIndex = upperbound(istr_item)

for ll_Index = 1 to ll_MaxIndex
	for  ll_InnerIndex =  ll_MaxIndex to 1 step -1
		if ll_InnerIndex <= ll_Index then exit
		if istr_item[ll_Index].sitem=  istr_item[ll_InnerIndex].sitem and istr_item[ll_InnerIndex].lcount > 0  then
			istr_item[ll_Index].lcount = istr_item[ll_Index].lcount + istr_item[ll_InnerIndex].lcount
			istr_item[ll_InnerIndex].lcount = 0
			
			if il_Disable_Debug = 0 Then
				f_trace("uo_cart_distrib_row.of_combine_item " + istr_item[ll_InnerIndex].sitem)
			end if
			
		end if
	next
next


return 0
	


end function

public function long of_get_limit ();/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_get_limit (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 18.01.2010
* Argument(e):
* none
*
* Return: long
*
*
*
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  18.01.2010	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/


return 0
	


end function

public function long of_check_row_limit (s_distrib_item_props arg_str_props);/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_check_row_limit (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 18.01.2010
* Argument(e):
* s_distrib_item_props arg_str_props
*
* Return: long
*
* gibt das Limit des Platzes zur$$HEX1$$fc00$$ENDHEX$$ck
* wenn 0   dann soll die Gr$$HEX2$$f600df00$$ENDHEX$$e anhand der Dimension ermittelt werden
* Wenn > 0 dann ist die R$$HEX1$$fc00$$ENDHEX$$ckgabe die Anzahl der Einheiten
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  18.01.2010	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

Long llLimit = 0
Long llIndex

// Nachsehen ob ein Item mit Limit gesetzt ist
for llIndex = 1 to upperbound(istr_item)
	if istr_item[llIndex].str_prop.llimit = 0 then
		continue
	else
		 llLimit =  istr_item[llIndex].str_prop.llimit 
	end if
next
	

 return llLimit
	


end function

public function long of_check_row_limit ();/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_check_row_limit (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 18.01.2010
* Argument(e):
*
* Return: long
*
* gibt das Limit des Platzes zur$$HEX1$$fc00$$ENDHEX$$ck
* wenn 0   dann soll die Gr$$HEX2$$f600df00$$ENDHEX$$e anhand der Dimension ermittelt werden
* Wenn > 0 dann ist die R$$HEX1$$fc00$$ENDHEX$$ckgabe die Anzahl der Einheiten
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  18.01.2010	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llLimit = 0
Long llIndex

// Nachsehen ob ein Item mit Limit gesetzt ist
for llIndex = 1 to upperbound(istr_item)
	if istr_item[llIndex].str_prop.llimit = 0 then
		continue
	else
		 llLimit =  istr_item[llIndex].str_prop.llimit 
	end if
next
	

 return llLimit
	


end function

public function long of_get_count_limit ();/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_get_count_limit (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 20.01.2010
* Argument(e):
* none
*
* Return: long
*
*
* Summiert die Limits der reservierten & belegten Items
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  20.01.2010	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

Long llIndex, llLimit = 0

for llIndex = 1 to upperbound(istr_item)
//	if istr_item[llIndex].lcount > 0 then
		llLimit = llLimit + istr_item[llIndex].str_prop.llimit
//	end if
next

return llLimit
	


end function

public function long of_set_length (long arg_l_length);/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_set_length (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
* none
*
* Return: long
*
*
* L$$HEX1$$e400$$ENDHEX$$nge der Row setzen
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

il_Length = arg_l_length

return il_Length
	


end function

public function long of_get_length ();/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_get_length (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
* none
*
* Return: long
*
*
* L$$HEX1$$e400$$ENDHEX$$nge der Row zur$$HEX1$$fc00$$ENDHEX$$ckgeben
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

return il_Length
	


end function

public function long of_get_reserved_length ();/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_get_reserved_length (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
* none
*
* Return: long
*
*
* Summiert die L$$HEX1$$e400$$ENDHEX$$ngen der schon enthaltenen Items
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long llIndex, llLength = 0

for llIndex = 1 to upperbound(istr_item)
	llLength = llLength + istr_item[llIndex].llength
next

return llLength
	


end function

public function long of_get_unused_length ();/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_get_unused_length (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
* none
*
* Return: long
*
*
* noch freie L$$HEX1$$e400$$ENDHEX$$nge der Row zur$$HEX1$$fc00$$ENDHEX$$ckgeben
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
Long	ll_Length
Long	ll_len_1, ll_len_2


ll_Length = of_get_length() - of_get_reserved_length()

ll_len_1 = of_get_length()
ll_len_2 = of_get_reserved_length()

if il_Disable_Debug = 0 Then
	f_trace("uo_cart_distrib_row.of_get_unused_length Return=" + String(ll_Length) + " of_get_length " + String(ll_len_1) + " of_get_reserved_length " + String(ll_len_2) )
End If


Return ll_Length 
	


end function

public function long of_check_row (long arg_l_length);/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_check_row (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
* long arg_l_length
*
* Return: long
*
*
* gibt den verbleibenden Platz zur$$HEX1$$fc00$$ENDHEX$$ck
* wenn < 0   dann ist die R$$HEX1$$fc00$$ENDHEX$$ckgabe der fehlende Platz
* Wenn > 0 dann ist die R$$HEX1$$fc00$$ENDHEX$$ckgabe der noch $$HEX1$$fc00$$ENDHEX$$brige Platz
* wenn 0 dann ist die Schiene komplett belegt
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*  28.02.2011  1.1           Oliver H$$HEX1$$f600$$ENDHEX$$fer       Ignoriere "reservierte Pl$$HEX1$$e400$$ENDHEX$$tze"
*
*************************************************************/

Long llLength = 0

//// L$$HEX1$$e400$$ENDHEX$$nge nur dann ermitteln wenn keine Reservierten Pl$$HEX1$$e400$$ENDHEX$$tze existieren
//if of_get_count_limit() > 0 then
//	llLength = NOSPACELEFT
//else
	llLength = of_get_unused_length() - arg_l_length
//end if

return llLength
	


end function

public function long of_check_row_item (s_distrib_item_props arg_str_props, long al_min_fit_factor);/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_check_row_item (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* s_distrib_item_props arg_str_props
*
* Return: long
*
*
* Pr$$HEX1$$fc00$$ENDHEX$$ft ob das Item f$$HEX1$$fc00$$ENDHEX$$r diese Position erlaubt ist
* >= Vergleich der Einschr$$HEX1$$e400$$ENDHEX$$nkungskriterien: Passt die Position zum Item? 
*
* FitFactor kennzeichnet dabei die G$$HEX1$$fc00$$ENDHEX$$te der $$HEX1$$dc00$$ENDHEX$$bereinstimmung 0 (keine) - 4  (absolute)
* FitIndex ist die Position im Tray
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*  18.01.2010	1.1           Ulrich Paudler     Limit ber$$HEX1$$fc00$$ENDHEX$$cksichtigen
*  09.02.2011  1.2           Oliver H$$HEX1$$f600$$ENDHEX$$fer       Option: Mindest-Fit-Factor
*
*************************************************************/
Long llIndex
Long llFitfactor = 0, llFitIndex = 0
Boolean	lb_Breakpoint

for llIndex = 1 to upperbound(istr_item)
	If il_Disable_Debug = 0 Then
		If al_min_fit_factor < 4 then
			If NOT IsNULL(istr_item[llIndex].str_prop.stext) AND istr_item[llIndex].str_prop.stext > "" Then
				f_trace("uo_cart_distrib_row.of_check_row_item " + istr_item[llIndex].str_prop.stext + "/" + istr_item[llIndex].str_prop.smeal_control_code + &
					"/" + istr_item[llIndex].str_prop.sclass + " (" + arg_str_props.stext + "/" + arg_str_props.smeal_control_code + "/" + arg_str_props.sclass + ") " &
						+ String(istr_item[llIndex].str_prop.llimit) +  "x/" + String(istr_item[llIndex].str_prop.lremaining ) + "x")
			else
				f_trace("uo_cart_distrib_row.of_check_row_item " + istr_item[llIndex].str_prop.stext + "/" + istr_item[llIndex].str_prop.smeal_control_code + &
					"/" + istr_item[llIndex].str_prop.sclass + " (" + arg_str_props.stext + "/" + arg_str_props.smeal_control_code + "/" + arg_str_props.sclass + ") " &
						+ String(istr_item[llIndex].str_prop.llimit) +  "x/" + String(istr_item[llIndex].str_prop.lremaining ) + "x)")

			end if
		End If
	End If
	
	// Schon belegt?
	// 18.01.2010 Ulrich Paudler [UP] Limit darf f$$HEX1$$fc00$$ENDHEX$$r die L$$HEX1$$e400$$ENDHEX$$ngenpr$$HEX1$$fc00$$ENDHEX$$fung nicht gesetzt sein
	if istr_item[llIndex].llength > 0 and of_get_count_limit() = 0 then
		If il_Disable_Debug = 0 Then f_trace("uo_cart_distrib_row.of_check_row_item istr_item[" + String(llIndex) + "].llength > 0 and of_get_count_limit() = 0 CONTINUE")
		continue
	end if
	
	if istr_item[llIndex].str_prop.llimit > 0 then
		if istr_item[llIndex].lcount >= istr_item[llIndex].str_prop.llimit then
			// Platz ist vollst$$HEX1$$e400$$ENDHEX$$ndig belegt - weiter
			If il_Disable_Debug = 0 Then f_trace("uo_cart_distrib_row.of_check_row_item istr_item[" + String(llIndex) + "].lcount >= istr_item[" + String(llIndex) + "].str_prop.llimit ALLES BELEGT CHECK REMAINING")
			// ###TEST KEIN CONTINUE###
			//continue
				
		end if
	end if
	
	// Test - Restpl$$HEX1$$e400$$ENDHEX$$tze 
	if istr_item[llIndex].str_prop.llimit > 0 then
		if istr_item[llIndex].str_prop.lremaining < 1 then
			// Platz ist vollst$$HEX1$$e400$$ENDHEX$$ndig belegt - weiter
			If il_Disable_Debug = 0 Then f_trace("uo_cart_distrib_row.of_check_row_item istr_item[" + String(llIndex) + "].str_prop.lremaining < 1 ALLES BELEGT CONTINUE")
			continue
		end if
	end if
	
	// Text testen
	if istr_item[llIndex].str_prop.stext = "" or isNull( istr_item[llIndex].str_prop.stext) then
		// Keine Einschr$$HEX1$$e400$$ENDHEX$$nkung - weiter
		continue
	end if
	if istr_item[llIndex].str_prop.stext = arg_str_props.stext then
		if llFitfactor < 1 then
			llFitfactor = 1
			llFitIndex = llIndex
		end if
	else
		continue
	end if
	
	// Control Code testen
	if istr_item[llIndex].str_prop.smeal_control_code = "" then
		continue
	end if
	if istr_item[llIndex].str_prop.smeal_control_code = arg_str_props.smeal_control_code then
		if llFitfactor < 2 then
			llFitfactor = 2
			llFitIndex = llIndex
		end if
	else
		continue
	end if
	
	// Class testen
	if istr_item[llIndex].str_prop.sclass = "" then
		// Keine Einschr$$HEX1$$e400$$ENDHEX$$nkung - weiter
		continue
	end if
	if istr_item[llIndex].str_prop.sclass = arg_str_props.sclass then
		if llFitfactor < 3 then
			llFitfactor = 3
			llFitIndex = llIndex
		end if
	else
		continue
	end if
	
	// SPML testen
	if isnull(istr_item[llIndex].str_prop.lspml)	Then istr_item[llIndex].str_prop.lspml = 0 
	if isnull(arg_str_props.lspml)					Then arg_str_props.lspml = 0 
	
	if istr_item[llIndex].str_prop.lspml = arg_str_props.lspml then
		if llFitfactor < 4 then
			llFitfactor = 4
			llFitIndex = llIndex
		end if
	else
		continue
	end if
	
	// Best fit gefunden, keine weitere Suche notwendig
	if llFitfactor = 4 then 
		exit
	end if
next

//if llFitfactor > 0 then
//	return llFitIndex
//end if

if llFitfactor > 0 Then
	If il_Disable_Debug = 0 Then
		f_trace("uo_cart_distrib_row.of_check_row_item istr_item[" + String(llFitIndex) + "].str_prop.lremaining " + String(istr_item[llFitIndex].str_prop.lremaining))
	End If
End If


If al_min_fit_factor > 0 then

	if llFitfactor >= al_min_fit_factor then
		If il_Disable_Debug = 0 Then
			f_trace("uo_cart_distrib_row.of_check_row_item OK llFitIndex " + String(llFitIndex))
		End If
		return llFitIndex
	else
		If il_Disable_Debug = 0 AND al_min_fit_factor < 4 then f_trace("uo_cart_distrib_row.of_check_row_item al_min_fit_factor " + String(al_min_fit_factor) +  " llFitIndex " + String(llFitIndex))
	end if

else
	
	if llFitfactor > 0 then
		Return llFitIndex
	end if

end if

Return 0

end function

public function integer of_compress ();/*
* Objekt : uo_cart_distrib_row
* Methode: of_compress (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.02.2011
*
* Argument(e):
* none
*
* Beschreibung:		Testweise L$$HEX1$$fc00$$ENDHEX$$cken schliessen
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.02.2011		Erstellung
*
*
* Return: integer
*
*/

// L$$HEX1$$fc00$$ENDHEX$$cken schliessen


Long					ll_Count
s_distrib_items 	lstr_item[], lstr_empty[]


lstr_item = istr_item

//if il_Disable_Debug = 0 Then f_trace("uo_cart_distrib_row of_compress " + String(upperbound(istr_item)))

istr_item = lstr_empty


For ll_Count = 1 To upperbound(lstr_item)
	
	if il_Disable_Debug = 0 Then
		If NOT Isnull(lstr_item[ll_Count].sitem) AND lstr_item[ll_Count].sitem > "" AND lstr_item[ll_Count].cpackinglist > "" AND lstr_item[ll_Count].ctext > ""  Then
			f_trace("uo_cart_distrib_row of_compress " + String(ll_Count) + ": " + String(lstr_item[ll_Count].lcount) + " / "+ lstr_item[ll_Count].cpackinglist + " / " + lstr_item[ll_Count].ctext )
		end if
	end if
	
	
If 	NOT Isnull(lstr_item[ll_Count].sitem) AND &
		lstr_item[ll_Count].sitem > "" AND &
		lstr_item[ll_Count].cpackinglist > "" AND &
		lstr_item[ll_Count].ctext > "" AND & 
		lstr_item[ll_Count].lcount > 0 Then
				
		istr_item[upperbound(istr_item) + 1] = lstr_item[ll_Count]
	Else
		lstr_empty[upperbound(lstr_empty) + 1] = lstr_item[ll_Count]
	End If
Next

// Leere hinten anh$$HEX1$$e400$$ENDHEX$$ngen
For ll_Count = 1 To upperbound(lstr_empty)
	istr_item[upperbound(istr_item) + 1] = lstr_empty[ll_Count]
Next

// Kennzeichen "verteilt"
For ll_Count = 1 To upperbound(istr_item)
	istr_item[ll_Count].bdistributed = TRUE
Next


Return 1

end function

public function string of_profilestring (string suser, string ssection, string skey, string sdefault);// --------------------------------------------------------------------------------
// Objekt : 
// Methode: of_profilestring (Function)
// Autor  : Klaus F$$HEX1$$f600$$ENDHEX$$rster
// --------------------------------------------------------------------------------
// Argument(e):
// none
// --------------------------------------------------------------------------------
// Return: integer
// --------------------------------------------------------------------------------
//  Beschreibung:
//
// --------------------------------------------------------------------------------
//  Modifikationen:
//  Datum    Version        Autor              Kommentar
// --------------------------------------------------------------------------------
//  27.03.2009	            Klaus F$$HEX1$$f600$$ENDHEX$$rster        Erstellung
//
// --------------------------------------------------------------------------------
string	sValue
Long lUserID


Select nuser_id into :lUserID from sys_login where cusername = :sUser;

if sqlca.sqlcode <> 0 Then
//	this.of_log("of_profilestring failed: " + sqlca.sqlerrtext)
	return sDefault
End If

Select 	cValue 
into 		:sValue 
from		loc_setup
where		nuser_id		= :lUserID	and
			cSection		= :sSection			and
			cKey			= :sKey;

If SQLCA.SQLCode = 100 Then
	sValue = sDefault
End If	


return sValue
end function

public function string of_get_item_description (s_component arg_str_component);/*************************************************************
* Objekt : uo_cart_diagram
* Methode: of_get_item_description (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 11.01.2010
* Argument(e):
* s_component arg_str_component
*
* Return: integer
*
*
* Aus dem Profil die Konfiguration laden und anwenden 
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  11.01.2010	1.0           Ulrich Paudler     Erstellung
*  10.02.2010	1.1           Ulrich Paudler     Quantity, wenn vorhanden, hinzuf$$HEX1$$fc00$$ENDHEX$$gen
*  15.02.2010	1.2           Ulrich Paudler     Im Editmode auf Standard schalten
*  06.02.2012	1.3           Oliver H$$HEX1$$f600$$ENDHEX$$fer       Section f$$HEX1$$fc00$$ENDHEX$$r WEB
*  20.08.2012	1.4           Oliver H$$HEX1$$f600$$ENDHEX$$fer       CBASE-NAM-CR-12002 - Qty 1 anzeigen
*
*************************************************************/
string	ls_Value, ls_ArgItem, ls_section, ls_Default
integer	li_config


// ----------------------------------------------------------------------
// 24.01.2012 bei Doc Gen Service nicht aus Profile, sondern Parameter
// ----------------------------------------------------------------------
If ib_use_doc_gen_settings Then
	ls_Value = String(inv_doc_gen_settings.il_ncart_component_display )
	//	if ibEdit Then		ls_Value = "0"
Else
	If Trim(isCartDiagramComponentDisplay) > "" then
		// Use cached value
		ls_Value = isCartDiagramComponentDisplay
	Else
		If is_section > "" Then
			ls_section = is_section
		Else
			ls_section = of_profilestring(s_app.suser,"settings_master", "ACTIVESETUP", "docbrowser")
			if trim(ls_section) = "" Then ls_section = "docbrowser"
		end if
	
		if ls_section <> "docbrowser" Then
			li_config = integer(Mid(ls_section,11))
			ls_Default ="Default" +string(li_config)
		Else
			ls_Default ="Default"
		End If
		
		ls_Value =  of_profilestring(s_app.suser,ls_Default,"CartDiagramComponentDisplay","0") 
		isCartDiagramComponentDisplay = ls_Value
	End If
End If

if ls_Value = "0" Then
	ls_ArgItem = arg_str_component.ssnr + " - " + arg_str_component.stext
Elseif ls_Value = "1" Then
	ls_ArgItem = arg_str_component.ssnr
Elseif ls_Value = "2" Then
	ls_ArgItem = arg_str_component.stext	
End If

If il_Disable_Debug = 0 Then f_trace("uo_cart_distrib_row.of_get_item_description user=" + s_app.suser + " section=" + ls_Default + " value=" + ls_Value)

// NAM CR 12002 show Qty 1
If isNull(arg_str_component.squantity) Then arg_str_component.squantity = ""
If ib_suppress_qty_1 = FALSE OR arg_str_component.squantity <> "1" Then
	If arg_str_component.squantity <> "0" AND Trim(arg_str_component.squantity) > "" then
		ls_ArgItem = arg_str_component.squantity + " x " + ls_ArgItem
	End if
End if

if il_Disable_Debug = 0 Then f_trace("uo_cart_distrib_row.of_get_item_description " + ls_ArgItem)


Return ls_ArgItem

end function

public function integer of_include_subitems (ref s_distrib_items rastr_items[]);/*
* Objekt : uo_cart_distrib_row
* Methode: of_include_subitems (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 16.02.2011
*
* Argument(e):
* none
*
* Beschreibung:		"Explosion" Inhalte dazuschummeln
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	16.02.2011		Erstellung
*
*
* Return: integer
*
*/

Long	ll_Number_of_Entries
Long	ll_Count, ll_Count_Sub
Long	ll_Target_index
String	ls_Computed_Item
s_component	lstr_component_x
s_distrib_items 	lstr_item[], lstr_empty[]


//rastr_items[ll_Test_Index].str_cont = astr_sub
//				If upperbound(astr_sub) > 0 Then
//					For ll_Count = 1 To upperbound(astr_sub) 
//						if il_Disable_Debug = 0 Then
//							f_trace("uo_cart_distrib_row.of_set_row_item SUBITEM " + astr_sub[ll_Count].ssnr )
//						End If
//					Next
//				End If


lstr_item = istr_item

ll_Number_of_Entries = upperbound(lstr_item)

if il_Disable_Debug = 0 Then
	f_trace("uo_cart_distrib_row.of_include_subitems vorher  " + String(ll_Number_of_Entries) )
End If

////if il_Disable_Debug = 0 Then
////	f_trace("uo_cart_distrib_row of_include_subitems " + String(upperbound(rastr_items)))
////end if
rastr_items = lstr_empty

For ll_Count = 1 To upperbound(lstr_item)

	If NOT Isnull(lstr_item[ll_Count].sitem) AND lstr_item[ll_Count].sitem > "" Then
		rastr_items[upperbound(rastr_items) + 1] = lstr_item[ll_Count]
		
		if il_Disable_Debug = 0 Then
			f_trace("uo_cart_distrib_row.of_include_subitems MASTER " + lstr_item[ll_Count].sitem )
		End If
		
		If lstr_item[ll_Count].lcount < 1 Then
			if il_Disable_Debug = 0 Then
				If lstr_item[ll_Count].bdistributed Then
					f_trace("uo_cart_distrib_row.of_include_subitems MASTER " + lstr_item[ll_Count].sitem + " lCount=0 bdistributed=TRUE SUPPRESS SUBITEMS")
				Else
					f_trace("uo_cart_distrib_row.of_include_subitems MASTER " + lstr_item[ll_Count].sitem + " lCount=0 bdistributed=FALSE SUPPRESS SUBITEMS")
				End If
			End if
			CONTINUE
		Else
			if il_Disable_Debug = 0 Then
				f_trace("uo_cart_distrib_row.of_include_subitems MASTER " + lstr_item[ll_Count].sitem + " lstr_item["+String(ll_Count)+"].lcount="+ String(lstr_item[ll_Count].lcount))
			End If
		End If
		
		// Gibt es Inhalte 
		If Upperbound(lstr_item[ll_Count].str_cont ) > 0 Then
			For ll_Count_Sub = 1 To Upperbound(lstr_item[ll_Count].str_cont)
				ll_Target_index = upperbound(rastr_items) + 1 
				//rastr_items[ll_Target_index].sitem = "   " + lstr_item[ll_Count].str_cont[ll_Count_Sub].ssnr
				
				lstr_component_x.ssnr = lstr_item[ll_Count].str_cont[ll_Count_Sub].ssnr
				lstr_component_x.stext = lstr_item[ll_Count].str_cont[ll_Count_Sub].stext
				lstr_component_x.squantity = lstr_item[ll_Count].str_cont[ll_Count_Sub].sqty
				If Trim(lstr_component_x.squantity ) = "0" then lstr_component_x.squantity = ""
				
				//ls_Computed_Item = lstr_component_x.ssnr
				ls_Computed_Item = of_get_item_description( lstr_component_x )
				
				rastr_items[ll_Target_index].sitem = ls_Computed_Item
				
				//rastr_items[ll_Target_index].lcount = 1 
				
				rastr_items[ll_Target_index].lcount = Long(lstr_item[ll_Count].str_cont[ll_Count_Sub].sqty)

				rastr_items[ll_Target_index].llength = 0
				rastr_items[ll_Target_index].lshortage = 0
				
				rastr_items[ll_Target_index].str_prop = lstr_item[ll_Count].str_prop
				
				rastr_items[ll_Target_index].ctext = lstr_item[ll_Count].str_cont[ll_Count_Sub].stext				
				rastr_items[ll_Target_index].cpackinglist = lstr_item[ll_Count].str_cont[ll_Count_Sub].ssnr	
				
				// Parent
				rastr_items[ll_Target_index].sparent = lstr_item[ll_Count].sitem

				// Nur Top Level
				rastr_items[ll_Target_index].bdistributed = FALSE
				
				if il_Disable_Debug = 0 Then
					f_trace("uo_cart_distrib_row.of_include_subitems " + lstr_item[ll_Count].str_cont[ll_Count_Sub].ssnr )
				End If
			Next
		else
			// kein Inhalt => OK
		End If
		
	Else
		rastr_items[upperbound(rastr_items) + 1] = lstr_item[ll_Count]
	End If
Next

//// Leere hinten anh$$HEX1$$e400$$ENDHEX$$ngen
//For ll_Count = 1 To upperbound(lstr_empty)
//	If upperbound(rastr_items) < ll_Number_of_Entries Then
//		rastr_items[upperbound(rastr_items) + 1] = lstr_empty[ll_Count]
//	End If
//Next

if il_Disable_Debug = 0 Then
	f_trace("uo_cart_distrib_row.of_include_subitems nachher " + String(upperbound(rastr_items)) )
End If


Return 1

end function

public function long of_add_row_item (long arg_l_length, string arg_s_item, long arg_l_show, s_distrib_item_sub astr_sub[]);/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_add_row_item (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
* long arg_l_length
* string arg_s_item
* string arg_l_show
*
* Return: long
*
* Setzt eine Zeile und gibt den verbleibenden Platz zur$$HEX1$$fc00$$ENDHEX$$ck
* wenn < 0   dann ist die R$$HEX1$$fc00$$ENDHEX$$ckgabe der fehlende Platz
* Wenn > 0 dann ist die R$$HEX1$$fc00$$ENDHEX$$ckgabe der noch $$HEX1$$fc00$$ENDHEX$$brige Platz
* wenn 0 dann ist die Schiene komplett belegt
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
 
Long				ll_Index, ll_Length
String			ls_Temp
Long				ll_Count

if arg_l_length > of_get_unused_length() then
	ll_Index = NOSPACELEFT
	if il_Disable_Debug = 0 Then
		ls_temp = "uo_cart_distrib_row.of_add_row_item NOSPACELEFT arg_l_show="+String(arg_l_show) + " / " + arg_s_item 
		f_trace(ls_temp)				
	end if
else
	for ll_Index = 1 to upperbound(istr_item)
		// schon vorhandene erweitern
		if istr_item[ll_Index].sitem = arg_s_item and arg_l_show > 0 then
			istr_item[ll_Index].llength = istr_item[ll_Index].llength + arg_l_length
			ll_Count = istr_item[ll_Index].lcount
			ll_Count += 1
			istr_item[ll_Index].lcount =  ll_Count
			
			if il_Disable_Debug = 0 Then
				ls_temp = "uo_cart_distrib_row.of_add_row_item arg_l_show="+String(arg_l_show) + " / " + arg_s_item + " istr_item["+String(ll_Index)+"].lcount " + String(istr_item[ll_Index].lcount)
				f_trace(ls_temp)				
			end if			
			
			If arg_l_show > 0 then
				istr_item[ll_Index].str_cont = astr_sub
			End If
			
			If upperbound(astr_sub) > 0 Then
				If arg_l_show > 0 then
					For ll_Count = 1 To upperbound(astr_sub) 
						if il_Disable_Debug = 0 Then
							f_trace("uo_cart_distrib_row.of_set_row_item SUBITEM " + astr_sub[ll_Count].ssnr )
						End If
					Next
				End If
			End If
			
			If arg_l_show > 0 then
				// ### 20.04.2010 ###
				istr_item[ll_Index].bdistributed = TRUE
			end if
			
			return ll_Length
		// neuen  anlegen
		elseif istr_item[ll_Index].llength = 0 or isNull(istr_item[ll_Index].llength) then
			istr_item[ll_Index].llength = arg_l_length
			istr_item[ll_Index].sitem = arg_s_item
			if arg_l_show > 0 then
				istr_item[ll_Index].lcount = 1
				if il_Disable_Debug = 0 Then
					ls_temp = "uo_cart_distrib_row.of_add_row_item arg_l_show>0 " + arg_s_item +  " istr_item["+String(ll_Index)+"].lcount " + String(istr_item[ll_Index].lcount)
					f_trace(ls_temp)				
				end if	
			else
				istr_item[ll_Index].lcount = 0
				if il_Disable_Debug = 0 Then
					ls_temp = "uo_cart_distrib_row.of_add_row_item arg_l_show=0 " + arg_s_item +  " istr_item["+String(ll_Index)+"].lcount " + String(istr_item[ll_Index].lcount)
					f_trace(ls_temp)				
				end if	

			end if
			
			if arg_l_show > 0 then
				istr_item[ll_Index].str_cont = astr_sub
			end if
				
			If upperbound(astr_sub) > 0 Then
				if arg_l_show > 0 then					
					For ll_Count = 1 To upperbound(astr_sub) 
						if il_Disable_Debug = 0 Then
							f_trace("uo_cart_distrib_row.of_set_row_item SUBITEM " + astr_sub[ll_Count].ssnr )
						End If
					Next
				Else
					if il_Disable_Debug = 0 Then
						f_trace("uo_cart_distrib_row.of_set_row_item arg_l_show=0 SUPPRESS SUBITEMS")
					End If
				End If
			End If
			
			if arg_l_show > 0 then
				// ### 20.04.2010 ###
				istr_item[ll_Index].bdistributed = TRUE
			Else
				istr_item[ll_Index].bdistributed = FALSE
			end if
			
			return ll_Length
		end if
	next
end if 

Return 0



end function

public function long of_get_row_without_sub (ref s_distrib_items ref_str_item[]);/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_get_row_without_sub (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 09.11.2009
* Argument(e):
* ref s_distrib_row ref_str_row[]
*
* Return: long
*
*
* Attribute der Row ermitteln und per Referenz zur$$HEX1$$fc00$$ENDHEX$$ckgeben 
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  09.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

Integer	li_Succ
String	ls_Setting = "0"
Long		ll_Count


// L$$HEX1$$fc00$$ENDHEX$$cken Schliessen
li_Succ = of_compress()

ref_str_item = istr_item

if il_Disable_Debug= 0 then
	For ll_Count = 1 To upperbound(istr_item)
		If trim(istr_item[ll_Count].cpackinglist) > "" then
			f_trace("uo_cart_distrib_row.of_get_row_without_sub " + istr_item[ll_Count].cpackinglist + " / " + istr_item[ll_Count].ctext + " / " + istr_item[ll_Count].sitem)			
		end if
	Next
End If

Return  upperbound(istr_item)

end function

public function long of_add_row_item (long arg_l_length, string arg_s_item, long arg_l_show, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text);/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_add_row_item (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
* long arg_l_length
* string arg_s_item
* string arg_l_show
*
* Return: long
*
* Setzt eine Zeile und gibt den verbleibenden Platz zur$$HEX1$$fc00$$ENDHEX$$ck
* wenn < 0   dann ist die R$$HEX1$$fc00$$ENDHEX$$ckgabe der fehlende Platz
* Wenn > 0 dann ist die R$$HEX1$$fc00$$ENDHEX$$ckgabe der noch $$HEX1$$fc00$$ENDHEX$$brige Platz
* wenn 0 dann ist die Schiene komplett belegt
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/
 
Long llIndex, llLength
String			ls_Temp
Long				ll_Count

if arg_l_length > of_get_unused_length() then
	llIndex = NOSPACELEFT
else
	for llIndex = 1 to upperbound(istr_item)
		// schon vorhandene erweitern
		if istr_item[llIndex].sitem = arg_s_item and arg_l_show > 0 then
			istr_item[llIndex].llength = istr_item[llIndex].llength + arg_l_length
			istr_item[llIndex].lcount = istr_item[llIndex].lcount + 1
			
			istr_item[llIndex].cpackinglist = as_ssnr
			istr_item[llIndex].ctext = as_text
			
			if il_Disable_Debug = 0 Then
				ls_temp = "uo_cart_distrib_row.of_add_row_item " + arg_s_item + " istr_item[llIndex].lcount " + String(istr_item[llIndex].lcount)
				f_trace(ls_temp)				
			end if			
			
//		ll_Rest = istr_item[arg_l_index].str_prop.lremaining - 1
//		istr_item[arg_l_index].str_prop.lremaining = ll_Rest

			istr_item[llIndex].str_cont = astr_sub
			If upperbound(astr_sub) > 0 Then
				For ll_Count = 1 To upperbound(astr_sub) 
					if il_Disable_Debug = 0 Then
						f_trace("uo_cart_distrib_row.of_add_row_item SUBITEM " + astr_sub[ll_Count].ssnr )
					End If
				Next
			End If
			
			return llLength
		// neuen  anlegen
		elseif istr_item[llIndex].llength = 0 or isNull(istr_item[llIndex].llength) then
			istr_item[llIndex].llength = arg_l_length
			istr_item[llIndex].sitem = arg_s_item
			
			istr_item[llIndex].cpackinglist = as_ssnr
			istr_item[llIndex].ctext = as_text
		
			if arg_l_show > 0 then
				istr_item[llIndex].lcount = 1
				if il_Disable_Debug = 0 Then
					ls_temp = "uo_cart_distrib_row.of_add_row_item " + arg_s_item +  " istr_item[llIndex].lcount " + String(istr_item[llIndex].lcount)
					f_trace(ls_temp)				
				end if	
			else
				istr_item[llIndex].lcount = 0
				if il_Disable_Debug = 0 Then
					ls_temp = "uo_cart_distrib_row.of_add_row_item " + arg_s_item +  " istr_item[llIndex].lcount " + String(istr_item[llIndex].lcount)
					f_trace(ls_temp)				
				end if	

			end if
			
			istr_item[llIndex].str_cont = astr_sub
			If upperbound(astr_sub) > 0 Then
				For ll_Count = 1 To upperbound(astr_sub) 
					if il_Disable_Debug = 0 Then
						f_trace("uo_cart_distrib_row.of_add_row_item SUBITEM " + astr_sub[ll_Count].ssnr )
					End If
				Next
			End If
			
			return llLength
		end if
	next
end if 

Return 0
	


end function

public function long of_set_row_item (long arg_l_length, string arg_s_item, long arg_l_show, long arg_l_index, s_distrib_item_sub astr_sub[], string as_ssnr, string as_text, boolean ab_bold, string as_code);/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: of_set_row_item (Function)
* Autor  : Ulrich Paudler [UP]
* Datum  : 10.11.2009
* Argument(e):
* long arg_l_length
*  string arg_s_item
*  long arg_l_show
*  long arg_l_index
*
* Return: long
*
*
* Setzt eine Zeile und gibt den verbleibenden Platz zur$$HEX1$$fc00$$ENDHEX$$ck
* wenn < 0   dann ist die R$$HEX1$$fc00$$ENDHEX$$ckgabe der fehlende Platz
* Wenn > 0 dann ist die R$$HEX1$$fc00$$ENDHEX$$ckgabe der noch $$HEX1$$fc00$$ENDHEX$$brige Platz
* wenn 0 dann ist die Schiene komplett belegt
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  10.11.2009	1.0           Ulrich Paudler     Erstellung
*  09.02.2011	1.1           Oliver H$$HEX1$$f600$$ENDHEX$$fer       NOSPACELEFT-Problem TEST 
*  10.02.2011	1.2           Oliver H$$HEX1$$f600$$ENDHEX$$fer       Komplettumbau: arg_l_index ignorieren, wenn beserer Platz verf$$HEX1$$fc00$$ENDHEX$$gbar
*  12.04.2011	1.3           Oliver H$$HEX1$$f600$$ENDHEX$$fer       Reparaturen f$$HEX1$$fc00$$ENDHEX$$r "verschiedene PL zu gleichem Distr-Parm"
*
*************************************************************/
Integer	li_Succ
Long  llLength
Long	ll_unused
Long	ll_Test_Index
Long	ll_Qty
Long	ll_Count
Long	ll_Rest
Long	ll_Index_To_Check
String	ls_Code
Boolean	lb_Breakpoint

			
if il_Disable_Debug= 0 then
	f_trace("uo_cart_distrib_row.of_set_row_item START " + as_ssnr + " / " + as_text )			
End If

// L$$HEX1$$e400$$ENDHEX$$ngenpr$$HEX1$$fc00$$ENDHEX$$fung dann wenn kein limit eingetragen ist
if arg_l_length > of_get_unused_length() and of_get_count_limit() = 0 then
	
	if il_Disable_Debug = 0 Then
		ll_unused = of_get_unused_length()
		f_trace("uo_cart_distrib_row.of_set_row_item arg_l_length > of_get_unused_length() and of_get_count_limit=0 " + arg_s_item + " arg_l_length=" + String(arg_l_length) + " unused " + String(ll_unused))
	End If
else
	// schon vorhandene erweitern
	if istr_item[arg_l_index].sitem = arg_s_item and arg_l_show > 0 then
		istr_item[arg_l_index].llength = istr_item[arg_l_index].llength + arg_l_length
		istr_item[arg_l_index].lcount = istr_item[arg_l_index].lcount + 1
		
		istr_item[arg_l_Index].str_cont = astr_sub
		
		// Distributed Content Top should be bold (unless HEADER exists)
		istr_item[arg_l_Index].bbold = ab_bold
		
		If il_Disable_Debug = 0 Then
			f_trace("uo_cart_distrib_row.of_set_row_item Rest VORHER istr_item["+String(arg_l_index)+"].str_prop.lremaining " + String(istr_item[arg_l_index].str_prop.lremaining))
		End If
		
		ll_Rest = istr_item[arg_l_index].str_prop.lremaining - 1
		istr_item[arg_l_index].str_prop.lremaining = ll_Rest
				
		If il_Disable_Debug = 0 Then
			f_trace("uo_cart_distrib_row.of_set_row_item Rest NACHHER istr_item["+String(arg_l_index)+"].str_prop.lremaining " + String(ll_Rest))
		End If
		
		istr_item[arg_l_index].cpackinglist = as_ssnr
		istr_item[arg_l_index].ctext = as_text
		
		If upperbound(astr_sub) > 0 Then
			For ll_Count = 1 To upperbound(astr_sub) 
				if il_Disable_Debug = 0 Then
					f_trace("uo_cart_distrib_row.of_set_row_item SUBITEM " + astr_sub[ll_Count].ssnr )
				End If
			Next
		End If	

		// lleg
		ls_Code = istr_item[arg_l_index].str_prop.smeal_control_code
		// 06.11.2012 Code nicht aus Platzhalter
		// ls_Code = as_code //istr_item[arg_l_index].str_prop.smeal_control_code
		If as_code <> istr_item[arg_l_index].str_prop.smeal_control_code Then
			lb_Breakpoint = TRUE
			ls_Code = as_code	
		End If
		
		If NOT IsNull(ls_Code) Then
			If Trim(ls_Code) > "" Then
				ls_Code = Left(ls_Code, 1) 
				If Isnumber(ls_Code) Then
					If Long(ls_Code) > 1 Then
						// Downline?
						istr_item[arg_l_index].lleg = Long(ls_Code)
						If il_Disable_Debug = 0 Then
							f_trace("uo_cart_distrib_row.of_set_row_item Rest CODE (" + ls_Code + ")LEG DOWNLINE " + as_ssnr + " LEG "+String(istr_item[arg_l_index].lleg))
						End If
					End If
				End If
			End If
		End If

		return llLength
		
	// neuen anlegen
	elseif istr_item[arg_l_index].llength = 0 or isNull(istr_item[arg_l_index].llength) then
		istr_item[arg_l_index].llength = arg_l_length
		istr_item[arg_l_index].sitem = arg_s_item
		
		istr_item[arg_l_index].cpackinglist = as_ssnr
		istr_item[arg_l_index].ctext = as_text
		
		if il_Disable_Debug = 0 Then
			f_trace("uo_cart_distrib_row.of_set_row_item " + arg_s_item)
		End If
		
		if arg_l_show > 0 then
			istr_item[arg_l_index].lcount = 1
		else
			istr_item[arg_l_index].lcount = 0
		end if
		
		// Distributed Content Top should be bold
		istr_item[arg_l_Index].bbold = ab_bold

		istr_item[arg_l_Index].str_cont = astr_sub
		
		If il_Disable_Debug = 0 Then
			f_trace("uo_cart_distrib_row.of_set_row_item Rest VORHER istr_item["+String(arg_l_index)+"].str_prop.lremaining " + String(istr_item[arg_l_index].str_prop.lremaining))
		End If
		
		ll_Rest = istr_item[arg_l_index].str_prop.lremaining - 1
		istr_item[arg_l_index].str_prop.lremaining = ll_Rest
		
		If il_Disable_Debug = 0 Then
			f_trace("uo_cart_distrib_row.of_set_row_item Rest NACHHER istr_item["+String(arg_l_index)+"].str_prop.lremaining " + String(ll_Rest))
		End If

		If upperbound(astr_sub) > 0 Then
			For ll_Count = 1 To upperbound(astr_sub) 
				if il_Disable_Debug = 0 Then
					f_trace("uo_cart_distrib_row.of_set_row_item SUBITEM " + astr_sub[ll_Count].ssnr )
				End If
			Next
		End If
		
		// lleg
		ls_Code = istr_item[arg_l_index].str_prop.smeal_control_code
		If as_code <> istr_item[arg_l_index].str_prop.smeal_control_code Then
			lb_Breakpoint = TRUE
			ls_Code = as_code	
		End If
		If NOT IsNull(ls_Code) Then
			If Trim(ls_Code) > "" Then
				ls_Code = Left(ls_Code, 1) 
				If Isnumber(ls_Code) Then
					If Long(ls_Code) > 1 Then
						// Downline?
						istr_item[arg_l_index].lleg = Long(ls_Code)
						If il_Disable_Debug = 0 Then
							f_trace("uo_cart_distrib_row.of_set_row_item Rest CODE (" + ls_Code + ")LEG DOWNLINE " + as_ssnr + " LEG "+String(istr_item[arg_l_index].lleg))
						End If
					End If
				End If
			End If
		End If
		
		return llLength
	//end if
	
	Else
		// Versuch mit Index 1...Arraygr$$HEX2$$f600df00$$ENDHEX$$e
		
		// Runde eins: schon an anderer Stelle vorhanden?
		For ll_Test_Index = 1 To upperbound(istr_item)
			if ll_Test_Index = arg_l_index then continue // hatten wir bereits probiert
			
			if istr_item[ll_Test_Index].sitem = arg_s_item and arg_l_show > 0 then
				istr_item[ll_Test_Index].llength = istr_item[ll_Test_Index].llength + arg_l_length
				
				ll_Qty = istr_item[ll_Test_Index].lcount
				ll_Qty = ll_Qty + 1 
				istr_item[ll_Test_Index].lcount = ll_Qty
				
				istr_item[ll_Test_Index].str_cont = astr_sub
				
				If il_Disable_Debug = 0 Then
					f_trace("uo_cart_distrib_row.of_set_row_item Rest VORHER istr_item["+String(arg_l_index)+"].str_prop.lremaining " + String(istr_item[arg_l_index].str_prop.lremaining))
				End If
				
				ll_Rest = istr_item[arg_l_index].str_prop.lremaining - 1
				istr_item[arg_l_index].str_prop.lremaining		= ll_Rest
				
				If il_Disable_Debug = 0 Then
					f_trace("uo_cart_distrib_row.of_set_row_item Rest NACHHER istr_item["+String(arg_l_index)+"].str_prop.lremaining " + String(ll_Rest))
				End If

				istr_item[ll_Test_Index].cpackinglist = as_ssnr
				istr_item[ll_Test_Index].ctext = as_text
				
				// Distributed Content Top should be bold
				istr_item[ll_Test_Index].bbold = ab_bold
				
				If upperbound(astr_sub) > 0 Then
					For ll_Count = 1 To upperbound(astr_sub) 
						if il_Disable_Debug = 0 Then
							f_trace("uo_cart_distrib_row.of_set_row_item SUBITEM " + astr_sub[ll_Count].ssnr )
						End If
					Next
				End If
				
				if il_Disable_Debug = 0 Then
					f_trace("uo_cart_distrib_row.of_set_row_item " + arg_s_item + " arg_l_index " + String(arg_l_index) + " USED: " + String(ll_Test_Index) + &
													" lcount=" + String(istr_item[ll_Test_Index].lcount) + " ll_qty=" + String(ll_Qty)  )
				End If
				
				// lleg
				ls_Code = istr_item[arg_l_index].str_prop.smeal_control_code
				If as_code <> istr_item[arg_l_index].str_prop.smeal_control_code Then
					lb_Breakpoint = TRUE
					ls_Code = as_code	
				End If
				If NOT IsNull(ls_Code) Then
					If Trim(ls_Code) > "" Then
						ls_Code = Left(ls_Code, 1) 
						If Isnumber(ls_Code) Then
							If Long(ls_Code) > 1 Then
								// Downline?
								istr_item[arg_l_index].lleg = Long(ls_Code)
								If il_Disable_Debug = 0 Then
									f_trace("uo_cart_distrib_row.of_set_row_item Rest CODE (" + ls_Code + ")LEG DOWNLINE " + as_ssnr + " LEG "+String(istr_item[arg_l_index].lleg))
								End If
							End If
						End If
					End If
				End If
				
				return llLength
			end if
		Next
		// -----------------------------------------
		// Runde 2: Freier Platz gesucht	
		// -----------------------------------------
		If istr_item[upperbound(istr_item)].sitem > "" Then
			f_trace("uo_cart_distrib_row.of_set_row_item Item Array is full => of_Extend_array")
			li_Succ = of_Extend_array()
			//istr_item[upperbound(istr_item)].sitem = ""
		End If
		
		For ll_Test_Index = 1 to upperbound(istr_item)  
			if (Isnull(istr_item[ll_Test_Index].sitem) OR TRIM(istr_item[ll_Test_Index].sitem) = "" ) AND (istr_item[ll_Test_Index].llength = 0 or isNull(istr_item[ll_Test_Index].llength)) then
				istr_item[ll_Test_Index].llength = arg_l_length
				istr_item[ll_Test_Index].sitem = arg_s_item
				
				istr_item[ll_Test_Index].cpackinglist = as_ssnr
				istr_item[ll_Test_Index].ctext = as_text

				if arg_l_show > 0 then
					istr_item[ll_Test_Index].lcount = 1
				else
					istr_item[ll_Test_Index].lcount = 0
					if il_Disable_Debug = 0 Then
						f_trace("uo_cart_distrib_row.of_set_row_item arg_l_show < 1 " + arg_s_item)
					End If
				end if
				if il_Disable_Debug = 0 Then
					f_trace("uo_cart_distrib_row.of_set_row_item setze " + as_ssnr + " / " + as_text  + " in " + String(ll_Test_Index)  + " statt in " + String(arg_l_index) + " QTY " + String(istr_item[ll_Test_Index].lcount ))
				End If
				
				// Distributed Content Top should be bold
				istr_item[ll_Test_Index].bbold = ab_bold
	
				istr_item[ll_Test_Index].str_cont = astr_sub
				
				ll_Rest = istr_item[arg_l_index].str_prop.lremaining
				
				If il_Disable_Debug = 0 Then
					f_trace("uo_cart_distrib_row.of_set_row_item Rest VORHER istr_item["+String(arg_l_index)+"].str_prop.lremaining " + String(istr_item[arg_l_index].str_prop.lremaining))
				End If
				
				ll_Rest = ll_Rest - 1
				istr_item[arg_l_index].str_prop.lremaining = ll_Rest
				
				if il_Disable_Debug = 0 Then
					f_trace("uo_cart_distrib_row.of_set_row_item NACHHER lremaining: (Pos. " + String(arg_l_index) + ")  ll_Rest " + String(ll_Rest))
				End If
											
				If upperbound(astr_sub) > 0 Then
					For ll_Count = 1 To upperbound(astr_sub) 
						if il_Disable_Debug = 0 Then
							f_trace("uo_cart_distrib_row.of_set_row_item SUBITEM " + astr_sub[ll_Count].ssnr )
						End If
					Next
				End If

				// lleg
				ls_Code = istr_item[arg_l_index].str_prop.smeal_control_code
				If as_code <> istr_item[arg_l_index].str_prop.smeal_control_code Then
					lb_Breakpoint = TRUE
					ls_Code = as_code	
				End If
				If NOT IsNull(ls_Code) Then
					If Trim(ls_Code) > "" Then
						ls_Code = Left(ls_Code, 1) 
						If Isnumber(ls_Code) Then
							If Long(ls_Code) > 1 Then
								// Downline?
								istr_item[arg_l_index].lleg = Long(ls_Code)
								If il_Disable_Debug = 0 Then
									f_trace("uo_cart_distrib_row.of_set_row_item Rest CODE (" + ls_Code + ")LEG DOWNLINE " + as_ssnr + " LEG "+String(istr_item[arg_l_index].lleg))
								End If
							End If
						End If
					End If
				End If

				return llLength
			end if
		Next
	end if
end if 

if il_Disable_Debug = 0 Then
	f_trace("uo_cart_distrib_row.of_set_row_item NOSPACELEFT " + arg_s_item )
End If

Return NOSPACELEFT
	


end function

public function integer of_extend_array ();/*
* Objekt : uo_cart_distrib_row
* Methode: of_extend_array (Function)
* Autor  : Oliver H$$HEX1$$f600$$ENDHEX$$fer
* Datum  : 11.12.2012
*
* Argument(e):
* none
*
* Beschreibung:		Add emtpty row to array
*
* Aenderungshistorie:
* Version 		Wer			Wann			Was und warum
* 1.0 			O.Hoefer	11.12.2012		Erstellung
*
*
* Return: integer
*
*/

Long	ll_Counter


ll_Counter = UpperBound(istr_item)
ll_Counter++

//istr_item
istr_item[ll_Counter].llength = 0
istr_item[ll_Counter].sitem = ""
istr_item[ll_Counter].cpackinglist = ""
istr_item[ll_Counter].ctext = ""
istr_item[ll_Counter].lcount = 0


return 1
end function

on uo_cart_distrib_row.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cart_distrib_row.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;/*************************************************************
* Objekt : uo_cart_distrib_row
* Methode: constructor (Event)
* Autor  : Ulrich Paudler [UP]
* Datum  : 05.11.2009
* Argument(e):
* none
*
* Return: long
*
*
*
*
**************************************************************
*  Modifikationen:
*  Datum    Version        Autor              Kommentar
* --------------------------------------------------------------------------------
*  05.11.2009	1.0           Ulrich Paudler     Erstellung
*
*************************************************************/

 il_Length 	= 0

end event

