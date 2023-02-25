*&---------------------------------------------------------------------*
*& Report z_ope_caracteres_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ope_caracteres_msaa217.

" Declare variables
DATA: ejercicio      TYPE n LENGTH 4 VALUE '0800',
      no_factura     TYPE n LENGTH 8 VALUE '002200',
      codigo_factura TYPE string,
      expediente1    TYPE string,
      expediente2    TYPE string,
      v_text         TYPE string,
      v_cnt          TYPE i,
      registro       TYPE string VALUE 'Ejercicio;2020;Sociedad;SAP',
      campo1         TYPE string,
      campo2         TYPE string,
      campo3         TYPE string,
      campo4         TYPE string.



*&---------------------------------------------------------------------*
*& 1. Concatenar.
*&---------------------------------------------------------------------*
CONCATENATE ejercicio   no_factura INTO codigo_factura.

WRITE: / ejercicio, no_factura, / codigo_factura.


*&---------------------------------------------------------------------*
*& 2. Condensar.
*&---------------------------------------------------------------------*

expediente1 = 'Factura de venta con estado      en trámite'.
expediente2 = 'Factura de venta con estado      en trámite'.

CONDENSE expediente1.
CONDENSE expediente2 NO-GAPS.

WRITE: / expediente1,
        / expediente2.


*&---------------------------------------------------------------------*
*& 3. Reemplazar.
*&---------------------------------------------------------------------*

DATA(solicitud) = 'SAP-ABAP-32-PE'.

REPLACE ALL OCCURRENCES OF '-' IN solicitud  WITH '/'.

WRITE / solicitud.

*&---------------------------------------------------------------------*
*& 4. SEARCH / FIND.
*&---------------------------------------------------------------------*

DATA(empresa) = 'SISTEMA DE PRODUCCION Y DESARROLLO'.

SEARCH empresa FOR 'PRO'.

WRITE / sy-fdpos.

v_text = 'SISTEMA # 1 DE PRODUCCIÓN Y DESARROLLO #2025'.
FIND ALL OCCURRENCES OF '#' IN v_text MATCH COUNT v_cnt.

WRITE / v_cnt.


*&---------------------------------------------------------------------*
*& 5. SHIFT.
* WARNING: en a documentacion del curso no dice nada sobre el operador PLACES
*&---------------------------------------------------------------------*


DATA(num_factura) = '2015ABCD'.
SHIFT num_factura LEFT BY 2 PLACES.
WRITE / num_factura.

*&---------------------------------------------------------------------*
*& 6. TRANSLATE.
*&---------------------------------------------------------------------*

DATA(frase) = 'SAP ABAP Programación estructurada'.
TRANSLATE frase TO UPPER CASE.
WRITE / frase.


*&---------------------------------------------------------------------*
*& 7. SPLIT.
*&---------------------------------------------------------------------*

SPLIT registro AT ';' INTO   campo1
                             campo2
                             campo3
                             campo4.
WRITE:    / campo1,
          / campo2,
          / campo3,
          / campo4.


*&---------------------------------------------------------------------*
*& 8. SUBSTRING.
*&---------------------------------------------------------------------*


DATA result TYPE string VALUE 'LOGALI GROUP'.

DATA(v_from) = substring_from( val = result sub = 'GA').
DATA(v_after) = substring_after( val = result sub = 'GA').
DATA(v_before) = substring_before( val = result sub = 'GA').
DATA(v_to) = substring_to( val = result sub = 'GA').

WRITE:  / v_after,
        / v_before,
        / v_to,
        / v_from.

*&---------------------------------------------------------------------*
*& 9. CONV.
*&---------------------------------------------------------------------*

DATA: int  TYPE f,
      int2 TYPE i.

int = sqrt( 5 ) + sqrt( 6 ).
int2 = CONV i( sqrt( 5 ) ) + CONV i( sqrt( 6 ) ).

WRITE: / |resultado 1:     { int }|,
       / |resultado 2:      { int2 }|.


*&---------------------------------------------------------------------*
*& 10. ALPHA.
*&---------------------------------------------------------------------*


DATA(dato) = '0000013245'.
DATA(dato1) = '13245'.
WRITE: / |Before:  { dato }  AND  { dato1 }|.
WRITE: / |After ALPHA:  { dato ALPHA = OUT }  AND  { dato1 ALPHA = IN WIDTH = 10 }|. "width es total width of string


*&---------------------------------------------------------------------*
*& 11.Expresiones regulares.
* WARNING: NO SE ENCUENTRA NADA SOBRE REGEX EN LA DOCUMENTACION
*&---------------------------------------------------------------------*


data(lv_regex) = '^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$'.
DATA(lv_email) = 'perro@gmail.co.uk!'.

find REGEX lv_regex in lv_email.

if sy-subrc EQ 0.
WRITE / 'Correo Válido'.
else.
WRITE / 'Correo No válido'.
ENDIF.
