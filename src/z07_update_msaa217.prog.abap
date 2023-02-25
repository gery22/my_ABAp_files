*&---------------------------------------------------------------------*
*& Report z05_update_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z07_update_msaa217.


UPDATE zscarr_msaa217
set:  currcode = 'USD' where carrid eq 'LH',
      currcode = 'USD' where carrid eq 'NG'.


if sy-subrc eq 0.
write 'record updated'.
ENDIF.
