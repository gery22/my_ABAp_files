*&---------------------------------------------------------------------*
*& Report zpoo_01_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_01_msaa217.

*&---------------------------------------------------------------------*
*& 1. Creación de clases
*&---------------------------------------------------------------------*

CLASS lcl_material DEFINITION.

  PUBLIC SECTION.
    DATA: matnr          TYPE matnr,
          fecha_creacion TYPE ersda.

    METHODS: set_matnr IMPORTING i_matnr TYPE matnr,
      set_fecha_creacion IMPORTING i_fecha_creacion TYPE ersda.

ENDCLASS.

CLASS lcl_material IMPLEMENTATION.

  METHOD set_matnr.

    me->matnr = i_matnr.

  ENDMETHOD.


  METHOD set_fecha_creacion.

    me->fecha_creacion = i_fecha_creacion.

  ENDMETHOD.

ENDCLASS.

*&---------------------------------------------------------------------*
*& 2. Encapsulación
*&---------------------------------------------------------------------*

CLASS lcl_contrato DEFINITION.

  PUBLIC SECTION.
    DATA tipo_cntr TYPE c LENGTH 2.

  PROTECTED SECTION.
    DATA fecha_alta TYPE sydatum.

    METHODS set_fecha_alta IMPORTING i_fecha_alta TYPE sydatum.

  PRIVATE SECTION.
    DATA client TYPE string.

ENDCLASS.

CLASS lcl_contrato IMPLEMENTATION.


  METHOD set_fecha_alta.

    me->fecha_alta = i_fecha_alta.

  ENDMETHOD.

ENDCLASS.

*&---------------------------------------------------------------------*
*& 3. Atributos de instancia y atributos estáticos
*&---------------------------------------------------------------------*

*Los atributos com encapsulacion publica son accesibles para todos los usuarios de la clase y para todos
*los métodos de la clase y de cualquier clase que herede de ella.
*Los atributos declarados en la
*sección protegida son accesibles para todos los métodos de la clase
*y de las clases que heredan de ella. Los componentes protegidos
*conforman la interface entre una clase y todas sus subclases.
*Los atributos declarados en la sección privada
*son sólo visibles en los métodos de la misma clase. Los componentes
*privados no forman parte de la interface externa de la clase.
*
*Aunque creo que hay un error de enunciado ya que el punto 3 se refiere a atributos de instancia y estaticos,
*la diferencia entre ellos es que en los de instacia, su valor es diferente para cada instancia y al modificarlos
*no afeta a otras instancis mientras que los atributos estaticos,
*son iguales para todas las instancias y al modificarlos en una instancia,
*el valor se modifica tambien para todas las instancias,
* ya que en realidad su contenido se pasa por referencia y no por valor
*( lo corecto seria modificar desde la clase para mejor lectura del codigo)


*&---------------------------------------------------------------------*
*& 4. Métodos de instancia y métodos estáticos
*&---------------------------------------------------------------------*
CLASS lcl_persona DEFINITION.

  PUBLIC SECTION.
    METHODS: set_edad IMPORTING i_edad TYPE i,
      get_edad EXPORTING e_edad TYPE i.

  PRIVATE SECTION.
    DATA edad TYPE i.


ENDCLASS.

CLASS lcl_persona IMPLEMENTATION.

  METHOD get_edad.

    e_edad = me->edad.
  ENDMETHOD.

  METHOD set_edad.
    me->edad = i_edad.
  ENDMETHOD.

ENDCLASS.

*&---------------------------------------------------------------------*
*& 5. Métodos funcionales
*&---------------------------------------------------------------------*


CLASS lcl_vuelo DEFINITION.

  PUBLIC SECTION.

    METHODS metodo_funcional IMPORTING check          TYPE s_conn_id
                             RETURNING VALUE(outcome) TYPE abap_bool.

ENDCLASS.

CLASS lcl_vuelo IMPLEMENTATION.

  METHOD metodo_funcional.

    DATA lv_connection TYPE s_conn_id.

    SELECT SINGLE connid FROM spfli
            INTO lv_connection
            WHERE connid EQ check.

    IF sy-subrc EQ 0.

      outcome =  abap_true.
    ELSE.
      outcome =  abap_false.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: go_vuelo   TYPE REF TO lcl_vuelo.

  CREATE OBJECT go_vuelo.

  IF go_vuelo->metodo_funcional( check = '0017' ) EQ abap_true.
    MESSAGE 'existe' TYPE 'I'.
  ELSE.
    MESSAGE 'no existe' TYPE 'I' DISPLAY LIKE 'E'.
  ENDIF.

*&---------------------------------------------------------------------*
*& 6. Constructor de instancia y constructor estático
*&---------------------------------------------------------------------*

CLASS lcl_producto DEFINITION.

  PUBLIC SECTION.

    METHODS constructor.

    CLASS-METHODS class_constructor.

    METHODS destructor.

  PRIVATE SECTION.

    DATA pointer TYPE %_c_pointer.

ENDCLASS.

