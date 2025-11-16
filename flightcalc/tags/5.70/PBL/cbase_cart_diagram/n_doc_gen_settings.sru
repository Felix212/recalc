HA$PBExportHeader$n_doc_gen_settings.sru
$PBExportComments$Settings for document generation (per Unit & Airline)
forward
global type n_doc_gen_settings from nonvisualobject
end type
end forward

global type n_doc_gen_settings from nonvisualobject autoinstantiate
end type

type variables
// -----------------------------------
// Document Generation Settings
// -----------------------------------
Public:
String	is_cunit
Long	il_nairline_key
Long	il_nenable_label
Long	il_nuse_zebra
Long	il_nenable_documents
Long	il_nenable_galley_diagram
Long	il_nlayout_key
Long	il_nenable_cartdiagram

Long	il_nenable_cart_distribution
Long	il_ncart_component_display
Long	il_nenable_overflow
Long	il_nenable_cart_unassigned

Long	il_nenable_tr_diagram
Long	il_nenable_content_sheet
Long	il_nenable_tripticket
Long	il_nenable_deliverynote
Long	il_nenable_checksheet
Long	il_nenable_distribution

Long	il_nlabel_group_key
Long	il_nchecksheet_group_key
Long	il_nchecksheet_style
Long	il_nprint_checksheet_by_ws
Long	il_nadd_load

Long	il_nenable_flightinfo
Long	il_nflightinfo_copies

Long	il_nenable_cart_comp_sort_by_pl_class
Long	il_nenable_cart_comp_distinct_pl
// CR Show All Stowages?
Long	il_show_all_stowages

Long	il_NENABLE_LABEL_BAK 
Long	il_NENABLE_CARTDIAGRAM_BAK 
Long	il_NENABLE_TR_DIAGRAM_BAK 
Long	il_NENABLE_CONTENT_SHEET_BAK 
Long	il_NENABLE_DELIVERYNOTE_BAK 
Long	il_NENABLE_DOCUMENTS_BAK 
Long	il_NENABLE_GALLEY_DIAGRAM_BAK 
Long	il_NENABLE_CHECKSHEET_BAK 
Long	il_NENABLE_TRIPTICKET_BAK 
Long	il_nenable_flightinfo_BAK

String	is_User

Integer	ii_ZIP_Offset

Long	il_NENABLE_CUSTOMER_REPORT
Long	il_CrystalReportId 

end variables

on n_doc_gen_settings.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_doc_gen_settings.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

