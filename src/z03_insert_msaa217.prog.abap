*&---------------------------------------------------------------------*
*& Report z03_insert_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z03_insert_msaa217.
DATA: gt_BBDD TYPE STANDARD TABLE OF zscarr_msaa217,
      gt_airlines type table of scarr,
      gcx_root TYPE REF TO cx_root.



    select * from scarr
    into TABLE @gt_airlines
    where currcode NE 'USD'.

    if sy-subrc eq 0.

    MOVE-CORRESPONDING gt_airlines to gt_bbdd.

    try.

    insert zscarr_msaa217 from table gt_bbdd.

    catch cx_sy_open_sql_db into gcx_root.

    WRITE gcx_root->get_text( ).
    ENDTRY.

    if sy-subrc eq 0.

    write: 'All good', sy-dbcnt , 'inserted'.

   endif.


    else.

    write: / 'Not read'.

    endif.
