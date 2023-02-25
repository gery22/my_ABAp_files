*&---------------------------------------------------------------------*
*& Report z_bifurcaciones_msaa217
*&---------------------------------------------------------------------*
*&  LAB1 E4. BIFURCACIONES CONDICIONALES
*&---------------------------------------------------------------------*
REPORT z_bifurcaciones_msaa217.



*&---------------------------------------------------------------------*
*&  1. IF/ELSE/ENDIF/CHECK
*&---------------------------------------------------------------------*

DATA(gv_numero) = 7.

IF gv_numero EQ 7.
  WRITE 'Número = 7'.
ELSE.
  WRITE 'Número distinto de 7'.
ENDIF.






*&---------------------------------------------------------------------*
*&  2. CASE/ENDCASE
*&---------------------------------------------------------------------*

"CASE - NO ACEPTA >< OR AND. SOLO EQ

DATA(lv_empresa) = 'LOGALI'.

CASE lv_empresa.
  WHEN 'LOGALI'.
    WRITE / 'Academia'.

  WHEN 'SAP'.
    WRITE / 'Software Empresarial'.

  WHEN OTHERS.
    WRITE / 'Desconocido'.


ENDCASE.

*&---------------------------------------------------------------------*
*&  3. DO/ENDDO
*&---------------------------------------------------------------------*


DATA: lv_contador  TYPE i,
      lv_contador2 TYPE i.

DO 10 TIMES.

  lv_contador += 1.

  WRITE / lv_contador.

  IF lv_contador EQ 7.
    EXIT.
  ENDIF.

ENDDO.

*&---------------------------------------------------------------------*
*&  4. WHILE/ENDWHILE
*&---------------------------------------------------------------------*


WHILE lv_contador2 LE 20.

  lv_contador2 += 1.

  CHECK lv_contador2 LE 10.
  WRITE / lv_contador2.




ENDWHILE.

*&---------------------------------------------------------------------*
*&  5. COND
*&---------------------------------------------------------------------*



data(lv_time) = cond #(
    when sy-timlo LT '120000' then |{ sy-timlo TIME = ISO } AM|
    when sy-timlo GT '120000' then |{ CONV T( sy-timlo - 12 * 3600 ) TIME = ISO } PM|
    when sy-timlo EQ '120000' then |{ sy-timlo TIME = ISO } HIGH NOON|
    eLSE |Hora no identificada|
     ).
WRITE / LV_TIME.
*&---------------------------------------------------------------------*
*&  6. SWITCH
* WARNING: EN EL ENUNCIADO CREO QUE HAY UN ERRO: Para cualquier otro valor distinto a los dos primeros, muestra
*por pantalla “Desconocido”. pONIENDO MOVISTAR NO ESTARIA ObTENIENDO EL VALOR"DESCONOCIDO"?
*&---------------------------------------------------------------------*


DATA(gv_empresa) = 'Freddy Mercury'.
data(GV_text) = SWITCH #( gv_empresa
                when 'LOGALI' THEN |Academia|
                when 'SAP' THEN |Software Empresarial|
                when 'MOVISTAR' THEN ||
                ELSE |Desconocido|
                ).
write / gv_text.
