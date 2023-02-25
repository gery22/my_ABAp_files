*&---------------------------------------------------------------------*
*& Report z50_paralel_cursor_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z50_paralel_cursor_msaa217.
DATA: gwa_planes_1 TYPE zsaplane_msaa217,
      gwa_planes_2 TYPE zsaplane_msaa217,

      gv_cursor_1  TYPE cursor,
      gv_cursor_2  TYPE cursor,

      gv_flag_1    TYPE abap_bool,
      gv_flag_2    TYPE abap_bool.

OPEN CURSOR: gv_cursor_1 FOR SELECT planetype producer
                             FROM zsaplane_msaa217
                             WHERE producer EQ 'BA',

             gv_cursor_2 FOR SELECT planetype producer
                             FROM zsaplane_msaa217
                             WHERE producer EQ 'BOE'.

DO.

  IF gv_flag_1 EQ abap_false.

    FETCH NEXT CURSOR gv_cursor_1 INTO CORRESPONDING FIELDS OF gwa_planes_1.

    IF sy-subrc EQ 0.
      FORMAT COLOR = 6.
      WRITE : / gwa_planes_1-planetype, gwa_planes_1-producer.

    ELSE.
      CLOSE CURSOR gv_cursor_1.
      gv_flag_1 = abap_true.
    ENDIF.
endif.

    IF gv_flag_2 EQ abap_false.

      FETCH NEXT CURSOR gv_cursor_2 INTO CORRESPONDING FIELDS OF gwa_planes_2.

      IF sy-subrc EQ 0.
        FORMAT COLOR = 5.
        WRITE : / gwa_planes_2-planetype, gwa_planes_2-producer.

      ELSE.
        CLOSE CURSOR gv_cursor_2.
        gv_flag_2 = abap_true.
      ENDIF.
   ENDIF.

    IF gv_flag_1 EQ abap_true AND gv_flag_2 EQ abap_true.

      EXIT.

    ENDIF.


  ENDDO.
