*&---------------------------------------------------------------------*
*& Report z_interfaces_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_interfaces_msaa217.

*&--------------------------------------------------------*
*& 1. Definir interfaces
*&--------------------------------------------------------*

INTERFACE lif_libro.
  METHODS set_titulo.
ENDINTERFACE.


CLASS lcl_sociales DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_libro.
ENDCLASS.


CLASS lcl_sociales IMPLEMENTATION.
  METHOD lif_libro~set_titulo.
    WRITE / 'Libro SET'.
  ENDMETHOD.
ENDCLASS.

*&--------------------------------------------------------*
*& 2. Implementación de múltiples interfaces
*&--------------------------------------------------------*

INTERFACE lif_alta.
  METHODS alta_propuesta.
ENDINTERFACE.


INTERFACE lif_modificacion.
  METHODS modificacion_propuesta.
ENDINTERFACE.

CLASS lcl_propuesta DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_alta,
      lif_modificacion.
ENDCLASS.

CLASS lcl_propuesta IMPLEMENTATION.

  METHOD lif_alta~alta_propuesta.
    WRITE / 'Implementacion Alta'.
  ENDMETHOD.

  METHOD lif_modificacion~modificacion_propuesta.
    WRITE / 'Implementacion Modificacion'.
  ENDMETHOD.

ENDCLASS.




*&--------------------------------------------------------*
*& 3. Interfaces anidadas
*&--------------------------------------------------------*

INTERFACE lif_comunidad.

  DATA comunidad TYPE string.
  METHODS set_comunidad IMPORTING comunidad TYPE string.

ENDINTERFACE.


INTERFACE lif_ciudad.

  INTERFACES lif_comunidad.

  DATA ciudad TYPE string.

  METHODS set_ciudad IMPORTING ciudad TYPE string.

ENDINTERFACE.

CLASS lcl_edificio DEFINITION.

  PUBLIC SECTION.

    INTERFACES lif_ciudad.

    DATA edificio TYPE string.

    METHODS set_edificio IMPORTING edificio TYPE string.

ENDCLASS.

CLASS lcl_edificio IMPLEMENTATION.

  METHOD lif_ciudad~set_ciudad.

    me->lif_ciudad~ciudad = ciudad.

    WRITE / ' Ciudad SET'.
  ENDMETHOD.

  METHOD lif_comunidad~set_comunidad.

    me->lif_comunidad~comunidad = comunidad.

    WRITE / ' Comunidad SET'.
  ENDMETHOD.

  METHOD set_edificio.

    me->edificio = edificio.
    WRITE / ' Edificio SET'.

  ENDMETHOD.

ENDCLASS.


*&--------------------------------------------------------*
*& 4. Interfaces alias
*&--------------------------------------------------------*
INTERFACE lif_plantilla.
  DATA: body   TYPE string,
        header TYPE string.
  METHODS : set_header IMPORTING header TYPE string,
    set_body IMPORTING body TYPE string.

ENDINTERFACE.

CLASS lcl_office_doc DEFINITION.

  PUBLIC SECTION.

    INTERFACES lif_plantilla.

    ALIASES: set_body FOR lif_plantilla~set_body,
            set_header FOR lif_plantilla~set_header,
            body FOR lif_plantilla~body,
            header FOR lif_plantilla~header.
ENDCLASS.

CLASS lcl_office_doc IMPLEMENTATION.

  METHOD set_body.

    me->body = body.

  ENDMETHOD.

  METHOD set_header.

    me->header = header.

  ENDMETHOD.

ENDCLASS.



*&--------------------------------------------------------*
*& 5. Clase abstracta -- no se pueden instanciar, sus hijas si.
* los metodos abstractos se tienen qe redefinir para poder implementar en la clase hijo
*&--------------------------------------------------------*

CLASS lcl_fabrica DEFINITION ABSTRACT.

  PUBLIC SECTION.

    METHODS: linea_produccion ABSTRACT,
      entrada_productos ABSTRACT,
      salida_mercancia.

ENDCLASS.

CLASS lcl_fabrica IMPLEMENTATION.

  METHOD salida_mercancia.
    WRITE / 'Mercancia sale'.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_logistica DEFINITION INHERITING FROM lcl_fabrica.

  PUBLIC SECTION.

    METHODS: linea_produccion REDEFINITION,
      entrada_productos REDEFINITION.

ENDCLASS.

CLASS lcl_logistica IMPLEMENTATION.

  METHOD entrada_productos.

  ENDMETHOD.

  METHOD linea_produccion.

  ENDMETHOD.

ENDCLASS.
