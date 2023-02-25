*&---------------------------------------------------------------------*
*& Report z45_subquery_all_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z45_subquery_all_msaa217.

TYPES: BEGIN OF gty_planes,
         producer TYPE zsaplane_msaa217-producer,
         count    TYPE i,
       END OF gty_planes.

DATA gt_table TYPE STANDARD TABLE OF gty_planes.


SELECT producer COUNT( * ) AS count
FROM zsaplane_msaa217
INTO TABLE gt_table
GROUP BY producer
HAVING COUNT( * ) >= ALL ( SELECT COUNT( * ) FROM zsaplane_msaa217 GROUP BY producer ).

IF sy-subrc EQ 0.

  cl_demo_output=>display( gt_table ).

ENDIF.
