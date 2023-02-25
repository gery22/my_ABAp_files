*&---------------------------------------------------------------------*
*& Include z_pantallas_msaa217_sel
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK block6 WITH FRAME.
  SELECTION-SCREEN SKIP.


  SELECTION-SCREEN BEGIN OF LINE.
    PARAMETERS  p_create RADIOBUTTON GROUP crud.
    SELECTION-SCREEN COMMENT (22) TEXT-c08.

    PARAMETERS  p_read RADIOBUTTON GROUP crud.
    SELECTION-SCREEN COMMENT (22) TEXT-c04. "He puesto los comments directamente aqui para probar si funcionaba tb de este modo

    PARAMETERS  p_upd RADIOBUTTON GROUP crud.
    SELECTION-SCREEN COMMENT (22) TEXT-c05.

    PARAMETERS  p_del RADIOBUTTON GROUP crud.
    SELECTION-SCREEN COMMENT (22) TEXT-c06.

    PARAMETERS  p_mod RADIOBUTTON GROUP crud.
    SELECTION-SCREEN COMMENT (22) TEXT-c07.


*- Pa_READ – Read
*- Pa_UPDATE – Update
*- Pa_DELETE – Delete
*- Pa_MODIFY – Modify
  SELECTION-SCREEN END OF LINE.
  SELECTION-SCREEN SKIP.

SELECTION-SCREEN END OF BLOCK block6.

SELECTION-SCREEN BEGIN OF BLOCK block1 WITH FRAME TITLE TEXT-b01.

  SELECTION-SCREEN SKIP.

*&---------------------------------------------------------------------*
*& 1. Parámetros
*&---------------------------------------------------------------------*

  SELECTION-SCREEN BEGIN OF BLOCK block2 WITH FRAME TITLE TEXT-b02.

    PARAMETERS : p_ape1   TYPE c LENGTH 20  , " siempre comentar los parametros.
                 p_ape2   TYPE c LENGTH 20,
                 p_nombre TYPE c LENGTH 30,
                 p_fechan TYPE datum,
                 p_dni    TYPE c LENGTH 15 ,
                 p_domici TYPE c LENGTH 50,
                 p_email  TYPE c LENGTH 30.

  SELECTION-SCREEN END OF BLOCK block2.

  SELECTION-SCREEN BEGIN OF BLOCK block3 WITH FRAME TITLE TEXT-b03.


*&---------------------------------------------------------------------*
*& 2. Casillas de verificación y Radio Buttons
*&---------------------------------------------------------------------*
    SELECTION-SCREEN BEGIN OF BLOCK block4 WITH FRAME TITLE TEXT-b04.

      SELECTION-SCREEN SKIP.

      PARAMETERS: p_cntr_i RADIOBUTTON GROUP cntr,
                  p_cntr_t RADIOBUTTON GROUP cntr,
                  p_cntr_p RADIOBUTTON GROUP cntr.

    SELECTION-SCREEN END OF BLOCK block4.
*&---------------------------------------------------------------------*
*& Beneficios del Empleado
*&---------------------------------------------------------------------*

    SELECTION-SCREEN BEGIN OF BLOCK block5 WITH FRAME TITLE TEXT-b05.

      SELECTION-SCREEN SKIP.

      SELECTION-SCREEN BEGIN OF LINE. "PARA AGRUPAR ELEMNTOS EN UNA MISMA LINEAS


        PARAMETERS p_tik_r TYPE c AS CHECKBOX DEFAULT 'X'.
        SELECTION-SCREEN COMMENT (22) c_tik_r.

        PARAMETERS p_seg_m TYPE c AS CHECKBOX.
        SELECTION-SCREEN COMMENT (22) c_seg_m.

        PARAMETERS p_frm_p TYPE c AS CHECKBOX.
        SELECTION-SCREEN COMMENT (22) c_frm_p.



      SELECTION-SCREEN END OF LINE.

    SELECTION-SCREEN END OF BLOCK block5.
*&---------------------------------------------------------------------*
*& 3. Rangos SELECT-OPTION ----  Actividad laboral
*&---------------------------------------------------------------------*

    SELECTION-SCREEN SKIP.

    PARAMETERS: p_horas  TYPE i,
                p_sal_m  TYPE i,
                p_fechaa TYPE sy-datum.

    SELECTION-SCREEN SKIP.

    SELECT-OPTIONS: s_prog FOR trdir-name, " genera una tabla interna llamada sprog con 4 columnas conteniendo los datos selecionados
            s_tcode FOR tstc-tcode.

    SELECTION-SCREEN SKIP.

  SELECTION-SCREEN END OF BLOCK block3.

SELECTION-SCREEN END OF BLOCK block1.
