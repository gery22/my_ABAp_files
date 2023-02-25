*&---------------------------------------------------------------------*
*& Report z11_delete_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z11_delete_msaa217.
DATA gwa_airline TYPE zscarr_msaa217.

SELECT SINGLE * FROM zscarr_msaa217
INTO gwa_airline
WHERE carrid EQ 'SR'.

IF sy-subrc EQ 0.

  delete zscarr_msaa217 FROM gwa_airline.



  IF sy-subrc EQ 0.
    WRITE 'record deleted'.
  ENDIF.

ENDIF.
