*&---------------------------------------------------------------------*
*& Report z41_alias_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z41_alias_msaa217.


TYPES:BEGIN OF gty_flights,
      ciudad_salida type s_from_cit,
      ciudad_llegada type s_to_city,
      END OF gty_flights.

data gt_flights type STANDARD TABLE OF gty_flights.

select cityfrom as ciudad_salida
       cityto as ciudad_llegada
       from zspfli_msaa217
       into table gt_flights.

 if sy-subrc eq 0.

 cl_demo_output=>display( gt_flights ).

 endif.
