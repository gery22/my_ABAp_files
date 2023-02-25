interface ZIF_GRUPO_MSAA217_
  public .


  types LTY_DOCUMENTOS type ref to ZIF_DOCUMENTOS_MSAA217 .
  types:
    BEGIN OF lty_detalles_vuelo,
      codigo_vuelo TYPE s_carr_id,
      numero_vuelo TYPE s_conn_id,
      fecha_vuelo  TYPE s_date,
      precio       TYPE s_price,
    END OF lty_detalles_vuelo .

  class-data NUMERO_VUELO type S_CONN_ID .
  data CODIGO_VUELO type S_CARR_ID .

  events AVISAR_PRECIO_VUELO
    exporting
      value(E_PRICE) type S_PRICE .

  methods SET_CODIGO_VUELO
    importing
      value(CODIGO_VUELO) type S_CARR_ID .
  methods SET_GM_CODE .
endinterface.
