*&---------------------------------------------------------------------*
*& Include z_alv_mf_msaa217_f01
*&---------------------------------------------------------------------*

FORM get_data .

  IF p_hier EQ abap_false.

    SELECT    carrid
              connid
              price
              currency
              seatsmax
              seatsocc
    FROM sflight
    INTO TABLE gt_flights
    WHERE carrid IN so_carr.

  ELSE.

    SELECT * FROM spfli
             INTO TABLE gt_header
             WHERE carrid IN so_carr.

    SELECT * FROM sflight INTO TABLE gt_items
             WHERE carrid IN so_carr.
  ENDIF.

ENDFORM.

**********************************************************************

FORM build_field_cat.

  DATA ls_fieldcat TYPE slis_fieldcat_alv.   "construimos una estructura del tipo fieldcact - ya viene con un monton de parametros los cuales podemos rellenar

  IF p_list EQ abap_true OR p_grid EQ abap_true. "bifurco porque en los modos grid y list use el fied cat manual
    ls_fieldcat-fieldname = 'CARRID'.
    ls_fieldcat-seltext_l = 'Airline Code'.     " Texto largo
    ls_fieldcat-key = abap_true.                 " especificamos campos clave
    APPEND ls_fieldcat TO gt_fieldcat.      " por cada campo de nuestra tabla interna creamos una linea de la tabla field_cat con los parametros que queremos modificar
    CLEAR ls_fieldcat.

    ls_fieldcat-fieldname = 'CONNID'.
    ls_fieldcat-key = abap_true.
    ls_fieldcat-seltext_l = 'Flight Number'.
    APPEND ls_fieldcat TO gt_fieldcat.
    CLEAR ls_fieldcat.

    ls_fieldcat-fieldname = 'PRICE'.
    ls_fieldcat-seltext_l = 'Airfare'.
    APPEND ls_fieldcat TO gt_fieldcat.
    CLEAR ls_fieldcat.

    ls_fieldcat-fieldname = 'CURRENCY'.
    ls_fieldcat-seltext_l = 'Local currency of airline'.
    APPEND ls_fieldcat TO gt_fieldcat.
    CLEAR ls_fieldcat.

    ls_fieldcat-fieldname = 'SEATSMAX'.
    ls_fieldcat-seltext_l = 'Maximum capacity in economy class'.
    APPEND ls_fieldcat TO gt_fieldcat.
    CLEAR ls_fieldcat.

    ls_fieldcat-fieldname = 'SEATSOCC'.
    ls_fieldcat-seltext_l = 'Occupied seats in economy class'.
    APPEND ls_fieldcat TO gt_fieldcat.

  ELSE.
    PERFORM build_field_cat_hier
      USING
        sy-repid
         'GT_HEADER'
         'SPFLI'
      CHANGING
        gt_fieldcat.

    PERFORM build_field_cat_hier
          USING
            sy-repid
             'GT_ITEMS'
             'SFLIGHT'
          CHANGING
            gt_fieldcat.
  ENDIF.
ENDFORM.

**********************************************************************

FORM display_alv_list.

  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
    EXPORTING
*     i_interface_check  = space
*     i_bypassing_buffer =
*     i_buffer_active    = space
      i_callback_program = sy-repid  " esta variable almacena  el nombre del programa actual, y nos redirige a nustro programa una vez visualizado el alv
*     i_callback_pf_status_set = space
*     i_callback_user_command  = space
*     i_structure_name   =
*     is_layout          =
      it_fieldcat        = gt_fieldcat
*     it_excluding       =
*     it_special_groups  =
*     it_sort            =
*     it_filter          =
*     is_sel_hide        =
*     i_default          = 'X'
*     i_save             = space
*     is_variant         =
      it_events          = gt_events
