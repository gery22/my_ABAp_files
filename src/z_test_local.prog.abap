*&---------------------------------------------------------------------*
*& Report z_test_local
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_test_local.

CLASS lcl_calculadora DEFINITION.
  PUBLIC SECTION.
    METHODS suma    IMPORTING num1             TYPE i
                              num2             TYPE i
                    RETURNING VALUE(resultado) TYPE i.
ENDCLASS.

CLASS lcl_calculadora IMPLEMENTATION.

  METHOD suma.
    resultado = num1 + num2.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_test DEFINITION FOR TESTING
               RISK LEVEL HARMLESS
               DURATION SHORT.

  PUBLIC SECTION.
    METHODS test_suma FOR TESTING.

ENDCLASS.

CLASS lcl_test IMPLEMENTATION.

  METHOD test_suma.
    DATA: lr_calculadora TYPE REF TO lcl_calculadora,
          lv_resultado   TYPE i.

    CREATE OBJECT lr_calculadora.

    lr_calculadora->suma(
      EXPORTING
        num1      = 4
        num2      = 8
      RECEIVING
        resultado = lv_resultado
    ).

*aqui viene la clase testeadora

    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  = 12
        act                  = lv_resultado
        msg                  = 'Suma Incorrecta'
*    level                = if_aunit_constants=>severity-medium
*    tol                  =
*    quit                 = if_aunit_constants=>quit-test
*    ignore_hash_sequence = abap_false
*  RECEIVING
*    assertion_failed     =
    ).

  ENDMETHOD.

ENDCLASS.
