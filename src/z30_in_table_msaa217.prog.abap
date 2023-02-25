*&---------------------------------------------------------------------*
*& Report z30_in_table_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z30_in_table_msaa217.

data: gt_table type table of zsflight_msaa217,
      gr_price type range of s_price,
      gwa_price like line of gr_price.

      gwa_price-sign = 'I'.
      gwa_price-low = '500'.
      gwa_price-high = '4500'.
      gwa_price-option = 'BT'.

      APPEND gwa_price to gr_price.  " a la tabla de rango se le puede seguir haciendo appends




select * from zsflight_msaa217
into table gt_table
WHERE price in gr_price
and currency eq 'AUD'.

if sy-subrc eq 0.

cl_demo_output=>display( gt_table ).
endif.
