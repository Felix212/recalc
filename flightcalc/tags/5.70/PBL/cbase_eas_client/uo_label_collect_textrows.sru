HA$PBExportHeader$uo_label_collect_textrows.sru
$PBExportComments$userobject zum einsammeln von text-rows
forward
global type uo_label_collect_textrows from nonvisualobject
end type
end forward

global type uo_label_collect_textrows from nonvisualobject autoinstantiate
end type

type variables


Protected:

Long		il_TextCounter 	= 0
String		is_LabelText = ""

s_packinglist_detail	istr_LabelPLTexte


Long 	il_TextRowsInObject = 1

end variables
forward prototypes
public function long of_add_row (string as_text, string as_unit, long al_quantity)
public function long of_return_textrows (ref s_packinglist_detail astr_labelpltexte)
public function long of_init (long al_textrowsinobject, string as_text)
public function long of_init (long al_textrowsinobject)
end prototypes

public function long of_add_row (string as_text, string as_unit, long al_quantity);
/*
* Objekt: 	uo_label_collect_textrows
* Methode: 	of_add_row
*
* Argument(e):
* 	string 		as_Text 			Text, der angezeigt werden soll
* 	string 		as_Unit 			Einheit, die angezeigt werden soll
* 	long 			al_Quantity 		Menge, die angezeigt werden soll
*
* Beschreibung:		initialisieren
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		29.06.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*/


// Neues Sub-Label starten ?
if this.il_TextCounter = this.il_TextRowsInObject then
	this.il_TextCounter = 0
	this.is_LabelText = ""
	this.istr_LabelPLTexte.cdetail_text[UpperBound(this.istr_LabelPLTexte.cdetail_text) + 1] = this.is_LabelText
end if	

// dann der inhalt
this.il_TextCounter++
this.is_LabelText +=  string(al_Quantity) + "~t" + as_Text + "~t" + as_Unit + "~n"
this.istr_LabelPLTexte.cdetail_text[UpperBound(this.istr_LabelPLTexte.cdetail_text)] = this.is_LabelText
	

return 0

end function

public function long of_return_textrows (ref s_packinglist_detail astr_labelpltexte);
/*
* Objekt: 	uo_label_collect_textrows
* Methode: 	of_return_textrows
*
* Argument(e):
* 	ref 	s_packinglist_detail 	astr_LabelPLTexte 	die texte, die zur$$HEX1$$fc00$$ENDHEX$$ckgegeben werden sollen
*
* Beschreibung:		die gef$$HEX1$$fc00$$ENDHEX$$llten texte zur$$HEX1$$fc00$$ENDHEX$$ckgeben (per reference)
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		29.06.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*/


astr_LabelPLTexte = this.istr_LabelPLTexte


return 0

end function

public function long of_init (long al_textrowsinobject, string as_text);
/*
* Objekt: 	uo_label_collect_textrows
* Methode: of_init
*
* Argument(e):
* 	long 			al_TextRowsInObject 		Anzahl Zeilen pro Label
* 	string 		as_Text 						Text, der angezeigt werden soll, wenn nix vorhanden
*
* Beschreibung:		initialisieren
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		29.06.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*/


if al_TextRowsInObject > 0 then
	this.il_TextRowsInObject = al_TextRowsInObject
end if

this.istr_LabelPLTexte.cdetail_text[1] = as_text

return 0

end function

public function long of_init (long al_textrowsinobject);
/*
* Objekt: 	uo_label_collect_textrows
* Methode: of_init
*
* Argument(e):
* 	long 			al_TextRowsInObject 		Anzahl Zeilen pro Label
* 	string 		as_Text 						Text, der angezeigt werden soll, wenn nix vorhanden
*
* Beschreibung:		initialisieren
*
* Aenderungshistorie:
* Version 		Wer				Wann				Was und warum
* 1.0 				M.N$$HEX1$$fc00$$ENDHEX$$ndel 		29.06.2012		Erstellung
*
*
* Return: integer
*	0 	alles geklappt
*/

return of_init(al_TextRowsInObject, "")

end function

event constructor;

// initialisieren
this.il_TextCounter = 0
this.is_LabelText = ""

if UpperBound(this.istr_LabelPLTexte.cdetail_text) = 0 then
	this.istr_LabelPLTexte.cdetail_text[UpperBound(this.istr_LabelPLTexte.cdetail_text) + 1] = ""
end if

end event

on uo_label_collect_textrows.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_label_collect_textrows.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

