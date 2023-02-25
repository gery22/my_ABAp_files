*&---------------------------------------------------------------------*
*& Report z_mensajes_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_mensajes_msaa217.



*&---------------------------------------------------------------------*
*& 1. Mensajes de diálogo
*&---------------------------------------------------------------------*

PARAMETERS pa_msg type c.

case pa_msg.

when 'I'.

MESSAGE i014(sabapdocu).

when 'S'.

MESSAGE s015(sabapdocu).

when 'A'.

MESSAGE a016(sabapdocu).

WHEN OTHERS.

WRITE / 'Unknown Message Type'.

ENDCASE.
