*&---------------------------------------------------------------------*
*& Report z12_delete_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z12_delete_msaa217.

data: gt_airline type table of zscarr_msaa217.

      select * from zscarr_msaa217
      into table gt_airline
      where carrid in ( 'QF', 'SA' ).

if sy-subrc eq 0.

delete zscarr_msaa217 from table gt_airline.
if sy-subrc eq 0.
WRITE / 'Record deleted'.

endif.
endif.
