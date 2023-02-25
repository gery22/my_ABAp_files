*&---------------------------------------------------------------------*
*& Report z31_null_op_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z31_null_op_msaa217.

data gt_table type table of zspfli_msaa217.

select * from zspfli_msaa217
into table gt_table
WHERE fltype is  not null
and fltype  ne space.

if sy-subrc eq 0.

cl_demo_output=>display( gt_table ).
endif.
