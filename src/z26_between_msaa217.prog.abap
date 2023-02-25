*&---------------------------------------------------------------------*
*& Report z_26_between_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z26_between_msaa217.

data gt_flights type table of zsflight_msaa217.


select * from zsflight_msaa217
into table gt_flights
where  fldate BETWEEN '20211105' "Reemplazar 2016 por 2021
and  '20211231'.


if sy-subrc eq 0.

cl_demo_output=>display( gt_flights ).
endif.
