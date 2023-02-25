*&---------------------------------------------------------------------*
*& Report z09_modify_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z09_modify_msaa217.

data gwa_airline type zscarr_msaa217.




select single  *
from zscarr_msaa217 into gwa_airline
where carrid eq 'CO'.

gwa_airline-currcode = 'WZ'.

MODIFY zscarr_msaa217 from gwa_airline.
if sy-subrc eq 0.
write 'record updated'.
ENDIF.
