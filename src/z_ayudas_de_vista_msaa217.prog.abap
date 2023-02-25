*&---------------------------------------------------------------------*
*& Report z_ayudas_de_vista_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ayudas_de_vista_msaa217.

* parameters carrid type s_carr_id matchcode object zab_msaa217.

TABLES sflight.


SELECT-OPTIONS carrid FOR sflight-carrid MATCHCODE OBJECT zab_msaa217.
