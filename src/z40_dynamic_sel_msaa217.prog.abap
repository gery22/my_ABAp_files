*&---------------------------------------------------------------------*
*& Report z40_dynamic_sel_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z40_dynamic_sel_msaa217.


PARAMETERS: pa_table TYPE tabname,
            pa_col   TYPE c LENGTH 50,
            pa_cond  TYPE c LENGTH 50.

FIELD-SYMBOLS <gt_itab> TYPE STANDARD TABLE.   "TYPE ANY TABLE

DATA: gr_tref        TYPE REF TO data,  "data son datos genericos para modificar los datos necesitamos pasar un puntero
      grx_exception TYPE REF TO cx_root.

try.

" RTTI
DATA(gr_comp_table) = CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_name( p_name = pa_table ) )->get_components( ). "CAST viene de narrow cast


" RTCC
data(gr_struct_type) = cl_abap_structdescr=>create( gr_comp_table ).

data(gr_table_type) = cl_abap_tabledescr=>create( p_line_type = gr_struct_type ).

CREATE DATA gr_tref TYPE HANDLE gr_table_type.  " type handle significa

assign gr_tref->* to <gt_itab>. "->*  es un desreferenciador



select (pa_col) from (pa_table)
into CORRESPONDING FIELDS OF table <gt_itab>
where (pa_cond).

catch cx_root INTO grx_exception.
write grx_exception->get_text( ).

ENDtry.

if <gt_itab> is not INITIAL.

cl_demo_output=>display( <gt_itab> ).

endif.
