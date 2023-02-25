*&---------------------------------------------------------------------*
*& Report z05_update_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z06_update_msaa217.

data gt_airline type TABLE OF zscarr_msaa217.

FIELD-SYMBOLS <gfs_airline> TYPE zscarr_msaa217.

constants home type string value '/home'.

select  * from zscarr_msaa217
into table @gt_airline.


loop at gt_airline ASSIGNING <gfs_airline>.

<gfs_airline>-url = <gfs_airline>-url && home.

WRITE <gfs_airline>-url.

ENDLOOP.


UPDATE zscarr_msaa217 from table gt_airline.

if sy-subrc eq 0.
write 'record updated'.
ENDIF.
