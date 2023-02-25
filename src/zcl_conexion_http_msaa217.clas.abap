class ZCL_CONEXION_HTTP_MSAA217 definition
  public
  create public .

public section.

  interfaces ZIF_GRUPO_MSAA217_ .

  aliases SET_CODIGO_VUELO
    for ZIF_GRUPO_MSAA217_~SET_CODIGO_VUELO .
  aliases AVISAR_PRECIO_VUELO
    for ZIF_GRUPO_MSAA217_~AVISAR_PRECIO_VUELO .

  types:
    BEGIN OF LTY_MVT_DETAILS,
    codido TYPE string,
    fecha type dats,
    user TYPE sy-uname,
    END OF lty_mvt_details .

  class-methods CLASS_CONSTRUCTOR .
  methods SET_REQUEST_URI
    importing
      !REQUEST_URI type STRING .
  methods GET_REQUEST_URI
    exporting
      !REQUEST_URI type STRING .
  methods SET_SERVER_PROTOCOL
    importing
      !SERVER_PROTOCOL type STRING .
  methods GET_SERVER_PROTOCOL
    exporting
      !SERVER_PROTOCOL type STRING .
  methods CREA_CONEXION .
  class-methods COMPRUEBA_AUTORIZACION .
protected section.

  aliases CODIGO_VUELO
    for ZIF_GRUPO_MSAA217_~CODIGO_VUELO .
  aliases NUMERO_VUELO
    for ZIF_GRUPO_MSAA217_~NUMERO_VUELO .
private section.

  aliases LTY_DETALLES_VUELO
    for ZIF_GRUPO_MSAA217_~LTY_DETALLES_VUELO .
  aliases LTY_DOCUMENTOS
    for ZIF_GRUPO_MSAA217_~LTY_DOCUMENTOS .

  data REQUEST_URI type STRING .
  data SERVER_PROTOCOL type STRING .
  data REQUEST_METHOD type STRING .
  data TABLA_INPUTS type LTY_MVT_DETAILS .

  events ERROR_CONEXION .
  class-events SIN_AUTORIZACION .
ENDCLASS.



CLASS ZCL_CONEXION_HTTP_MSAA217 IMPLEMENTATION.


  METHOD get_request_uri.
    request_uri = me->request_uri.
  ENDMETHOD.


  METHOD get_server_protocol.
    server_protocol = me->server_protocol.
  ENDMETHOD.


  METHOD set_request_uri.
    me->request_uri = request_uri.
  ENDMETHOD.


  METHOD set_server_protocol.
    me->server_protocol = server_protocol.
  ENDMETHOD.


  METHOD class_constructor.
    WRITE /'Creando conexiones'.
  ENDMETHOD.


  METHOD comprueba_autorizacion.
    RAISE EVENT sin_autorizacion.
  ENDMETHOD.


  METHOD crea_conexion.
    RAISE EVENT error_conexion.
  ENDMETHOD.


  METHOD zif_grupo_msaa217_~set_codigo_vuelo.
  ENDMETHOD.
ENDCLASS.
