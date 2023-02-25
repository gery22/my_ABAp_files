*&---------------------------------------------------------------------*
*& Report z_polimorfismo_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_polimorfismo_msaa217.


*&--------------------------------------------------------------*
*& 1. Polimorfismo con clases
*&--------------------------------------------------------------*

CLASS lcl_organizacion DEFINITION.
  PUBLIC SECTION.

    METHODS establecer_localizacion.

ENDCLASS.

CLASS lcl_organizacion IMPLEMENTATION.

  METHOD establecer_localizacion.
    WRITE / 'Any Country'.
  ENDMETHOD.

ENDCLASS.



CLASS lcl_organizacion_alemania DEFINITION INHERITING FROM lcl_organizacion.
  PUBLIC SECTION.
    METHODS establecer_localizacion REDEFINITION.
ENDCLASS.

CLASS lcl_organizacion_alemania IMPLEMENTATION.

  METHOD establecer_localizacion.
    WRITE / 'Country : Alemania'.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_organizacion_francia DEFINITION INHERITING FROM lcl_organizacion.
  PUBLIC SECTION.
    METHODS establecer_localizacion REDEFINITION.
ENDCLASS.

CLASS lcl_organizacion_francia IMPLEMENTATION.

  METHOD establecer_localizacion.
    WRITE / 'Country : Francia'.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA : go_organizacion TYPE REF TO lcl_organizacion,
         go_alemania     TYPE REF TO lcl_organizacion_alemania,
         go_francia      TYPE REF TO lcl_organizacion_francia.

  CREATE OBJECT: go_alemania,
                go_francia.

  go_organizacion = go_alemania.
  go_organizacion->establecer_localizacion( ).
  SKIP 2.
  go_organizacion = go_francia.
  go_organizacion->establecer_localizacion( ).

*&--------------------------------------------------------------*
*& 2. Polimorfismo con interfaces
*&--------------------------------------------------------------*

INTERFACE lif_personal.

  METHODS numero_empleados.

ENDINTERFACE.


CLASS lcl_personal_interno DEFINITION.

  PUBLIC SECTION.

    INTERFACES lif_personal.

ENDCLASS.

CLASS lcl_personal_interno IMPLEMENTATION.

  METHOD lif_personal~numero_empleados.
    WRITE / '100 Internos'.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_personal_expatriado DEFINITION.

  PUBLIC SECTION.

    INTERFACES lif_personal.

ENDCLASS.

CLASS lcl_personal_expatriado IMPLEMENTATION.

  METHOD lif_personal~numero_empleados.
    WRITE / '50 Expats'.
  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.

  DATA: go_personal TYPE REF TO lif_personal,
        go_internos TYPE REF TO lcl_personal_interno,
        go_expats   TYPE REF TO lcl_personal_expatriado.

  CREATE OBJECT: go_expats,
                 go_internos.

  go_personal = go_internos.
  go_personal->numero_empleados( ).

  SKIP 2.

  go_personal = go_expats.
  go_personal->numero_empleados( ).



*&--------------------------------------------------------------*
*& 3. Asociación (un objeto usa al otro)
*&--------------------------------------------------------------*

CLASS lcl_alumno  DEFINITION.
  PUBLIC SECTION.
    DATA nombre TYPE string.
    METHODS actualiza_nombre IMPORTING nombre TYPE string.

ENDCLASS.

CLASS lcl_alumno IMPLEMENTATION.

  METHOD actualiza_nombre.
    me->nombre = nombre.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_colegio DEFINITION.

  PUBLIC SECTION.
    DATA alumno TYPE REF TO lcl_alumno.
    METHODS matricular_alumno IMPORTING alumno TYPE REF TO lcl_alumno.
ENDCLASS.

CLASS lcl_colegio IMPLEMENTATION.

  METHOD matricular_alumno.
    me->alumno = alumno.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: go_alumno  TYPE REF TO lcl_alumno,
        go_colegio TYPE REF TO lcl_colegio.

  CREATE OBJECT: go_alumno,
                 go_colegio.

  go_alumno->nombre = 'Harry'.

  go_colegio->matricular_alumno( alumno = go_alumno ).

  WRITE go_colegio->alumno->nombre.
  go_colegio->alumno->nombre = 'Hermione'.

  WRITE / go_alumno->nombre.


