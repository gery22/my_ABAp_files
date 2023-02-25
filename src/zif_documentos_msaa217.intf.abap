INTERFACE zif_documentos_msaa217
  PUBLIC .


  TYPES activation TYPE REF TO cl_aab_id .
  TYPES rango_po_doc TYPE /cwm/r_vbeln .

  DATA doc_ventas TYPE vbeln_va .

  CLASS-EVENTS deudor_desconocido
    EXPORTING
      VALUE(deudor) TYPE kunnr OPTIONAL .
  EVENTS sin_usuario_resp
    EXPORTING
      VALUE(doc_ventas) TYPE vbeln_va OPTIONAL .

  METHODS set_doc_ventas
    IMPORTING
      VALUE(doc_ventas) TYPE vbeln_va .
ENDINTERFACE.
