*&---------------------------------------------------------------------*
*& Report z48_subquery_in_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z48_subquery_in_msaa217.


data gt_table type table of zscarr_msaa217.

select * from zscarr_msaa217
into table gt_table
where carrid in ( select carrid from zspfli_msaa217 where carrid ne space ).


IF sy-subrc EQ 0.

  cl_demo_output=>display( gt_table ).

ENDIF.
