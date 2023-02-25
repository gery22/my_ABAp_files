*&---------------------------------------------------------------------*
*& Report z34_avg_sum_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z34_avg_sum_msaa217.


data: gv_promedio type s_price,
      gv_sum type s_price.

select avg( price ) sum( price ) from ZSFLIGHT_MSAA217
into ( gv_promedio, gv_sum )
where currency eq 'AUD'.


if sy-subrc eq 0.

write: / gv_promedio, / gv_sum.

endif.
