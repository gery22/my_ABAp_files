*&---------------------------------------------------------------------*
*& Report z22_sel_up_to_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z22_sel_up_to_msaa217.

DATA gt_flights TYPE TABLE OF zspfli_msaa217.

SELECT  * FROM zspfli_msaa217
INTO TABLE gt_flights
UP TO 3 ROWS.

cl_demo_output=>display( gt_flights ).
