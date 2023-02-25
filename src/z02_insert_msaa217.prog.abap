*&---------------------------------------------------------------------*
*& Report z02_insert_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z02_insert_msaa217.

DATA: gt_scarr TYPE STANDARD TABLE OF zscarr_msaa217,
      gwa_airline type zscarr_msaa217.




    select * from scarr
    where currcode = 'EUR'
    into TABLE @gt_scarr.

    if sy-subrc eq 0.

    insert zscarr_msaa217 from table gt_scarr.

    if sy-subrc eq 0.

    write: 'All good', sy-dbcnt , 'inserted'.

   endif.


    else.

    write: / 'Not read'.

    endif.
