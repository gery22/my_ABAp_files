*&---------------------------------------------------------------------*
*& Report z_excep_reanud_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT z_excep_reanud_msaa217.

*&---------------------------------------------------------------------*
*& 8. Implementación de excepciones reanudables
*&---------------------------------------------------------------------*

CLASS lcx_autoriz_iban DEFINITION INHERITING FROM cx_static_check.

  PUBLIC SECTION.

    CONSTANTS lcx_autoriz_iban TYPE string VALUE 'Problema de Iban'.

ENDCLASS.

CLASS lcl_operaciones_banco DEFINITION.

  PUBLIC SECTION.
    METHODS transferencia IMPORTING i_iban TYPE string
                          RAISING   RESUMABLE(lcx_autoriz_iban).


ENDCLASS.

CLASS lcl_operaciones_banco IMPLEMENTATION.

  METHOD transferencia.
    IF i_iban EQ 'ES95 432 987654321'.
      RAISE RESUMABLE EXCEPTION TYPE lcx_autoriz_iban.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA : gr_operaciones_banco TYPE REF TO lcl_operaciones_banco,
         lcx_exception        TYPE REF TO cx_root.

  CREATE OBJECT gr_operaciones_banco.


  TRY.

      gr_operaciones_banco->transferencia( i_iban = 'ES95 432 987654321' ).

      WRITE / 'Reanudamos el poceso'.

    CATCH BEFORE UNWIND lcx_autoriz_iban INTO lcx_exception.

      IF lcx_exception->is_resumable EQ abap_true.
        DATA text TYPE string.
        text = lcx_autoriz_iban=>lcx_autoriz_iban.
        WRITE / text.
        RESUME.
      ELSE.
        WRITE / ' not resumable.'.
      ENDIF.
  ENDTRY.
