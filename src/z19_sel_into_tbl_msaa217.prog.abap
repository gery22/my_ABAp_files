*&---------------------------------------------------------------------*
*& Report z19_sel_into_tbl_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z19_sel_into_tbl_msaa217.

data:  gwa_flight type zspfli_msaa217,
       gt_flights type table of zspfli_msaa217.


select * from zspfli_msaa217
into table gt_flights.


APPEND INITIAL LINE TO gt_flights.

select * from zspfli_msaa217
APPENDING table gt_flights.

cl_demo_output=>display( gt_flights ).
