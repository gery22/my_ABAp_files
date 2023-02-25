*&---------------------------------------------------------------------*
*& Report z_eventos_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_eventos_msaa217.

*&--------------------------------------------*
*& 1. Definición y levantamiento de objetos
*& 2. Establecer clase receptora
*& 3. Establecer referencia manejadora – EVENT HANDLER
*& 4. Utilizar la referencia del objeto diseñador con SENDER
*&--------------------------------------------*

* clase emisora del evento
CLASS lcl_screen DEFINITION.

  PUBLIC SECTION.
    DATA screen_type TYPE string.
    EVENTS touch_screen EXPORTING VALUE(lv_x) TYPE i
                                  VALUE(lv_y) TYPE i.

    METHODS: constructor IMPORTING screen_type TYPE string,
      touch IMPORTING touched TYPE c.

ENDCLASS.

CLASS lcl_screen IMPLEMENTATION.

  METHOD touch.
    IF touched EQ 'y'.
      RAISE EVENT touch_screen EXPORTING lv_x = 23 lv_y = 32.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.
    me->screen_type = screen_type.
  ENDMETHOD.

ENDCLASS.

* clase receptora del evento
CLASS lcl_navegacion DEFINITION.

  PUBLIC SECTION.

*******BIG WARNING!!!  tuve que importar el sender aqui (en el video no esta hecho asi) sino me da error, me dice que sender no esta reconocido.
    METHODS on_touch_screen FOR EVENT touch_screen OF lcl_screen
      IMPORTING lv_x lv_y sender.

ENDCLASS.

CLASS lcl_navegacion IMPLEMENTATION.

  METHOD on_touch_screen.
    WRITE: / 'Screen touched on X = ', lv_x , 'and Y = ', lv_y.

    WRITE / sender->screen_type.



* sender->screen_type ESTA SENTENCIA NO ME LA PERMITE AL IGUAL QUE EN EL VIDEO SIN ANTES IMPORTAR EL SENDER

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_screen     TYPE REF TO lcl_screen,
        gr_navegacion TYPE REF TO lcl_navegacion.


  CREATE OBJECT: gr_navegacion,
                   gr_screen
    EXPORTING
      screen_type = 'Touch ME XT3'.


  SET HANDLER gr_navegacion->on_touch_screen FOR gr_screen.

  gr_screen->touch( touched = 'y' ).
