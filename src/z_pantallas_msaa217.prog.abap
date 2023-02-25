*&---------------------------------------------------------------------*
*& Report z_pantallas_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_pantallas_msaa217.

INCLUDE: z_pantallas_msaa217_top, "Modulo Variables globales
         z_pantallas_msaa217_sel, " Modulo Pantallas de seleccion
         z_pantallas_msaa217_f01. " Modulo Subrutinas,


INITIALIZATION.

  PERFORM inicializar_variables.

*  gs_empleado = VALUE #( ape1   = p_ape1
*                         ape2   = p_ape2
*                         nombre = p_nombre
*                         fechan = p_fechan
*                         id     = p_dni
*                         email  = p_email
*                         fechaa = p_fechaa
*                                            ).



AT SELECTION-SCREEN ON p_nombre.

  IF p_nombre IS INITIAL.
    MESSAGE e001(z_clm_msaa217).
  ENDIF.


  IF p_nombre CA '0123456789'.
    MESSAGE e000(z_clm_msaa217).
  ENDIF.

AT SELECTION-SCREEN ON p_ape1.


  IF p_ape1 CA '0123456789'.
    MESSAGE e000(z_clm_msaa217).
  ENDIF.

AT SELECTION-SCREEN ON p_ape2.

  IF p_ape2 CA '0123456789'.
    MESSAGE e000(z_clm_msaa217).
  ENDIF.

*&---------------------------------------------------------------------*
*& 7. Campos obligatorios, ver declaracion de variables
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& 8-9.Hecho en SAP GUI
*&---------------------------------------------------------------------*



START-OF-SELECTION.

  PERFORM obtener_datos tables gt_empleados.


  CASE abap_true.

    WHEN p_create.
      PERFORM crear_empleado USING gs_empleado.


*&---------------------------------------------------------------------*
*& 3. Leer datos
*&---------------------------------------------------------------------*


    WHEN p_read.

      PERFORM visualizar_empleados TABLES gt_empleados
                                   CHANGING gv_flag.




*&---------------------------------------------------------------------*
*& 4. Actualizar datos
*&---------------------------------------------------------------------*

    WHEN p_upd.



      IF sy-subrc EQ 0.


        UPDATE zemp_msaa217 SET nombre = p_nombre
        WHERE id EQ p_dni.

        IF sy-subrc EQ 0.

          MESSAGE i005(z_clm_msaa217).

        ELSE.

          MESSAGE i006(z_clm_msaa217).

        ENDIF.

      ELSE.

        MESSAGE i004(z_clm_msaa217).

      ENDIF.

*&---------------------------------------------------------------------*
*& 5. Eliminar datos
*&---------------------------------------------------------------------*

    WHEN p_del.



      IF sy-subrc EQ 0.

        DELETE FROM zemp_msaa217
        WHERE id EQ p_dni.

        IF sy-subrc EQ 0.


          MESSAGE i007(z_clm_msaa217).

        ELSE.

          MESSAGE i008(z_clm_msaa217).

        ENDIF.

      ELSE.

        MESSAGE i004(z_clm_msaa217).

      ENDIF.

*&---------------------------------------------------------------------*
*& 6. Modificar datos
*&---------------------------------------------------------------------*

    WHEN p_mod.

      gs_empleado = VALUE #( ape1   = p_ape1
                             ape2   = p_ape2
                             nombre = p_nombre
                             fechan = p_fechan
                             id     = p_dni
                             email  = p_email ).

      MODIFY  zemp_msaa217 FROM gs_empleado.

      IF sy-subrc EQ 0.

        MESSAGE i009(z_clm_msaa217).

      ELSE.

        MESSAGE i010(z_clm_msaa217).

      ENDIF.

  ENDCASE.








  WRITE /'Thanks for using my program.'. " es para crear un break point porque en pantallas de seleccion no se puede poner breakpoints
