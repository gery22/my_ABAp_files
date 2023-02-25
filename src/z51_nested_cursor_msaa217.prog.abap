*&---------------------------------------------------------------------*
*& Report z51_nested_cursor_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z51_nested_cursor_msaa217.


DATA: gwa_scarr   TYPE zscarr_msaa217,
      gwa_sflight TYPE zsflight_msaa217,
      gwa_sflight_temp TYPE zsflight_msaa217,
      gv_cursor_1 TYPE cursor,
      gv_cursor_2 TYPE cursor.

data(gr_outp) = cl_demo_output=>new( ).

OPEN CURSOR:  gv_cursor_1 FOR SELECT * FROM zscarr_msaa217
                                ORDER BY PRIMARY KEY,
              gv_cursor_2 FOR SELECT * FROM zsflight_msaa217
                                ORDER BY PRIMARY KEY.



DO.
FETCH NEXT CURSOR gv_cursor_1 INTO gwa_scarr.
if sy-subrc ne 0.
exit.
endif.

gr_outp->begin_section( gwa_scarr-carrid ).

  DO.

  if not gwa_sflight_temp is  INITIAL.
  gwa_sflight = gwa_sflight_temp.
  else.
FETCH NEXT CURSOR gv_cursor_2 INTO gwa_sflight.
if sy-subrc ne 0.
exit.
ELSEIF gwa_scarr-carrid ne gwa_sflight-carrid.

gwa_sflight_temp = gwa_sflight.


endif.
  ENDIF.



gr_outp->write( | { gwa_sflight-carrid } { gwa_sflight-connid } { gwa_sflight-fldate } | ).
  ENDDO.
gr_outp->end_section(  ).

ENDDO.
close cursor: gv_cursor_1, gv_cursor_2.

gr_outp->display(  ).
