*&---------------------------------------------------------------------*
*& Report z01_insert_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_insert_msaa217.

DATA gwa_airline type zscarr_msaa217.

gwa_airline-carrid = 'BA'.
gwa_airline-carrname = 'British Airways'.
gwa_airline-currcode = 'GBP'.
gwa_airline-url = 'http://www.british-airways.com'.

*insert into zscarr_msaa217 values gwa_airline.
insert zscarr_msaa217 from gwa_airline.

if sy-subrc eq 0.

write: 'Objeto insertado by User', sy-uname.

else.

write / 'Registro no insertado'.

endif.
