*&---------------------------------------------------------------------*
*& Report z20_se_endsel_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z20_se_endsel_msaa217.



data:  gwa_flight type zspfli_msaa217,
       gt_flights type table of zspfli_msaa217.


select * from zspfli_msaa217 into gwa_flight
where distid eq 'KM'.

gwa_flight-distid = 'MI'.
gwa_flight-distance = gwa_flight-distance * '0.621371' .
APPEND gwa_flight to gt_flights.

ENDSELECT.

cl_demo_output=>display( gt_flights ).
