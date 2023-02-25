CLASS zcl_ws_http_msaa217 DEFINITION
  PUBLIC
  INHERITING FROM zcl_conexion_http_msaa217
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !request_method TYPE string
        !protocolo_ws   TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA protocolo_ws TYPE string .
ENDCLASS.



CLASS zcl_ws_http_msaa217 IMPLEMENTATION.


  METHOD constructor.
    super->constructor( request_method = request_method ).
    me->protocolo_ws = protocolo_ws.
  ENDMETHOD.
ENDCLASS.
