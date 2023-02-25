*&---------------------------------------------------------------------*
*& Report z35_distinct_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z35_distinct_msaa217.

data: gv_promedio type s_seatsocc,
      gv_sum type s_seatsocc.

select avg( DISTINCT seatsocc ) sum( DISTINCT seatsocc ) from ZSFLIGHT_MSAA217
into ( gv_promedio, gv_sum ).

if sy-subrc eq 0.

write: / gv_promedio, / gv_sum.

endif.
