*&---------------------------------------------------------------------*
*& Report z43_outer_join_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z43_outer_join_msaa217.


TYPES: BEGIN OF gty_flight,
         planetype TYPE zsaplane_msaa217-planetype,
         carrid    TYPE zsflight_msaa217-carrid,
         connid    TYPE zsflight_msaa217-connid,
       END OF gty_flight.

DATA gt_table TYPE STANDARD TABLE OF gty_flight.

SELECT a~planetype b~carrid b~connid
FROM ( zsaplane_msaa217 AS a LEFT OUTER JOIN zsflight_msaa217 AS b ON a~planetype EQ b~planetype )
INTO  TABLE gt_table
ORDER BY carrid connid.



IF sy-subrc EQ 0.

  cl_demo_output=>display( gt_table ).

ENDIF.
