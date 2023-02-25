*&---------------------------------------------------------------------*
*& Report z_retry_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_retry_msaa217.


*&---------------------------------------------------------------------*
*& 5. Estructura de control RETRY
*&---------------------------------------------------------------------*

START-OF-SELECTION.

  DATA: gv_resutado   TYPE i,
        gv_n1         TYPE i,
        gv_n2         TYPE i,
        gcx_exception TYPE REF TO cx_root.

  gv_n1 = 10.
  gv_n2 = 0.


  TRY.
      gv_resutado = gv_n1 / gv_n2.
      write / gv_resutado.
    CATCH cx_root INTO gcx_exception.
      WRITE gcx_exception->get_text( ).
      gv_n2 = 1.
      RETRY.

  ENDTRY.

*&---------------------------------------------------------------------*
*& 6. Excepciones basadas en clases en el Debugger
*&---------------------------------------------------------------------*

* La clase es del tipo  CX_SY_ZERODIVIDE
