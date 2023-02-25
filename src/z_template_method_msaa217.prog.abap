*&---------------------------------------------------------------------*
*& Report z_template_method_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_template_method_msaa217.

CLASS lcl_viaje DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS constructor IMPORTING pasajeros TYPE i.
  PROTECTED SECTION.
    DATA numero_de_pasajeros TYPE i.

    METHODS:

      transporte_ida ABSTRACT,
      dia_uno ABSTRACT,
      dia_dos ABSTRACT,
      dia_tres ABSTRACT,
      transporte_vuelta ABSTRACT,
      realizar_viaje FINAL. "Al ser metodo final, no se puede redefinir en las clases hijas
ENDCLASS.

CLASS lcl_viaje IMPLEMENTATION.

  METHOD realizar_viaje.

    transporte_ida( ).
    dia_uno( ).
    dia_dos( ).
    dia_tres( ).
    transporte_vuelta( ).

  ENDMETHOD.


  METHOD constructor.
    me->numero_de_pasajeros = pasajeros.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_paquete_a DEFINITION INHERITING FROM lcl_viaje.

  PROTECTED SECTION.

    METHODS: transporte_ida REDEFINITION,
      dia_uno REDEFINITION,
      dia_dos REDEFINITION,
      dia_tres REDEFINITION,
      transporte_vuelta REDEFINITION.

ENDCLASS.

CLASS lcl_paquete_a IMPLEMENTATION.

  METHOD dia_dos.
    WRITE:  / 'Viaje en tren a Luxor para ', me->numero_de_pasajeros, ' pasajeros'.
  ENDMETHOD.

  METHOD dia_tres.
    WRITE:  / 'Buceo en Sharm El Sheik para ', me->numero_de_pasajeros, ' pasajeros'.
  ENDMETHOD.

  METHOD dia_uno.
    WRITE:  / 'Entradas a Keops para ', me->numero_de_pasajeros, ' pasajeros'.
  ENDMETHOD.

  METHOD transporte_ida.
    WRITE:  / 'Billetes al Cairo para ', me->numero_de_pasajeros, ' pasajeros'.
  ENDMETHOD.

  METHOD transporte_vuelta.
    WRITE:  / 'Billetes de regreso a Madrid para ', me->numero_de_pasajeros, ' pasajeros'.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_paquete_b DEFINITION INHERITING FROM lcl_viaje.

  PROTECTED SECTION.

    METHODS: transporte_ida REDEFINITION,
      dia_uno REDEFINITION,
      dia_dos REDEFINITION,
      dia_tres REDEFINITION,
      transporte_vuelta REDEFINITION.

ENDCLASS.

CLASS lcl_paquete_b IMPLEMENTATION.

  METHOD dia_dos.
    WRITE:  / 'Viaje en camion a Yucatan para ', me->numero_de_pasajeros, ' pasajeros'.
  ENDMETHOD.

  METHOD dia_tres.
    WRITE:  / 'Buceo en Isla Mujeres para ', me->numero_de_pasajeros, ' pasajeros'.
  ENDMETHOD.

  METHOD dia_uno.
    WRITE:  / 'Entradas Tehotihuacan para ', me->numero_de_pasajeros, ' pasajeros'.
  ENDMETHOD.

  METHOD transporte_ida.
    WRITE:  / 'Billetes a Mexico city para ', me->numero_de_pasajeros, ' pasajeros'.
  ENDMETHOD.

  METHOD transporte_vuelta.
    WRITE:  / 'Billetes de regreso a Madrid para ', me->numero_de_pasajeros, ' pasajeros'.
  ENDMETHOD.

ENDCLASS.