*     it_event_exit      =
*     is_print           =
*     is_reprep_id       =
*     i_screen_start_column    = 0
*     i_screen_start_line      = 0
*     i_screen_end_column      = 0
*     i_screen_end_line  = 0
*     ir_salv_list_adapter     =
*     it_except_qinfo    =
*     i_suppress_empty_data    = abap_false
*  IMPORTING
*     e_exit_caused_by_caller  =
*     es_exit_caused_by_user   =
    TABLES
      t_outtab           = gt_flights
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
    WRITE / 'Exception error'.
  ENDIF.
ENDFORM.

**********************************************************************

FORM display_alv_grid.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     i_interface_check        = space
*     i_bypassing_buffer       = space
*     i_buffer_active          = space
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'SET_PF_STATUS' " subrutina creada mas abajo
      i_callback_user_command  = 'USER_COMMAND'    " esta funcion esta en la documentacion (de ahi se cpian los parametros) y se encarga de devolver algo al doble click
      i_callback_top_of_page   = 'TOP_OF_PAGE'
*     i_callback_html_top_of_page = space
*     i_callback_html_end_of_list = space
*     i_structure_name         =
*     i_background_id          =
*     i_grid_title             =
*     i_grid_settings          =
      is_layout                = gs_layout
      it_fieldcat              = gt_fieldcat
*     it_excluding             =
*     it_special_groups        =
*     it_sort                  =
*     it_filter                =
*     is_sel_hide              =
*     i_default                = 'X'
*     i_save                   = space
*     is_variant               =
*     it_events                = gt_events
*     it_event_exit            =
*     is_print                 =
*     is_reprep_id             =
*     i_screen_start_column    = 0
*     i_screen_start_line      = 0
*     i_screen_end_column      = 0
*     i_screen_end_line        = 0
*     i_html_height_top        = 0
*     i_html_height_end        = 0
*     it_alv_graphics          =
*     it_hyperlink             =
*     it_add_fieldcat          =
*     it_except_qinfo          =
*     ir_salv_fullscreen_adapter  =
*     o_previous_sral_handler  =
*  IMPORTING
*     e_exit_caused_by_caller  =
*     es_exit_caused_by_user   =
    TABLES
      t_outtab                 = gt_flights
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc <> 0.
    WRITE: /'program error'.
  ENDIF.

**********************************************************************

ENDFORM.
FORM build_layout.
  gs_layout-zebra = abap_true.
  gs_layout-edit = abap_true.

ENDFORM.

FORM user_command  USING pv_ucomm LIKE sy-ucomm  "routina para doble click en campo
                   ps_selfield TYPE slis_selfield.

  IF pv_ucomm EQ '&GAA'.
    SELECT SINGLE carrname FROM scarr
     INTO @DATA(lv_carrname)
     WHERE carrid EQ @ps_selfield-value.

    MESSAGE i012(z_clm_msaa217) WITH lv_carrname.

  ELSEIF pv_ucomm EQ '&IC1'.
    SELECT SINGLE seatsmax FROM sflight
    INTO @DATA(lv_seatsmax)
    WHERE connid EQ @ps_selfield-value.

    SELECT SINGLE seatsocc FROM sflight
      INTO @DATA(lv_seatsocc)
      WHERE connid EQ @ps_selfield-value.

    DATA(lv_dif) = lv_seatsmax - lv_seatsocc.

    MESSAGE i011(z_clm_msaa217) WITH lv_dif.

  ENDIF.
ENDFORM.

**********************************************************************

FORM set_pf_status USING rt_extab TYPE slis_t_extab. " routina para barra de heramientas

  SET PF-STATUS 'AIRLINE_NAME'.

ENDFORM.

**********************************************************************

FORM add_events.

  DATA ls_events TYPE slis_alv_event.  "estuctura utilizada para defnir eventos

  ls_events-name = 'TOP_OF_PAGE'.
  ls_events-form = 'TOP_OF_PAGE'.   "subrutina con la cabecera del evento. puede llevar cualquier nombre
  APPEND ls_events TO gt_events.
