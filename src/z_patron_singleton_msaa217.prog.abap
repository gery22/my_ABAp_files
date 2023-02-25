*&---------------------------------------------------------------------*
*& Report z_patron_singleton_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_patron_singleton_msaa217.

DATA: gr_singleton  TYPE REF TO zcl_singleton_logali,
      gr_singleton1 TYPE REF TO zcl_singleton_logali.
zcl_singleton_logali=>get_instance(
  IMPORTING
    instance = gr_singleton
).


WAIT UP TO 3 SECONDS.

zcl_singleton_logali=>get_instance(
  IMPORTING
    instance = gr_singleton1
).

WRITE: gr_singleton->creation_date,
       gr_singleton1->creation_date.
