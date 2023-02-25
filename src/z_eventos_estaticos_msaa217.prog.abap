*&---------------------------------------------------------------------*
*& Report z_eventos_estaticos_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_eventos_estaticos_msaa217.


*&---------------------------------------------------------------------*
*& 7. Eventos estáticos
*&---------------------------------------------------------------------*

CLASS lcl_operadora DEFINITION.

  PUBLIC SECTION.

    CLASS-EVENTS nueva_llamada EXPORTING VALUE(telefono_cliente) TYPE string.

    CLASS-METHODS asignar_llamada.

ENDCLASS.

CLASS lcl_operadora IMPLEMENTATION.

  METHOD asignar_llamada.
    WRITE / 'Evento levantado Nueva llamada'.

    RAISE EVENT nueva_llamada EXPORTING telefono_cliente = '640650650'.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_servicio_clientes DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS on_nueva_llamada FOR EVENT nueva_llamada OF lcl_operadora
      IMPORTING telefono_cliente.
ENDCLASS.

CLASS lcl_servicio_clientes IMPLEMENTATION.

  METHOD on_nueva_llamada.

    WRITE: /'You have a new call', telefono_cliente.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  SET HANDLER lcl_servicio_clientes=>on_nueva_llamada.

  lcl_operadora=>asignar_llamada( ).

*&---------------------------------------------------------------------*
*& 8. ALL INSTANCE
*&---------------------------------------------------------------------*

CLASS lcl_dep_administrativo DEFINITION.

  PUBLIC SECTION.

    EVENTS nomina_pagada.

    METHODS avisar_empleado IMPORTING empleado TYPE string.

ENDCLASS.

CLASS lcl_dep_administrativo IMPLEMENTATION.

  METHOD avisar_empleado .
    WRITE: / empleado, 'ha sido avisado'.
    RAISE EVENT nomina_pagada.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_empleado DEFINITION.
  PUBLIC SECTION.
    METHODS on_nomina_pagada FOR EVENT nomina_pagada OF lcl_dep_administrativo.

ENDCLASS.

CLASS lcl_empleado IMPLEMENTATION.

  METHOD on_nomina_pagada.

    WRITE: 'Su nomina ha sido pagada'.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_empleado1          TYPE REF TO  lcl_empleado,
        gr_empleado2          TYPE REF TO  lcl_empleado,
        gr_empleado3          TYPE REF TO  lcl_empleado,
        gr_dep_administrativo TYPE REF TO lcl_dep_administrativo.

  CREATE OBJECT:  gr_empleado1,
                  gr_empleado2,
                  gr_empleado3,
                  gr_dep_administrativo.

  SET HANDLER gr_empleado1->on_nomina_pagada FOR ALL INSTANCES.

  gr_dep_administrativo->avisar_empleado( empleado = 'Empleado 1' ).