ENDFORM.

**********************************************************************

FORM top_of_page.  "subrutina para eventos (list o grid)

  DATA: it_list_commentary TYPE slis_t_listheader,
        ls_list_commentary TYPE slis_listheader.

  CASE abap_true.

    WHEN p_list OR p_hier.
      WRITE: / 'TIME', sy-uzeit ENVIRONMENT TIME FORMAT,
             / 'USER', sy-uname.

    WHEN p_grid.
      ls_list_commentary-typ = 'H'.    "H  de header
      ls_list_commentary-info = 'Available Flights'.
      APPEND ls_list_commentary TO it_list_commentary.

      ls_list_commentary-typ = 'S'.    "S para escribir
      ls_list_commentary-info = | User:    { sy-uname } |.
      APPEND ls_list_commentary TO it_list_commentary.

      ls_list_commentary-typ = 'A'.    "A de italic
      ls_list_commentary-info = | User:    { sy-uname } |.
      APPEND ls_list_commentary TO it_list_commentary.

      CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
        EXPORTING
          it_list_commentary = it_list_commentary.
    WHEN OTHERS.
  ENDCASE.
ENDFORM.

**********************************************************************

FORM build_field_cat_hier USING pv_program_name      TYPE sy-repid
                                pv_internal_tabname  TYPE slis_tabname
                                pv_structure_name    TYPE  tabname
                                CHANGING ct_fieldcat TYPE slis_t_fieldcat_alv.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = pv_program_name
      i_internal_tabname     = pv_internal_tabname
      i_structure_name       = pv_structure_name
*     i_client_never_display = 'X'
*     i_inclname             =
*     i_bypassing_buffer     =
*     i_buffer_active        =
    CHANGING
      ct_fieldcat            = ct_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.

**********************************************************************

FORM display_alv_hier.

  DATA ls_keyinfo TYPE slis_keyinfo_alv.  "estructura para pasar los campos claves relacionados

  ls_keyinfo-header01 = 'MANDT'.
  ls_keyinfo-header02 = 'CARRID'.
  ls_keyinfo-header03 = 'CONNID'.

  ls_keyinfo-item01 = 'MANDT'.
  ls_keyinfo-item02 = 'CARRID'.
  ls_keyinfo-item03 = 'CONNID'.

  CALL FUNCTION 'REUSE_ALV_HIERSEQ_LIST_DISPLAY'
    EXPORTING
*     i_interface_check       = space
      i_callback_program      = sy-repid
*     i_callback_pf_status_set = space
      i_callback_user_command = 'USER_COMMAND'
*     is_layout               =
      it_fieldcat             = gt_fieldcat
*     it_excluding            =
*     it_special_groups       =
*     it_sort                 =
*     it_filter               =
*     is_sel_hide             =
*     i_screen_start_column   = 0
*     i_screen_start_line     = 0
*     i_screen_end_column     = 0
*     i_screen_end_line       = 0
*     i_default               = 'X'
*     i_save                  = space
*     is_variant              =
      it_events               = gt_events
*     it_event_exit           =
      i_tabname_header        = 'GT_HEADER' " No confundir nombre de la taba mayusculas y '' con la tabla en si (variable name)
      i_tabname_item          = 'GT_ITEMS'
*     i_structure_name_header =
*     i_structure_name_item   =
      is_keyinfo              = ls_keyinfo
*     is_print                =
*     is_reprep_id            =
*     i_bypassing_buffer      =
*     i_buffer_active         =
*     ir_salv_hierseq_adapter =
*     it_except_qinfo         =
*     i_suppress_empty_data   = abap_false
*  IMPORTING
*     e_exit_caused_by_caller =
*     es_exit_caused_by_user  =
    TABLES
      t_outtab_header         = gt_header
      t_outtab_item           = gt_items
    EXCEPTIONS
      program_error           = 1
      OTHERS                  = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.
