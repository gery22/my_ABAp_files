*&---------------------------------------------------------------------*
*& Report z_27_like_op_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z27_like_op_msaa217.

data gt_dokt type table of doktl.

select * from doktl
into table gt_dokt
up TO 5 rows
WHERE doktext like '_CONTEXT_'.  " _ para un solo caracter  % para many

if sy-subrc eq 0.

cl_demo_output=>display( gt_dokt ).
endif.
