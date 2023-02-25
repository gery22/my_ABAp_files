*&---------------------------------------------------------------------*
*& Report z18_sel_bypassing_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z18_sel_bypassing_msaa217.




DATA gwa_pais TYPE t005.

SELECT SINGLE *
     FROM t005 BYPASSING BUFFER
     INTO  gwa_pais
     WHERE land1 EQ 'ES'.


  write gwa_pais-intca3.
