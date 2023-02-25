*&---------------------------------------------------------------------*
*& Report z22_sel_up_to_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z24_sel_up_to_msaa217.

DATA: gt_flights TYPE TABLE OF zspfli_msaa217,
      gt_airline TYPE TABLE OF zsflight_msaa217.
SELECT  * FROM zspfli_msaa217
INTO TABLE gt_flights
UP TO 3 ROWS.



SELECT  * FROM zsflight_msaa217
INTO TABLE gt_airline
FOR ALL ENTRIES IN gt_flights
WHERE carrid EQ gt_flights-carrid
      AND connid EQ gt_flights-connid.



cl_demo_output=>display( gt_airline ).
