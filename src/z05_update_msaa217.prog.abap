*&---------------------------------------------------------------------*
*& Report z05_update_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z05_update_msaa217.

data gwa_zscarr type zscarr_msaa217.

select single * from zscarr_msaa217
into gwa_zscarr
where carrid eq 'AC'.

gwa_zscarr-currcode = 'USD'.

UPDATE zscarr_msaa217 from gwa_zscarr.

if sy-subrc eq 0.
write 'record updated'.
ENDIF.
