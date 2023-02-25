*&---------------------------------------------------------------------*
*& Report z33_min_max_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z33_min_max_msaa217.

data: gv_payment_max type s_sum,
      gv_payment_min type s_sum.

select min( paymentsum )  max( paymentsum ) from ZSFLIGHT_MSAA217
into ( gv_payment_min, gv_payment_max ) .


if sy-subrc eq 0.

write: / gv_payment_min, / gv_payment_max.

endif.
