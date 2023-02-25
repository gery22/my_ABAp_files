*&---------------------------------------------------------------------*
*& Report z16_sel_sing_upd_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z16_sel_sing_upd_msaa217.

DATA gwa_flight TYPE zspfli_msaa217.

SELECT SINGLE FOR UPDATE *
     FROM zspfli_msaa217
     INTO  gwa_flight
     WHERE carrid EQ 'SQ'
           AND connid EQ '15'. "NOTA para LOGALI: connid = 2 no existe, por eso puse 15



gwa_flight-fltype ='X'.

write gwa_flight-period.
