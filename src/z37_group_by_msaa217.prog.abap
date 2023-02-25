*&---------------------------------------------------------------------*
*& Report z37_group_by_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z37_group_by_msaa217.

data: gv_count type i,
      gv_carrid type s_carr_id.

select count( * ) carrid from ZSFLIGHT_MSAA217
into ( gv_count, gv_carrid )
group by carrid .

write: / gv_count, gv_carrid.

ENDSELECT.
if sy-subrc eq 0.

write: / gv_count.

endif.
