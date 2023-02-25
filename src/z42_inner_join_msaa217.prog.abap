*&---------------------------------------------------------------------*
*& Report z42_inner_join_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z42_inner_join_msaa217.


TYPES: BEGIN OF gty_flight,
       carrname type zscarr_msaa217-carrname,
       fldate type zsflight-fldate,
       price type zsflight-price,
       planetype type zsflight-planetype,
       producer type zsaplane_msaa217-producer,
       END OF gty_flight.

data gt_table type TABLE OF gty_flight.



       select a~carrname b~fldate b~price b~planetype c~producer
       into CORRESPONDING FIELDS OF table gt_table
       from zscarr_msaa217 as a
       INNER JOIN zsflight_msaa217 as b on b~carrid eq a~carrid
       inner join zsaplane_msaa217 as c on c~planetype eq b~planetype.

        if sy-subrc eq 0.

 cl_demo_output=>display( gt_table ).

 endif.
