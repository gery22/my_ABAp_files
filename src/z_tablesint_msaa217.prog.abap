*&---------------------------------------------------------------------*
*& Report z_tablesint_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_tablesint_msaa217.


*&---------------------------------------------------------------------*
*&  2.1.1. Añadir registros con área de trabajo
*&---------------------------------------------------------------------*


*Creacion de Standard Table
DATA: gt_empleados TYPE STANDARD TABLE OF zemp_logali,

      gwa_empleado TYPE zemp_logali.

*Usando de Append
gwa_empleado-id = '21324'.
gwa_empleado-email = 'APPEND@gmail.com'.
gwa_empleado-ape1 = 'Brown'.
gwa_empleado-ape2 = 'Garcia'.
gwa_empleado-nombre = 'Jorge'.
gwa_empleado-fechan = '19792606'.
gwa_empleado-fechaa = sy-datum.

APPEND gwa_empleado TO gt_empleados.


*Usando INSERT
gwa_empleado-id = '2131321'.
gwa_empleado-email = 'INSERT@gmail.com'.
gwa_empleado-ape1 = 'Blue'.
gwa_empleado-ape2 = 'Garcia'.
gwa_empleado-nombre = 'Jorge'.
gwa_empleado-fechan = '19792606'.
gwa_empleado-fechaa = sy-datum.


INSERT gwa_empleado INTO gt_empleados INDEX 1.

*Usando VALUE()
APPEND VALUE #( id = '132121'
                email = 'VALUE@gmail.com'
                ape1 = 'Blue'
                ape2 = 'Garcia'
                nombre = 'Jorge'
                fechan = '19792606'
                fechaa = sy-datum )

                TO gt_empleados.


*cl_demo_output=>write( gt_empleados ).
*cl_demo_output=>display( ).


*&---------------------------------------------------------------------*
*&  2.1.2. Añadir registros con cabecera
*&---------------------------------------------------------------------*

* WARINIG!!!
*NOTA PARA QUIEN CORRIGE : EN EL ENUNCIADO SE PIDE CREAR UN OBJETO LLAMADO gt_empleados_occurs PERO LA NOMENCLATURA SUGERIDA POR SAP PARA ESTE OBJETO DEBERIA EMPEZAR CON TY


* Utilizando Occurs
DATA: BEGIN OF ty_empleados_occurs OCCURS 0,

        email  TYPE c LENGTH 30,
        id     TYPE string,
        nombre TYPE c LENGTH 30,
        ape1   TYPE c LENGTH 30,
        ape2   TYPE c LENGTH 30,
        fechan TYPE dats,
        fechaa TYPE sydatum,
      END OF ty_empleados_occurs.

ty_empleados_occurs-id = '212148'.
ty_empleados_occurs-email = 'OCCURS@gmail.com'.
ty_empleados_occurs-ape1 = 'Blue'.
ty_empleados_occurs-ape2 = 'Garcia'.
ty_empleados_occurs-nombre = 'Jorge'.
ty_empleados_occurs-fechan = '19792606'.
ty_empleados_occurs-fechaa = sy-datum.

APPEND ty_empleados_occurs.
*cl_demo_output=>write( ty_empleados_occurs ).
*cl_demo_output=>display( ).



* TABLA CON HEADER
DATA gt_empleados_cab TYPE STANDARD TABLE OF zemp_logali WITH HEADER LINE.

APPEND VALUE #( id = '1242328'
                email = 'HEADER@gmail.com'
                ape1 = 'Blue'
                ape2 = 'Garcia'
                nombre = 'Jorge'
                fechan = '19792606'
                fechaa = sy-datum )

                TO gt_empleados_cab[].

*cl_demo_output=>write( gt_empleados_cab[] ).
*cl_demo_output=>display( ).



*&---------------------------------------------------------------------*
*&  2.1.4. Sentencia DESCRIBE
*&---------------------------------------------------------------------*



SELECT  FROM  spfli
FIELDS *
WHERE carrid EQ 'LH'
INTO TABLE @DATA(gt_flights).



DESCRIBE TABLE gt_flights LINES DATA(gv_luft).

WRITE: / 'Number of LH flights: ', gv_luft.


*&---------------------------------------------------------------------*
*&  2.1.5. Sentencia READ
*&---------------------------------------------------------------------*

READ TABLE gt_flights INTO DATA(gs_flights) WITH KEY airpto = 'FRA'.

WRITE: / 'The first city to hava a LH fligth to airport FRA is : ', gs_flights-cityfrom.


*&---------------------------------------------------------------------*
*&  2.1.6-7. Sentencia LOOP y Ordenar
*&---------------------------------------------------------------------*

SORT gt_flights DESCENDING BY connid.

LOOP AT gt_flights INTO gs_flights.

  IF gs_flights-connid > '0400'.



    WRITE / |Flight  { gs_flights-carrid } from { gs_flights-cityfrom } to  { gs_flights-cityto } { gs_flights-connid }|.

  ENDIF.

ENDLOOP.


*&---------------------------------------------------------------------*
*&  2.1.8.MODIFY
*&---------------------------------------------------------------------*
LOOP AT gt_flights INTO gs_flights.

  IF  gs_flights-deptime EQ '133000'.

    gs_flights-deptime = sy-timlo.

    WRITE  / |  { gs_flights-cityfrom } dep time changed to { gs_flights-deptime } |.

  ENDIF.



ENDLOOP.


*&---------------------------------------------------------------------*
*&  2.1.9 Eliminar registros con cabecera
*&---------------------------------------------------------------------*





DATA gt_flights_wh  TYPE STANDARD TABLE OF spfli WITH HEADER LINE.

SELECT  FROM  spfli
FIELDS *
WHERE distid EQ 'MI'
INTO TABLE @gt_flights_wh.

LOOP AT gt_flights_wh.
  IF gt_flights_wh-cityfrom EQ 'NEW YORK'.


    DELETE gt_flights_wh.
    IF sy-subrc EQ 0.
      WRITE : / 'RECORD DELETED'.
      ENDIF.


    ENDIF.
  ENDLOOP.

*&---------------------------------------------------------------------*
*&  10. Eliminar registros con área de trabajo
*&---------------------------------------------------------------------*

CLEAR: gt_flights.

SELECT  FROM  spfli
FIELDS *
WHERE distid EQ 'KM'
INTO TABLE @gt_flights.

LOOP AT gt_flights INTO DATA(GWA_FLIGHTS).

IF GWA_FLIGHTS-cityto EQ 'BERLIN'.

DELETE  TABLE gt_flights FROM GWA_flights.
WRITE / 'RECORD DELETED USING WA'.
ENDIF.
ENDLOOP.


*&---------------------------------------------------------------------*
*&  11. Move-Corresponding
*&---------------------------------------------------------------------*


MOVE-CORRESPONDING gt_flights to gt_flights_wh[].





break-point.
