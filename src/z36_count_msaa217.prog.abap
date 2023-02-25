*&---------------------------------------------------------------------*
*& Report z36_count_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z36_count_msaa217.

data gv_count type i.

select count( * ) from zspfli_msaa217
into gv_count
where carrid eq 'LH'.

if sy-subrc eq 0.

write: / gv_count.

endif.
