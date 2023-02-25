*&---------------------------------------------------------------------*
*& Include z_pantallas_msaa217_f01
*&---------------------------------------------------------------------*

FORM inicializar_variables.

*Comments values

  p_fechaa = sy-datum.

  c_tik_r = TEXT-c01.  " text-c01 because'literal' hard coding not good for translation issues
  c_seg_m = TEXT-c02.
  c_frm_p = TEXT-c03.

ENDFORM.


FORM obtener_datos TABLES pt_empleados STRUCTURE zemp_msaa217.
  IF p_read EQ abap_true OR
     p_upd EQ abap_true OR
     p_del EQ abap_true.

    SELECT SINGLE * FROM zemp_msaa217
          INTO gs_empleado

          WHERE id EQ p_dni.


  ENDIF.

  SELECT * FROM zemp_msaa217
  INTO TABLE pt_empleados
  WHERE id NE space.


ENDFORM.

FORM crear_empleado USING p_empleado TYPE zemp_msaa217.

  p_empleado = VALUE #( ape1   = p_ape1
                         ape2   = p_ape2
                         nombre = p_nombre
                         fechan = p_fechan
                         id     = p_dni
                         email  = p_email
                         fechaa = p_fechaa
                                            ).


  INSERT zemp_msaa217 FROM gs_empleado.

  IF sy-subrc = 0.
    MESSAGE i002(z_clm_msaa217).

  ELSE.
    MESSAGE i003(z_clm_msaa217).

  ENDIF.

ENDFORM.

FORM visualizar_empleados TABLES pt_empleados STRUCTURE zemp_msaa217
                          CHANGING pv_flag TYPE c.

  DATA ls_empleado TYPE zemp_msaa217.

  IF sy-subrc EQ 0.

    LOOP AT pt_empleados INTO ls_empleado.

      WRITE: / '------------------------------------------',
             / 'DNI ='              , ls_empleado-id,
             / 'Email ='            , ls_empleado-email,
             / 'Primer Apellido ='  , ls_empleado-ape1,
             / 'Segundo Apellido =' , ls_empleado-ape2,
             / 'Nombre ='           , ls_empleado-nombre,
             / 'Fecha de Nac ='     , ls_empleado-fechan,
             / 'Fecha de alta ='    , ls_empleado-fechaa.
    skip 1.
    ENDLOOP.

  ELSE.

    MESSAGE i004(z_clm_msaa217).

  ENDIF.

ENDFORM.
