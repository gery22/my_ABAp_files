*&---------------------------------------------------------------------*
*& Report z_variables_msaa217
*&---------------------------------------------------------------------*
*& 1. 1. Variables de tipo completo D y T
*  1. 2. Variables de tipo completo número I y F
*  1.3. Variables de tipo completo DECFLOAT
*  1.4. Variables de tipo completo STRING y XSTRING
*  1.5. Variable de tipo incompleto C y P
*  1.6. Variables de tipo incompleto N y X
*&---------------------------------------------------------------------*
REPORT z_variables_msaa217.

DATA: gv_fecha              TYPE d VALUE '20251127',
      gv_hora               TYPE t VALUE '124500',
      gv_iva                TYPE  i VALUE '7',
      gv_reparto            TYPE f VALUE '18.95',
      gv_impuesto_directo   TYPE decfloat16 VALUE '45',
      gv_impuesto_indirecto TYPE decfloat34 VALUE '141.1',
      gv_nombre             TYPE string VALUE 'Gery',
      gv_hexadecimal        TYPE xstring VALUE '233c',
      gv_sociedad           TYPE c LENGTH 6 VALUE 'Logali',
      gv_tarifa             TYPE p LENGTH 8 VALUE '124500',
      gv_codigo_sociedad    TYPE n LENGTH 4 VALUE '4500',
      gv_datos              TYPE x LENGTH 5 VALUE 'a12c'.





WRITE: / gv_fecha DD/MM/YY,
        / gv_hora ENVIRONMENT TIME FORMAT ,
        / gv_iva, gv_reparto,
        / gv_impuesto_directo,
        / gv_impuesto_indirecto,
        / gv_nombre,
        / gv_hexadecimal,
        / gv_sociedad    ,
        / gv_tarifa     ,
        / gv_codigo_sociedad,
        / gv_datos.


CONSTANTS: gc_fecha              TYPE d VALUE '20251127',
           gc_hora               TYPE t VALUE '124500',
           gc_iva                TYPE  i VALUE '7',
           gc_reparto            TYPE f VALUE '18.95',
           gc_impuesto_directo   TYPE decfloat16 VALUE '45',
           gc_impuesto_indirecto TYPE decfloat34 VALUE '141.1',
           gc_nombre             TYPE string VALUE 'Gery',
           gc_hexadecimal        TYPE xstring VALUE '233c',
           gc_sociedad           TYPE c LENGTH 6 VALUE 'Logali',
           gc_tarifa             TYPE p LENGTH 8 VALUE '124500',
           gc_codigo_sociedad    TYPE n LENGTH 4 VALUE '4500',
           gc_datos              TYPE x LENGTH 5 VALUE 'a12c'.





WRITE: / gc_fecha DD/MM/YY,
       / gc_hora environment TIME FORMAT ,
        / gc_iva, gv_reparto,
        / gc_impuesto_directo,
        / gc_impuesto_indirecto,
        / gc_nombre,
        / gc_hexadecimal,
        / gc_sociedad    ,
        / gc_tarifa     ,
        / gc_codigo_sociedad,
        / gc_datos.
