*&---------------------------------------------------------------------*
*& Report z49_open_close_cursor_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z49_open_close_cursor_msaa217.


data: gwa_planes type zsaplane_msaa217 ,
      gv_cursor type cursor,
      gv_finished type abap_bool.



open cursor gv_cursor for SELECT * from zsaplane_msaa217
                          where producer eq 'BOE'
                          ORDER BY planetype.

while gv_finished eq abap_false.

fetch next CURSOR gv_cursor into gwa_planes.

if sy-subrc eq 0.

WRITE : / gwa_planes-planetype.

else.

CLOSE CURSOR gv_cursor.

gv_finished = abap_true.

endif.


ENDWHILE.
