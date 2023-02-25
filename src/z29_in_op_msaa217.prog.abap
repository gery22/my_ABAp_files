*&---------------------------------------------------------------------*
*& Report z29_in_op_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z29_in_op_msaa217.

data gt_table type table of zscarr_msaa217.

select * from zscarr_msaa217
into table gt_table
WHERE carrid in ( 'AA', 'AB', 'WZ' ).

if sy-subrc eq 0.

cl_demo_output=>display( gt_table ).
endif.
