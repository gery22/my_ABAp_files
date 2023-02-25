*&---------------------------------------------------------------------*
*& Report z21_sel_col_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z21_sel_col_msaa217.

TYPES: BEGIN OF gty_flights,
         carrid   TYPE s_carrid,
         cityfrom TYPE s_from_cit,
         airpfrom TYPE s_fromairp,
         cityto   TYPE s_to_city,
         airpto   TYPE s_toairp,
       END OF gty_flights.

DATA: gwa_flight TYPE gty_flights,
      gt_flights TYPE TABLE OF gty_flights.

SELECT carrid  cityfrom airpfrom cityto airpto   FROM zspfli_msaa217

INTO TABLE gt_flights.

cl_demo_output=>display( gt_flights ).
