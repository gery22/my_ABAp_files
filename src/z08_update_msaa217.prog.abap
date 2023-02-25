*&---------------------------------------------------------------------*
*& Report z08_update_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z08_update_msaa217.

*data: gt_sflight TYPE STANDARD TABLE OF sflight,
*      gt_zsflight type STANDARD TABLE OF zsflight_msaa217.
*
*      select * from sflight
*      into table gt_sflight.
*
*      MOVE-CORRESPONDING gt_sflight to gt_zsflight.
*
*      insert zsflight_msaa217 from table gt_zsflight.
*
*      write: / sy-dbcnt,  'registros actualizados'.

update zsflight_msaa217
set SEATSMAX_F = SEATSMAX_F + 15          "Maximum capacity in first class
    SEATSOCC_F = SEATSOCC_F + 18.           "- Occupied seats in first class”

write: / sy-dbcnt,  'registros actualizados'.
