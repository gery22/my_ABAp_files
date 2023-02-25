*&---------------------------------------------------------------------*
*& Report z_cleanup_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_cleanup_msaa217.

*&---------------------------------------------------------------------*
*&  7. Estructura de control CLEANUP
*&---------------------------------------------------------------------*

PARAMETERS: pa_n1 TYPE i,
            pa_n2 TYPE i.

DATA: gv_resultado  TYPE i,
      gcx_exception TYPE REF TO cx_root.



TRY.
    TRY.

        gv_resultado = pa_n1 + pa_n2.
        gv_resultado = pa_n1 / pa_n2.
        gv_resultado = pa_n1 - pa_n2.

      CATCH zcx_acceso_msaa217.

        WRITE: 'No tiene permiso'.
      CLEANUP INTO gcx_exception.
        WRITE: / 'Estructura de control Cleanup',
               / gcx_exception->get_text( ),

               / 'Resultado = ', gv_resultado.

    ENDTRY.
  CATCH cx_sy_zerodivide INTO gcx_exception.
    WRITE / gcx_exception->get_longtext(
*            preserve_newlines =
            ).
ENDTRY.
