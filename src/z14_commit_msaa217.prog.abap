*&---------------------------------------------------------------------*
*& Report z14_commit_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z14_commit_msaa217.

class lcl_rollback DEFINITION.

PUBLIC SECTION.

class-METHODS on_transaction_finished for EVENT transaction_finished
of cl_system_transaction_state importing kind.


ENDCLASS.

CLASS lcl_rollback IMPLEMENTATION.

  METHOD on_transaction_finished.
if kind eq cl_system_transaction_state=>rollback_work.
WRITE: / 'WORK ROLLED BACK', sy-uzeit, kind.

ELSEIF kind eq cl_system_transaction_state=>commit_work.

WRITE: / 'WORK COMMITED', sy-uzeit, kind.
endif.

  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.

DATA gwa_airline TYPE zscarr_msaa217.
set HANDLER lcl_rollback=>on_transaction_finished.

SELECT SINGLE * FROM zscarr_msaa217
INTO gwa_airline
WHERE carrid EQ 'BA'.

gwa_airline-currcode = 'BTC'.
UPDATE zscarr_msaa217 FROM gwa_airline.

IF Sy-uzeit+2(2) MOD 2 EQ 0.

  COMMIT work.
  else.
  rollback work.

ENDIF.



*WRITE /'debugging...'.
