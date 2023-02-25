*&---------------------------------------------------------------------*
*& Report z_model_view_controler_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_model_view_controler_msaa217.

*clase para procesar datos (db, etc)
CLASS lcl_modelo DEFINITION.

  PUBLIC SECTION.
    METHODS: constructor IMPORTING vuelo TYPE s_carr_id,

      set_vuelos IMPORTING vuelo TYPE s_carr_id,
      get_vuelos EXPORTING lt_vuelos TYPE STANDARD TABLE.  " No se como exportr tabla interna, el typo de dato me d error, entonces pasare una estructura


    DATA vuelos TYPE TABLE OF sflight.



ENDCLASS.

CLASS lcl_modelo IMPLEMENTATION.

  METHOD constructor.

    SELECT FROM sflight
        FIELDS *
        WHERE carrid EQ @vuelo
        INTO TABLE @me->vuelos.


  ENDMETHOD.

  METHOD get_vuelos.
    lt_vuelos = me->vuelos.
  ENDMETHOD.

  METHOD set_vuelos.
    SELECT  FROM sflight
          FIELDS *
          WHERE carrid EQ @vuelo
          INTO TABLE @me->vuelos.
  ENDMETHOD.

ENDCLASS.

*clase para viualizacion

CLASS lcl_vista DEFINITION.
  PUBLIC SECTION.
    METHODS display_vuelos IMPORTING vuelos TYPE STANDARD TABLE.

ENDCLASS.

CLASS lcl_vista IMPLEMENTATION.

  METHOD display_vuelos.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      TABLES
        t_outtab      = vuelos
      EXCEPTIONS
        program_error = 1
        OTHERS        = 2.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.


  ENDMETHOD.

ENDCLASS.

CLASS lcl_controller DEFINITION.

  PUBLIC SECTION.
    METHODS: set_modelo IMPORTING modelo TYPE REF TO lcl_modelo,
      get_modelo EXPORTING modelo TYPE REF TO lcl_modelo,

      set_vista IMPORTING vista TYPE REF TO lcl_vista,
      get_vista EXPORTING vista TYPE REF TO lcl_vista.


    DATA: modelo TYPE REF TO lcl_modelo,
          vista  TYPE REF TO lcl_vista.

ENDCLASS.

*clase contrladora

CLASS lcl_controller IMPLEMENTATION.

  METHOD get_modelo.
    modelo = me->modelo.
  ENDMETHOD.

  METHOD get_vista.
    vista = me->vista.
  ENDMETHOD.

  METHOD set_modelo.
    me->modelo = modelo.
  ENDMETHOD.

  METHOD set_vista.

    DATA: lv_vuelo  TYPE s_carr_id,
          lt_vuelos TYPE TABLE OF sflight.

    me->vista = vista.

    modelo->get_vuelos(
      IMPORTING
        lt_vuelos = lt_vuelos
    ).

    vista->display_vuelos( vuelos = lt_vuelos ).

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  PARAMETERS pa_vuelo TYPE s_carr_id.

  DATA: gr_modelo      TYPE REF TO lcl_modelo,
        gr_vista       TYPE REF TO  lcl_vista,
        gr_controlador TYPE REF TO lcl_controller.


  CREATE OBJECT gr_modelo
    EXPORTING
      vuelo = pa_vuelo.

  CREATE OBJECT: gr_vista,
                 gr_controlador.

  gr_controlador->set_modelo( modelo = gr_modelo ).
  gr_controlador->set_vista( vista =  gr_vista ).
