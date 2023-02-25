*&---------------------------------------------------------------------*
*& Report z39_dynamic_table_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z39_dynamic_table_msaa217.

data lv_fields type string.
PARAMETERS: pa_table TYPE c LENGTH 16,

             pa_carri type c AS CHECKBOX,
            pa_pla type c AS CHECKBOX,
            pa_seat type c AS CHECKBOX.



START-OF-SELECTION.
clear lv_fields.

if pa_carri eq abap_true.

data(lv_carri) = 'carrid'.

endif.

if pa_pla eq abap_true.

data(lv_pla) = 'planetype'.

endif.

if pa_seat eq abap_true.

data(lv_seat) = 'seatsmax'.

endif.


CONCATENATE lv_carri lv_pla lv_seat INTO lv_fields SEPARATED BY space.



TYPES:BEGIN OF gty_table,
        carrid type s_carr_id,
        planetype TYPE s_planetye,
        seatsmax  TYPE s_seatsmax,
      END OF gty_table.

DATA gt_table TYPE TABLE OF gty_table.

SELECT (lv_fields) FROM (pa_table)
INTO CORRESPONDING FIELDS OF TABLE gt_table.

IF sy-subrc EQ 0.

  cl_demo_output=>display( gt_table ).

ENDIF.
