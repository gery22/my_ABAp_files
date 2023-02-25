*&---------------------------------------------------------------------*
*& Report z15_sel_single
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z15_sel_single.


TYPES: BEGIN OF gty_flights,
         carrid   TYPE s_carrid,
         cityfrom TYPE s_from_cit,
         airpfrom TYPE s_fromairp,
         cityto   TYPE s_to_city,
         airpto  TYPE s_toairp,
         end of gty_flights.


DATA gwa_flight TYPE gty_flights.

SELECT single *
     from zspfli_msaa217
     into CORRESPONDING FIELDS OF gwa_flight
     where carrid eq 'AA'.

     write: / gwa_flight-airpfrom,
            / gwa_flight-airpto,
            / gwa_flight-carrid,
            / gwa_flight-cityfrom,
            / gwa_flight-cityto.
