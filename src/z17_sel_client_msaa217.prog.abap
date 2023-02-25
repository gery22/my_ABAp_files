*&---------------------------------------------------------------------*
*& Report z17_sel_client_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z17_sel_client_msaa217.


DATA gwa_flight TYPE spfli.

SELECT SINGLE  * FROM spfli
 CLIENT SPECIFIED
     INTO  gwa_flight
     WHERE      mandt EQ '000'
         AND  carrid EQ 'LH'
         AND  connid EQ '402'.


WRITE: / gwa_flight-mandt,
       / gwa_flight-cityfrom,
       / gwa_flight-cityto.



SELECT SINGLE  * FROM spfli

     INTO  gwa_flight

         where  carrid EQ 'LH'
         AND  connid EQ '402'.


WRITE: / gwa_flight-mandt.
