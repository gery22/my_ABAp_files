*&---------------------------------------------------------------------*
*& 2.2.1. Declaración / 2. Declaración en línea
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_field_symbol_msaa217.

DATA gv_employee TYPE string.
FIELD-SYMBOLS <gv_employee> TYPE string.
ASSIGN gv_employee TO <gv_employee>.
<gv_employee> = 'Gery'.

*FIELD-SYMBOLS <gs_employee> type zemp_logali.
*Los field symbols tambien se pueden declarar inline
SELECT FROM zemp_logali
FIELDS *
INTO TABLE @DATA(gt_employee).


LOOP AT gt_employee  ASSIGNING FIELD-SYMBOL(<gs_employee>).

  <gs_employee>-email = |{ <gs_employee>-ape1 }@gmail.com|.

ENDLOOP.

*&---------------------------------------------------------------------*
*& 2.2.3. Añadir un registro
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

APPEND INITIAL LINE TO gt_employee ASSIGNING FIELD-SYMBOL(<gs_employee2>).


IF <gs_employee2> IS ASSIGNED.
  <gs_employee2> = VALUE #( ape1 = 'append'
                           ape2 = 'pointer'

  ).

ENDIF.


*&---------------------------------------------------------------------*
*& 2.2.4. INSERTAR un registro
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

INSERT INITIAL LINE INTO gt_employee ASSIGNING FIELD-SYMBOL(<gs_employee3>) INDEX 2.


IF <gs_employee3> IS ASSIGNED.
  <gs_employee3> = VALUE #( ape1 = 'insert'
                           ape2 = 'pointer'

  ).

ENDIF.



UNASSIGN: <gs_employee2>,
          <gs_employee>,
          <gs_employee3>,
          <gv_employee>.


WRITE / 'END'.
