*&---------------------------------------------------------------------*
*& Report z_sentencias_msaa217  Sentencias ABAP
*&---------------------------------------------------------------------*
*& 1. Suma / Sentencia ADD
*&---------------------------------------------------------------------*
REPORT z_sentencias_msaa217.

" delcaraciion de tods las variables de ejercicio
data:  TARIFA_BAS type i VALUE 20 ,
       TARIFA_AREA_CORP type i VALUE 10,
       TARIFA_SER_MEDICO type i VALUE 15,
       TARIFA_TOTAL type i,
       TARIFA_MANTENIMIENTO type i VALUE 30,
       TARIFA_MARGEN type i VALUE 10,
       TARIFA_BASE type i,
       TARIFA_SOC_FI type i VALUE 2,
       TARIFA_SOC_CO type i VALUE 3,
       TARIFA_MULTI type i,
       TARIFA_EJERCICIO type i VALUE 38,
       TARIFA_PERIODO type i VALUE 4,
       tarifa_aplicada type p LENGTH 8 DECIMALS 2,
       NUM_A type i VALUE 17,
       NUM_B type i VALUE 4,
       resultado type p LENGTH 4 DECIMALS 2,
       NUM_C type i VALUE 19,
       NUM_D type i VALUE 4,
       resto type p LENGTH 4 DECIMALS 2,
       numero type i VALUE 5,
       EXPO type i,
       raiz type p LENGTH 8 decimals 4.


tarifa_total = tarifa_bas + tarifa_area_corp + tarifa_ser_medico.

add 5 to tarifa_total.

write tarifa_total.



*&---------------------------------------------------------------------*
*& 2. Resta / Sentencia SUBTRACT
*&---------------------------------------------------------------------*


tarifa_base = tarifa_mantenimiento - tarifa_margen.

SUBTRACT 4 from tarifa_base.

WRITE / tarifa_base.



*&---------------------------------------------------------------------*
*& 3. Multiplicación / Sentencia MULTIPLY
*&---------------------------------------------------------------------*

tarifa_multi = tarifa_soc_fi * tarifa_soc_co.
 MULTIPLY tarifa_multi by 2.

WRITE / tarifa_multi.



*&---------------------------------------------------------------------*
*& División / Sentencia DIVIDE
*&---------------------------------------------------------------------*

tarifa_aplicada = tarifa_ejercicio / tarifa_periodo.

DIVIDE tarifa_aplicada by 3.

write / tarifa_aplicada.


*&---------------------------------------------------------------------*
*& División sin resto / Sentencia DIV
*&---------------------------------------------------------------------*

resultado = num_a div num_b.
write / resultado.


*&---------------------------------------------------------------------*
*& 6. Resto de división / Sentencia MOD
*&---------------------------------------------------------------------*

resto = num_c mod num_d.
write / resto.

*&---------------------------------------------------------------------*
*& 7. Exponenciación
*&---------------------------------------------------------------------*

expo = numero ** 2.
write / expo.

*&---------------------------------------------------------------------*
*& 8. Raíz cuadrada
*&---------------------------------------------------------------------*

raiz  = sqrt( expo ).
WRITE / raiz.
