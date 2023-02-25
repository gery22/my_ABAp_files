*&---------------------------------------------------------------------*
*& Report z04_insert_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z04_insert_msaa217.

DATA: gt_BBDD TYPE STANDARD TABLE OF zscarr_msaa217,
      gt_airlines type table of scarr,
      gcx_root TYPE REF TO cx_root.



    select * from scarr
    into TABLE @gt_airlines.


    if sy-subrc eq 0.

    MOVE-CORRESPONDING gt_airlines to gt_bbdd.



    insert zscarr_msaa217 from table gt_bbdd ACCEPTING DUPLICATE KEYS.



   write: /'SYSUBRC', sy-subrc,
          / sy-dbcnt , 'inserted'..


    else.

    write: / 'Not read'.

    endif.
