*&---------------------------------------------------------------------*
*& Report z_event_interface
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& 5. Definir eventos en las interfaces
*& 6. Desactivar objeto manejador
*&---------------------------------------------------------------------*
REPORT z_event_interface.

INTERFACE lif_navegador.

  EVENTS cerrar_ventana.


ENDINTERFACE.


CLASS lcl_sistema_operativo DEFINITION.

  PUBLIC SECTION.

    INTERFACES lif_navegador.
    METHODS movimiento_raton IMPORTING symbol_clicked TYPE c.
ENDCLASS.

CLASS lcl_sistema_operativo IMPLEMENTATION.

  METHOD movimiento_raton.

    IF symbol_clicked EQ 'X'.

      WRITE / 'Evento disparado'.
      RAISE EVENT lif_navegador~cerrar_ventana.
    ENDIF.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_chrome DEFINITION.

  PUBLIC SECTION.
    METHODS on_cerrar_ventana FOR EVENT lif_navegador~cerrar_ventana OF lcl_sistema_operativo.

ENDCLASS.

CLASS lcl_chrome IMPLEMENTATION.

  METHOD on_cerrar_ventana.

    WRITE / 'window closed'.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_sistema_op TYPE REF TO lcl_sistema_operativo,
        gr_chrome     TYPE REF TO lcl_chrome.

  CREATE OBJECT: gr_sistema_op, gr_chrome.

  SET HANDLER gr_chrome->on_cerrar_ventana FOR gr_sistema_op.

  gr_sistema_op->movimiento_raton( symbol_clicked = 'X' ).

  SET HANDLER gr_chrome->on_cerrar_ventana FOR gr_sistema_op ACTIVATION abap_false.

  gr_sistema_op->movimiento_raton( symbol_clicked = 'X' ).
