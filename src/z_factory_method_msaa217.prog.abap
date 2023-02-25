*&---------------------------------------------------------------------*
*& Report z_factory_method_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_factory_method_msaa217.

*&---------------------------------------------------------------------*
*& 2. Patrón de diseño FACTORY METHOD
*&---------------------------------------------------------------------*

INTERFACE lif_expediente.

METHODS tipo_expediente.

ENDINTERFACE.

class lcl_expediente_obra DEFINITION.

PUBLIC SECTION.
INTERFACES lif_expediente.
ALIASES tipo_expediente for lif_expediente~tipo_expediente.

ENDCLASS.

CLASS lcl_expediente_obra IMPLEMENTATION.

  METHOD tipo_expediente.
write / ' Expediente Obra'.
  ENDMETHOD.

ENDCLASS.

class lcl_expediente_suministro DEFINITION.

PUBLIC SECTION.
INTERFACES lif_expediente.
ALIASES tipo_expediente for lif_expediente~tipo_expediente.

ENDCLASS.

CLASS lcl_expediente_suministro IMPLEMENTATION.

  METHOD tipo_expediente.
write / ' Expediente Suministro'.
  ENDMETHOD.

ENDCLASS.



class lcl_factoria DEFINITION.
PUBLIC SECTION.
METHODS crear_expediente IMPORTING tipo_expediente type string
                         RETURNING VALUE(objeto_expediente) TYPE REF TO lif_expediente.

ENDCLASS.

CLASS lcl_factoria IMPLEMENTATION.

  METHOD crear_expediente.
case tipo_expediente..
  when 'Obra'.
  create OBJECT objeto_expediente TYPE lcl_expediente_obra.

    When 'Suministro'.

    create OBJECT objeto_expediente TYPE lcl_expediente_suministro.
endcase.

  ENDMETHOD.

ENDCLASS.




PARAMETERS: pa_obra RADIOBUTTON GROUP cntr,
            pa_sumin RADIOBUTTON GROUP cntr.

START-OF-SELECTION.

data: gr_expediente TYPE REF TO lif_expediente,
      gr_factoria TYPE REF TO  lcl_factoria.

      CREATE object gr_factoria.

CASE abap_true.

when pa_obra.

gr_expediente = gr_factoria->crear_expediente( tipo_expediente = 'Obra' ).

when pa_sumin.

gr_expediente = gr_factoria->crear_expediente( tipo_expediente = 'Suministro' ).

ENDCASE.

gr_expediente->tipo_expediente( ).
