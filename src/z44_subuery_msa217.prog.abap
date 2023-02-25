*&---------------------------------------------------------------------*
*& Report z44_subuery_msa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z44_subuery_msa217.


data gt_table type table of zsflight_msaa217.

select * from zsflight_msaa217
into table gt_table
where planetype eq ( select planetype from zsaplane_msaa217 where planetype eq '747-400'  ).
" lo encuentro muy poco util a esta subquery porque el planetype se encuentra en la primer tabla tambien
IF sy-subrc EQ 0.

  cl_demo_output=>display( gt_table ).

ENDIF.
