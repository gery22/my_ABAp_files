*&---------------------------------------------------------------------*
*& Report z_bloqueo_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_bloqueo_msaa217.

DATA gs_factura TYPE zfact_msaa217.

CALL FUNCTION 'ENQUEUE_EZ_FACT_MSAA217'
  EXPORTING
    mode_zfact_msaa217 = 'E'
*   mandt              = SY-MANDT
*   factura            =
*   x_factura          = space
*   _scope             = '2'
*   _wait              = space
*   _collect           = ' '
  EXCEPTIONS
    foreign_lock       = 1
    system_failure     = 2
    OTHERS             = 3.
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

gs_factura-factura   = '21321231'.
gs_factura-cls_fact  = 'abcd'.
gs_factura-tp_fact   = 'A'.
gs_factura-tp_doc    = 'A'.
gs_factura-ejecicio  = '2020'.

INSERT zfact_msaa217 FROM gs_factura.

IF sy-subrc EQ 0.

  MESSAGE i001(00) WITH 'Registro insertado correctamente'.

ENDIF.

CALL FUNCTION 'DEQUEUE_EZ_FACT_MSAA217'
*  EXPORTING
*    mode_zfact_msaa217 = 'E'
*    mandt              = SY-MANDT
*    factura            =
*    x_factura          = space
*    _scope             = '3'
*    _synchron          = space
*    _collect           = ' '
  .
