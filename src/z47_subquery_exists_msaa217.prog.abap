*&---------------------------------------------------------------------*
*& Report z47_subquery_exists_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z47_subquery_exists_msaa217.

data gt_table type table of zsaplane_msaa217.


select * from zsaplane_msaa217 as a
into table gt_table
where EXISTS (  select * from zsflight where planetype eq a~planetype ).


IF sy-subrc EQ 0.

  cl_demo_output=>display( gt_table ).

ENDIF.
