*&---------------------------------------------------------------------*
*& Report z28_escape_op_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z28_escape_op_msaa217.

data gt_table type table of ZTAX_CODE.

select * from ZTAX_CODE
into table gt_table
WHERE text1 like '%27@%%' ESCAPE '@'.  " _ para un solo caracter  % para many

if sy-subrc eq 0.

cl_demo_output=>display( gt_table ).
endif.
