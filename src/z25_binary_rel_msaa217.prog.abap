*&---------------------------------------------------------------------*
*& Report z25_binary_rel_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z25_binary_rel_msaa217.
*&---------------------------------------------------------------------*
*& WARNING EL ENUNCIADO ESTA MAL PORQUE EN LA BASE DE DATOS NO HAY REGISTROS DEL AÑO 2016
* supongo que reportar este tipo de bugs es parte del buen trabajo :)
*&---------------------------------------------------------------------*
data gt_flights type table of zsflight_msaa217.


select * from zsflight_msaa217
into table gt_flights
where  fldate < '20211231' "Reemplazar 2016 por 2021
and fldate < '20211115'.


if sy-subrc eq 0.

cl_demo_output=>display( gt_flights ).
endif.