*&--------------------------------------------------------------*
*& 4. Composición
*&--------------------------------------------------------------*
CLASS lcl_pantalla DEFINITION.
  PUBLIC SECTION.
    DATA tipo_pantalla TYPE string VALUE 'Nokia'.
    METHODS set_tipo_pantalla IMPORTING tipo_pantalla TYPE string.
ENDCLASS.

CLASS lcl_pantalla IMPLEMENTATION.

  METHOD set_tipo_pantalla.
    me->tipo_pantalla = tipo_pantalla.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_telefono DEFINITION.

  PUBLIC SECTION.

    DATA lo_pantalla TYPE REF TO lcl_pantalla.

    METHODS constructor IMPORTING pantalla TYPE REF TO lcl_pantalla.

ENDCLASS.

CLASS lcl_telefono IMPLEMENTATION.

  METHOD constructor.
    me->lo_pantalla = pantalla.
    WRITE: / 'La pantalla es', pantalla->tipo_pantalla.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA:
    go_pantalla TYPE REF TO lcl_pantalla,
    go_telefono TYPE REF TO lcl_telefono.

  CREATE OBJECT:
                 go_pantalla,
                 go_telefono
    EXPORTING
      pantalla = go_pantalla.

  go_telefono->lo_pantalla->set_tipo_pantalla( tipo_pantalla = 'xiaomi' ).
  WRITE: / 'La pantalla esperada es Xiaomi', go_pantalla->tipo_pantalla.



*&--------------------------------------------------------------*
*& 5. Múltiples referencias apuntando al mismo objeto
*&--------------------------------------------------------------*
CLASS lcl_precio_producto DEFINITION.

  PUBLIC SECTION.

    DATA precio TYPE i.

ENDCLASS.

START-OF-SELECTION.

  DATA: go_inst1 TYPE REF TO lcl_precio_producto,
        go_inst2 TYPE REF TO lcl_precio_producto.

  CREATE OBJECT go_inst1.

  go_inst2 = go_inst1.

  go_inst2->precio = 20.

  WRITE / go_inst1->precio.




*&--------------------------------------------------------------*
*& 6. Crear instancias de tipos distintos
*&--------------------------------------------------------------*

CLASS lcl_presupuesto DEFINITION ABSTRACT.

  PUBLIC SECTION.

    METHODS set_presupuesto ABSTRACT.

ENDCLASS.

CLASS lcl_presupuesto IMPLEMENTATION.

ENDCLASS.

CLASS lcl_presupuesto_negocio DEFINITION INHERITING FROM lcl_presupuesto.

  PUBLIC SECTION.
    METHODS: set_presupuesto REDEFINITION,
      metodo_test.

ENDCLASS.


CLASS lcl_presupuesto_negocio IMPLEMENTATION.

  METHOD set_presupuesto.

    WRITE /'Presupuesto set'.

  ENDMETHOD.
  METHOD metodo_test.
    WRITE / 'Test ok'.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: go_abstract TYPE REF TO lcl_presupuesto.


  CREATE OBJECT go_abstract TYPE lcl_presupuesto_negocio. "importante aqui en crear object type (diferente al declarado, pero con relacion de herencia)


  go_abstract->set_presupuesto( ).

* go_abstract->metodo_test( ). el metodo no existe, por lo tanto la referencia apunta solo a los metodos de la clase madre y no a los metodos de la clase hija.



*&--------------------------------------------------------------*
*& 7. Asignar instancias a la clase genérica Object
*&--------------------------------------------------------------*

CLASS lcl_organizacion1 DEFINITION.

  PUBLIC SECTION.

    DATA sede TYPE string.

    METHODS: set_sede IMPORTING sede TYPE string,
      ver_sede.
ENDCLASS.

CLASS lcl_organizacion1 IMPLEMENTATION.

  METHOD set_sede.
    me->sede = sede.
  ENDMETHOD.

  METHOD ver_sede.
    WRITE / me->sede.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: go_object      TYPE REF TO object,
        gv_method_name TYPE string,
        gv_sede        TYPE string.

  CREATE OBJECT go_object TYPE lcl_organizacion1.

  gv_method_name = 'SET_SEDE'.
  gv_sede = 'genova'.

  CALL METHOD go_object->(gv_method_name) EXPORTING sede = gv_sede.
  gv_method_name = 'VER_SEDE'.
  CALL METHOD go_object->(gv_method_name).

  WRITE / 'Thanks for using my program'.
