*&---------------------------------------------------------------------*
*& Report Z_LLAMADA_MSAA217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_llamada_msaa217.

DATA: gt_flights TYPE TABLE OF sflight,
      gs_flights TYPE sflight.

CALL FUNCTION 'Z_MF_VUELOS_MSAA217'
  EXPORTING
    iv_carrid  = 'ca'
*   IV_LIST    =
  TABLES
    et_flights = gt_flights
  EXCEPTIONS
    ex_vuelos  = 1.

IF sy-subrc NE 0.
  WRITE / 'No existen vuelos para la compañía indicada'.

ELSE.

  " El enunciado pide mostrar la tabla por pantalla y he encontrado la funcion SRTT_TABLE_DISPLAY que lo hace de un modo elegante

  SELECTION-SCREEN: BEGIN OF BLOCK block1.

    CALL FUNCTION 'SRTT_TABLE_DISPLAY'
      EXPORTING
        table         = 'sflight'
        iv_title      = 'Tabla de Vuelos'
      TABLES
        table_content = gt_flights.

  SELECTION-SCREEN: END OF BLOCK block1.

ENDIF.
