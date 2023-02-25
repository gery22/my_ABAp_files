*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_vuelo DEFINITION.

  PUBLIC SECTION.

  methods obtener_aerolinea IMPORTING connid1 TYPE s_conn_id
                            exporting carrid1 type s_carr_id.

  endclass.

  class lcl_vuelo IMPLEMENTATION.

    METHOD obtener_aerolinea.

      SELECT single carrid
        from sflight
        into carrid1
        where connid eq connid1.
ENDMETHOD.


    ENDCLASS.