CLASS lcl_producto IMPLEMENTATION.

  METHOD class_constructor.

    WRITE /'constructor estatico'.

  ENDMETHOD.

  METHOD constructor.

    WRITE / 'constructor de instancia'.

  ENDMETHOD.

  METHOD destructor.
    SYSTEM-CALL C-DESTRUCTOR 'fxkmswrt_CDestr_destroy' USING pointer.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA go_constructores TYPE REF TO lcl_producto.

  CREATE OBJECT go_constructores.

*&---------------------------------------------------------------------*
*& 7. Implementar método DESTRUCTOR (ver class lcl_produto method destructor)
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& 8. Utilizar tipos de datos en clases
*&---------------------------------------------------------------------*

CLASS lcl_elementos DEFINITION.

  PUBLIC SECTION.
    TYPES: BEGIN OF types_elem_objetos,
             clase      TYPE string,
             instancia  TYPE string,
             referencia TYPE string,
           END OF types_elem_objetos.

    DATA mi_objeto TYPE types_elem_objetos.

    METHODS set_mi_objeto IMPORTING i_objeto TYPE types_elem_objetos.

ENDCLASS.

CLASS lcl_elementos IMPLEMENTATION.

  METHOD set_mi_objeto.

    me->mi_objeto = i_objeto.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.


*TYPES: BEGIN OF global_types_elem_objetos,
*             clase      TYPE string,
*             instancia  TYPE string,
*             referencia TYPE string,
*           END OF global_types_elem_objetos.


  DATA: go_elementos TYPE REF TO lcl_elementos,
        gs_objeto    TYPE lcl_elementos=>types_elem_objetos.

  gs_objeto-clase = 'spiderman'.
  gs_objeto-instancia = 'Ironman'.
  gs_objeto-referencia = 'Hulk'.

  CREATE OBJECT go_elementos.

  go_elementos->set_mi_objeto( i_objeto = gs_objeto ).



*&---------------------------------------------------------------------*
*& 9. Constantes en clases
*&---------------------------------------------------------------------*

CLASS lcl_amigos DEFINITION.

  PUBLIC SECTION.
    CONSTANTS: amigo1 TYPE string VALUE 'Mario',
               amigo2 TYPE string VALUE 'Luigi',
               amigo3 TYPE string VALUE 'Peach'.
ENDCLASS.

START-OF-SELECTION.

  WRITE: / lcl_amigos=>amigo1,
         / lcl_amigos=>amigo2,
         / lcl_amigos=>amigo3.
*&---------------------------------------------------------------------*
*& 10.READ-ONLY Restringir Acceso Escritura
*&---------------------------------------------------------------------*

CLASS lcl_alumno DEFINITION.

  PUBLIC SECTION.

    DATA fecha_nacimiento TYPE sydatum READ-ONLY.

    METHODS set_fecha_nacimiento IMPORTING i_fecha_nac TYPE sydatum.

ENDCLASS.

CLASS lcl_alumno IMPLEMENTATION.

  METHOD set_fecha_nacimiento.
    me->fecha_nacimiento = i_fecha_nac.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA alumno_1 TYPE REF TO lcl_alumno.

  CREATE OBJECT alumno_1.

  alumno_1->set_fecha_nacimiento( i_fecha_nac = '19790626' ).

  WRITE / alumno_1->fecha_nacimiento.

*&---------------------------------------------------------------------*
*& 11.Parámetro opcional
*&---------------------------------------------------------------------*

CLASS lcl_expedientes DEFINITION.

  PUBLIC SECTION.

    CLASS-DATA: fecha     TYPE sydatum,
                nombre    TYPE string,
                apellido1 TYPE string,
                apellido2 TYPE string.

    CLASS-METHODS abrir_expediente_laboral IMPORTING i_fecha     TYPE sydatum
                                                     i_nombre    TYPE string
                                                     i_apellido1 TYPE string
                                                     i_apellido2 TYPE string OPTIONAL.

ENDCLASS.

CLASS lcl_expedientes IMPLEMENTATION.

  METHOD abrir_expediente_laboral.

    fecha       = i_fecha.
    nombre      = i_nombre.
    apellido1   = i_apellido1.
    apellido2   = i_apellido2.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA go_expedientes TYPE REF TO lcl_expedientes.

  CREATE OBJECT go_expedientes.

  lcl_expedientes=>abrir_expediente_laboral(
    EXPORTING
      i_fecha     =    '19790626'
      i_nombre    =    'Tony'
      i_apellido1 =    'Stark'
*    i_apellido2 =
  ).


*&---------------------------------------------------------------------*
*& 11.Parámetro opcional
*&---------------------------------------------------------------------*

CLASS lcl_cuenta DEFINITION.

  PUBLIC SECTION.

    METHODS: set_numero IMPORTING i_num TYPE string,
      get_numero EXPORTING e_num TYPE string.


  PRIVATE SECTION.

    DATA numero TYPE string.

ENDCLASS.

CLASS lcl_cuenta IMPLEMENTATION.

  METHOD get_numero.

    e_num = me->numero.

  ENDMETHOD.

  METHOD set_numero.

    me->numero = i_num.

  ENDMETHOD.

ENDCLASS.
