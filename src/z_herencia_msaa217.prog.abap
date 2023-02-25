*&---------------------------------------------------------------------*
*& Report z_herencia_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_herencia_msaa217.


*&---------------------------------------------------------------------*
*& 1. Herencia
*&---------------------------------------------------------------------*

CLASS lcl_sistema DEFINITION.

  PUBLIC SECTION.
    DATA arquitectura TYPE string VALUE '64BITS'.

    METHODS obtener_arq RETURNING VALUE(e_arq) TYPE string.

ENDCLASS.

CLASS lcl_sistema IMPLEMENTATION.

  METHOD obtener_arq.
    e_arq = me->arquitectura.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_linux DEFINITION INHERITING FROM lcl_sistema.

ENDCLASS.

START-OF-SELECTION.

  DATA go_linux TYPE REF TO lcl_linux.

  CREATE OBJECT go_linux.

  WRITE / go_linux->obtener_arq(  ).


*&---------------------------------------------------------------------*
*& 2. Constructores con herencia
*&---------------------------------------------------------------------*

CLASS lcl_vista DEFINITION.

  PUBLIC SECTION.

    DATA tipo_vista TYPE string.
    METHODS constructor IMPORTING i_tipo_vista TYPE string.


ENDCLASS.

CLASS lcl_vista IMPLEMENTATION.

  METHOD constructor.
    me->tipo_vista = i_tipo_vista.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_grid DEFINITION INHERITING FROM lcl_vista.

  PUBLIC SECTION.
    DATA box TYPE string.
    METHODS constructor IMPORTING i_tipo_vista TYPE string
                                  i_box        TYPE string.


ENDCLASS.

CLASS lcl_grid IMPLEMENTATION.

  METHOD constructor.

    super->constructor( i_tipo_vista = i_tipo_vista ).
    me->box = i_box.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA go_grid TYPE REF TO lcl_grid.

  CREATE OBJECT go_grid
    EXPORTING
      i_box        = 'BOX'
      i_tipo_vista = 'Linux'.

  WRITE / go_grid->tipo_vista.

*&---------------------------------------------------------------------*
*& 3. Redefinición de métodos
*&---------------------------------------------------------------------*

CLASS lcl_price_flight DEFINITION.

  PUBLIC SECTION.

    DATA ls_prices_flights TYPE sflight.
    DATA lv_price TYPE s_price.

    METHODS add_price IMPORTING i_price TYPE s_price.

ENDCLASS.

CLASS lcl_price_flight IMPLEMENTATION.

  METHOD add_price.

    me->ls_prices_flights-price = i_price.
    WRITE 'Price updated'.

  ENDMETHOD.

ENDCLASS.



CLASS lcl_price_discount DEFINITION INHERITING FROM lcl_price_flight.

  PUBLIC SECTION.

    METHODS add_price REDEFINITION.

ENDCLASS.

CLASS lcl_price_discount IMPLEMENTATION.

  METHOD add_price.

    DATA: ls_prices_flights TYPE sflight.

    me->ls_prices_flights-price = i_price * '0.9'.

  ENDMETHOD.

ENDCLASS.



CLASS lcl_price_super_discount DEFINITION INHERITING FROM lcl_price_flight.

  PUBLIC SECTION.

    METHODS add_price REDEFINITION.


ENDCLASS.

CLASS lcl_price_super_discount IMPLEMENTATION.

  METHOD add_price.

    DATA ls_prices_flights TYPE sflight.

    ls_prices_flights-price = i_price * '0.8'.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: go_price_discount       TYPE REF TO lcl_price_discount,
        go_price_super_discount TYPE REF TO lcl_price_super_discount,
        flight                  TYPE sflight.


  CREATE OBJECT: go_price_discount,
                 go_price_super_discount.

  go_price_discount->add_price( i_price = 100 ).
  go_price_super_discount->add_price( i_price = 100 ).

*&---------------------------------------------------------------------*
*& 4. Widening Cast
*&---------------------------------------------------------------------*


CLASS lcl_animal DEFINITION.

  PUBLIC SECTION.
    METHODS andar.
ENDCLASS.

CLASS lcl_animal IMPLEMENTATION.

  METHOD andar.
    WRITE 'El animal anda'.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_leon DEFINITION INHERITING FROM lcl_animal.

  PUBLIC SECTION.

    METHODS andar REDEFINITION.

ENDCLASS.

CLASS lcl_leon IMPLEMENTATION.

  METHOD andar.

    WRITE / 'El Leon anda'.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: go_animal TYPE REF TO lcl_animal,
        go_leon   TYPE REF TO lcl_leon.

  CREATE OBJECT go_leon.

