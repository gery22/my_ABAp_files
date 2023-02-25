*&---------------------------------------------------------------------*
*& Report z10_modify_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z10_modify_msaa217.

data:  gwa_airline type zscarr_msaa217,
       gt_airline type TABLE OF zscarr_msaa217.

FIELD-SYMBOLS <gfs_airline> TYPE zscarr_msaa217.

constants gc_https type string value 'https'.

select  * from zscarr_msaa217
into table @gt_airline.


loop at gt_airline ASSIGNING <gfs_airline>.

*replace 'http' with 'https' into <gfs_airline>-url.


ENDLOOP.

gwa_airline-carrid = 'IB'.
gwa_airline-carrname = 'Iberia Airlines'.
gwa_airline-currcode = 'EUR'.
gwa_airline-url = 'https://www.iberia.com'.

APPEND gwa_airline to gt_airline.
modify zscarr_msaa217 from table gt_airline.

if sy-subrc eq 0.
write: / sy-dbcnt, 'records updated'.
ENDIF.
