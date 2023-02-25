*&---------------------------------------------------------------------*
*& Report z_prog_externo_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_prog_externo_msaa217.

DATA: gt_empleados TYPE STANDARD TABLE OF zemp_msaa217,
      gv_flag      TYPE c.


*PERFORM obtener_datos in PROGRAM z_pantallas_msaa217.
PERFORM obtener_datos(z_pantallas_msaa217) TABLES gt_empleados.

PERFORM visualizar_empleados
    IN PROGRAM z_pantallas_msaa217
    TABLES gt_empleados
    CHANGING gv_flag.