*Widening cast
  go_animal = go_leon.

  go_animal->andar( ).


*&---------------------------------------------------------------------*
*& 5. Narrowing Cast
*&---------------------------------------------------------------------*
CLASS lcl_animal1 DEFINITION.

  PUBLIC SECTION.
    METHODS andar.
ENDCLASS.

CLASS lcl_animal1 IMPLEMENTATION.

  METHOD andar.
    WRITE 'El animal anda'.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_leon1 DEFINITION INHERITING FROM lcl_animal1.

  PUBLIC SECTION.

    METHODS andar REDEFINITION.

ENDCLASS.

CLASS lcl_leon1 IMPLEMENTATION.

  METHOD andar.

    WRITE / 'El Leon anda'.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: go_animal1 TYPE REF TO lcl_animal1,
        go_leon1   TYPE REF TO lcl_leon1,
        go_leon2   TYPE REF TO lcl_leon1.

  CREATE OBJECT go_leon1.


*Widening Cast
  go_animal1 = go_leon1.

  TRY.
*Narrowing cast
      go_leon2 ?= go_animal1.

    CATCH cx_sy_move_cast_error.

      WRITE / 'cast error'.

  ENDTRY.

  IF go_leon2 IS BOUND.

    go_leon2->andar( ).

  ELSE.

    WRITE / 'El objeto no se ha instanciado'.

  ENDIF.



*&---------------------------------------------------------------------*
*& 6. Clase Final
*&---------------------------------------------------------------------*

CLASS lcl_persona DEFINITION FINAL.

ENDCLASS.

*&---------------------------------------------------------------------*
*& 7. Método final
*&---------------------------------------------------------------------*

CLASS lcl_persona1 DEFINITION.

  PUBLIC SECTION.

    DATA nombre TYPE string.

    METHODS establecer_nombre FINAL IMPORTING i_nombre TYPE string.

ENDCLASS.

CLASS lcl_persona1 IMPLEMENTATION.

  METHOD establecer_nombre.
    me->nombre = i_nombre.
  ENDMETHOD.

ENDCLASS.



*&---------------------------------------------------------------------*
*& 8. Encapsulación de instancias
*&---------------------------------------------------------------------*

CLASS lcl_aula_virtual DEFINITION CREATE PROTECTED.

ENDCLASS.


CLASS lcl_alumno DEFINITION INHERITING FROM lcl_aula_virtual.

  PUBLIC SECTION.

    METHODS asignar_alumno.

ENDCLASS.

CLASS lcl_alumno IMPLEMENTATION.

  METHOD asignar_alumno.

    DATA lo_aula_virtual TYPE REF TO lcl_aula_virtual.
    CREATE OBJECT lo_aula_virtual.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  DATA go_aula_virtual TYPE REF TO lcl_aula_virtual.
* create OBJECT go_aula_virtual.  SOLO POSSIBLE DENTRO DE LA CLASE o LAS SUBCLASES por ser Protected
* para CREATE PRIVATE solo seria visible en la propia clase

*&---------------------------------------------------------------------*
*& 9.Concepto Friends – Clase amiga y 10. Herencia con clase amiga
*&---------------------------------------------------------------------*

CLASS lcl_socio DEFINITION.
  PUBLIC SECTION.
    METHODS get_capital_empresa RETURNING VALUE(capital) TYPE i.
ENDCLASS.


CLASS lcl_empresa DEFINITION FRIENDS lcl_socio.

  PRIVATE SECTION.

    DATA capital TYPE i VALUE '12000000' .
ENDCLASS.



CLASS lcl_socio IMPLEMENTATION.

  METHOD get_capital_empresa.

    DATA lo_empresa TYPE REF TO lcl_empresa.

    CREATE OBJECT lo_empresa.

    capital = lo_empresa->capital.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_colaborador DEFINITION INHERITING FROM lcl_socio.

  PUBLIC SECTION.
    METHODS obtener_capital_empresa RETURNING VALUE(capital) TYPE i.
ENDCLASS.

CLASS lcl_colaborador IMPLEMENTATION.

  METHOD obtener_capital_empresa.

    DATA lo_empresa TYPE REF TO lcl_empresa.

    CREATE OBJECT lo_empresa.

    capital = lo_empresa->capital.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: go_socio       TYPE REF TO lcl_socio,
        go_colaborador TYPE REF TO lcl_colaborador.


  CREATE OBJECT: go_socio,
                 go_colaborador.

  WRITE: / go_socio->get_capital_empresa(  ),
         / go_socio->get_capital_empresa(  ).





  WRITE /'Thanks for using my program'.
