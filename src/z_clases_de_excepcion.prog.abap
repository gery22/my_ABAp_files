*&---------------------------------------------------------------------*
*& Report z_clases_de_excepcion
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_clases_de_excepcion.


*&---------------------------------------------------------------------*
*& 3. Emitir excepciones basadas en clases
*& 4. Estructura de control TRY-CATCH-ENDTRY
*&---------------------------------------------------------------------*

CLASS lcl_check_user DEFINITION.

  PUBLIC SECTION.

    METHODS check_user IMPORTING user TYPE syuname
                       RAISING   zcx_acceso_msaa217.

ENDCLASS.

CLASS lcl_check_user IMPLEMENTATION.

  METHOD check_user.

    DATA:lv_msgv1 TYPE msgv1,
         lv_msgv2 TYPE msgv2,
         lv_msgv3 TYPE msgv3,
         lv_msgv4 TYPE msgv4.

    lv_msgv1 = sy-uname.
    lv_msgv2 = sy-repid.
    lv_msgv3 = sy-datum.
    lv_msgv4 = sy-uzeit.

    IF user EQ 'MSAA217'.

      RAISE EXCEPTION TYPE zcx_acceso_msaa217
        EXPORTING
*         textid   =
*         previous =
          msgv1 = lv_msgv1
          msgv2 = lv_msgv2
          msgv3 = lv_msgv3
          msgv4 = lv_msgv4.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gcx_acceso     TYPE REF TO zcx_acceso_msaa217,
        gcl_check_user TYPE REF TO lcl_check_user.

  CREATE OBJECT gcl_check_user.

  TRY.
      gcl_check_user->check_user( user = sy-uname ).

    CATCH zcx_acceso_msaa217 INTO gcx_acceso.

      WRITE: / gcx_acceso->get_text( ).

*   write 'Se ha emitido la excepcion'.
  ENDTRY.
