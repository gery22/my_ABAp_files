*&---------------------------------------------------------------------*
*& Report z46_subquery_any_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z46_subquery_any_msaa217.

data gt_table type table of zscarr_msaa217.


select * from zscarr_msaa217
into table gt_table
where carrid eq some ( select carrid from zspfli_msaa217 where cityfrom eq 'FRANKFURT' ).

IF sy-subrc EQ 0.

  cl_demo_output=>display( gt_table ).

ENDIF.
