*&---------------------------------------------------------------------*
*& Include zbi_virt_msaa217_f01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form init_2000
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_2000 .
  CHECK ok_code IS NOT INITIAL.

  CASE ok_code.

    WHEN 'LIB_P'.

      IF gv_first_time EQ abap_true.
        PERFORM    free_container.
      ENDIF.

      PERFORM    paper_books.
      IF gv_first_time EQ abap_false.
        gv_first_time = abap_true.
      ENDIF.

    WHEN 'LIB_E'.

      IF gv_first_time EQ abap_true.
        PERFORM    free_container.
      ENDIF.
      IF gv_first_time EQ abap_false.
        gv_first_time = abap_true.
      ENDIF.

      PERFORM    e_books.

    WHEN 'CAT_L'.

      IF gv_first_time EQ abap_true.
        PERFORM    free_container.
      ENDIF.
      IF gv_first_time EQ abap_false.
        gv_first_time = abap_true.
      ENDIF.

      PERFORM    categorias_libros.

    WHEN 'CAT_LC'.

      IF gv_first_time EQ abap_true.
        PERFORM    free_container.
      ENDIF.
      IF gv_first_time EQ abap_false.
        gv_first_time = abap_true.
      ENDIF.

      PERFORM    categorias_libros_clientes.

    WHEN 'ACC_C_L'.

      IF gv_first_time EQ abap_true.
        PERFORM    free_container.
      ENDIF.
      IF gv_first_time EQ abap_false.
        gv_first_time = abap_true.
      ENDIF.

      PERFORM   acceso_categorias_libros.

    WHEN 'UNDO'.
      PERFORM    free_container.

    WHEN OTHERS.

  ENDCASE.
ENDFORM.

**********************************************************************

FORM get_data.
  CASE ok_code.
    WHEN 'LIB_P'.

      SELECT FROM zbi_lib_logali
      FIELDS *
      WHERE formato EQ 'P'
      INTO CORRESPONDING FIELDS OF TABLE @gt_paper_books.

    WHEN 'LIB_E'.

      SELECT FROM zbi_lib_logali
      FIELDS *
      WHERE formato EQ 'E'
      INTO CORRESPONDING FIELDS OF TABLE @gt_ebooks.

    WHEN 'CAT_L'.

      PERFORM get_data_cat_lib.

    WHEN OTHERS.
  ENDCASE.


ENDFORM.

**********************************************************************

FORM instance_cust_cont USING pv_book_type.

  DATA lo_gui_splitter_cont TYPE REF TO cl_gui_splitter_container.  " para split del custom cont

  CREATE OBJECT go_custom_container
    EXPORTING
*     parent         =
      container_name = 'CUSCONT'
*     style          =
*     lifetime       = lifetime_default
*     repid          =
*     dynnr          =
*     no_autodef_progid_dynnr     =
*  EXCEPTIONS
*     cntl_error     = 1
*     cntl_system_error           = 2
*     create_error   = 3
*     lifetime_error = 4
*     lifetime_dynpro_dynpro_link = 5
*     others         = 6
    .
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
  IF pv_book_type EQ 'P'.
    CREATE OBJECT lo_gui_splitter_cont
      EXPORTING
*       link_dynnr        =
*       link_repid        =
*       shellstyle        =
*       left              =
*       top               =
*       width             =
*       height            =
*       metric            = cntl_metric_dynpro
*       align             = 15
        parent            = go_custom_container  "importnt
        rows              = 2
        columns           = 1
*       no_autodef_progid_dynnr =
*       name              =
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

    " HEader
    lo_gui_splitter_cont->get_container(  "asigno una ref (otro cont al split)
      EXPORTING
        row       = 1
        column    = 1
      RECEIVING
        container = go_gui_cont_header
    ).

    lo_gui_splitter_cont->set_row_height(
      EXPORTING
        id                = 1  "row id
        height            = 20
*  IMPORTING
*       result            =
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3
    ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    "body
    lo_gui_splitter_cont->get_container(
      EXPORTING
        row       = 2
        column    = 1
      RECEIVING
        container = go_gui_cont_body
    ).
  ENDIF.

ENDFORM.


**********************************************************************
FORM free_container.
  IF go_custom_container IS BOUND.
    go_custom_container->free(
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3
    ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    CLEAR go_custom_container.

    IF go_alv_paper_lib IS BOUND.
      CLEAR go_alv_paper_lib.
    ENDIF.

    IF go_salv_table IS BOUND.
      CLEAR go_salv_table.
    ENDIF.

    IF go_salv_event IS BOUND.
      CLEAR go_salv_event.
    ENDIF.

  ENDIF.

  IF go_salv_hier_cat_lib IS BOUND.
    CLEAR go_salv_hier_cat_lib.
  ENDIF.

  IF go_salv_tree_cat_lib_cli IS BOUND.
    CLEAR: gt_temp_cat_lib_cli, go_salv_tree_cat_lib_cli.
  ENDIF.

  IF go_gui_tree_acc_cat_lib IS BOUND.
    CLEAR: go_gui_tree_acc_cat_lib.
  ENDIF.
  cl_gui_cfw=>flush(
    EXCEPTIONS
      cntl_system_error = 1
      cntl_error        = 2
      OTHERS            = 3
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.
**********************************************************************
FORM paper_books.

  IF go_alv_paper_lib IS NOT BOUND.

    PERFORM:          instance_cust_cont USING 'P',
                      build_field_cat,
                      get_data,                    " extraemos datos
                      instance_alv_lib_paper,      "instanciamos alv
                      create_alv_grid_header,
                      build_layout,                " LAYOUT
                      set_alv_grid_handlers,       " subrutina para eventos
                      register_events,
                      create_alv_grid_variants,
                      exclude_alv_grid_toolbar,
                      display_alv_lib_paper.

  ELSE .
    "refresh data
    PERFORM refresh_alv_paper_lib.

  ENDIF.

ENDFORM.





FORM build_field_cat.

  FIELD-SYMBOLS <ls_fieldcat> TYPE lvc_s_fcat.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     i_buffer_active        =
      i_structure_name       = 'ZBI_LIB_LOGALI' " le pasamos la tabla que queremos extraer los fields
*     i_client_never_display = 'X'
*     i_bypassing_buffer     =
*     i_internal_tabname     =
    CHANGING
      ct_fieldcat            = gt_fieldcat  "pasamos tabla interna typo lvc_t_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.

  ELSE.

*UNA VEZ CReata la  tabla fieldcat, loopeamos y en la columna (field) que nos interesa, habilitamos la opcion de ayuda
    LOOP AT gt_fieldcat ASSIGNING <ls_fieldcat>.

      CASE <ls_fieldcat>-fieldname.

        WHEN 'BI_CATEG'.
          <ls_fieldcat>-f4availabl = abap_true.

        WHEN 'ID_LIBRO'.
          <ls_fieldcat>-hotspot = abap_true.

        WHEN 'PRECIO'.
          <ls_fieldcat>-do_sum = abap_true.

      ENDCASE.

    ENDLOOP.
  ENDIF.

ENDFORM.





FORM instance_alv_lib_paper.

  CREATE OBJECT go_alv_paper_lib
    EXPORTING
*     i_shellstyle      = 0
*     i_lifetime        =
      i_parent          = go_gui_cont_body "go_custom_container  "contenedor padrr
*     i_appl_events     = space
*     i_parentdbg       =
*     i_applogparent    =
*     i_graphicsparent  =
*     i_name            =
*     i_fcat_complete   = space
*     o_previous_sral_handler =
    EXCEPTIONS
      error_cntl_create = 1
      error_cntl_init   = 2
      error_cntl_link   = 3
      error_dp_create   = 4
      OTHERS            = 5.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.

FORM display_alv_lib_paper.

  DATA(lt_sort) = VALUE lvc_t_sort( ( fieldname = 'AUTOR'
                                      up = abap_true ) ).

  DATA: lt_filter TYPE lvc_t_filt,
        ls_filter TYPE lvc_s_filt.

  ls_filter-fieldname = 'IDIOMA'.
  ls_filter-sign = 'I'. "incluir
  ls_filter-option = 'EQ'.
  ls_filter-low = 'S'.
* ls_filter-high = 'EN'.
  APPEND ls_filter TO lt_filter.

  go_alv_paper_lib->set_table_for_first_display(  "mtodo para prepaprar tabla
    EXPORTING
*     i_buffer_active               =
*     i_bypassing_buffer            =
*     i_consistency_check           =
*     i_structure_name              =
      is_variant                    = gs_variant
      i_save                        = 'U'  " U-a-x
*     i_default                     = 'X'
      is_layout                     = gs_layout
*     is_print                      =
*     it_special_groups             =
      it_toolbar_excluding          = gt_exclude
*     it_hyperlink                  =
*     it_alv_graphics               =
*     it_except_qinfo               =
*     ir_salv_adapter               =
    CHANGING
      it_outtab                     = gt_paper_books
      it_fieldcatalog               = gt_fieldcat
      it_sort                       = lt_sort
      it_filter                     = lt_filter  "im having problems with filter
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.

FORM refresh_alv_paper_lib.

  go_alv_paper_lib->refresh_table_display(
*  EXPORTING
*    is_stable      =
*    i_soft_refresh =
    EXCEPTIONS
      finished = 1
      OTHERS   = 2
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.

FORM build_layout.

  DATA ls_field_style TYPE lvc_s_styl.

  gs_layout = VALUE #( zebra = abap_true
                       edit  = abap_true
                       stylefname = 'FIELD_STYLE'
                       cwidth_opt = abap_true ).

  LOOP AT gt_fieldcat ASSIGNING FIELD-SYMBOL(<ls_fieldcat>)
  WHERE key EQ abap_true.

    LOOP AT gt_paper_books ASSIGNING FIELD-SYMBOL(<ls_paper_books>).  "a cada libro, en sus campos claves le aplico un estilo disabled

      ls_field_style-fieldname = <ls_fieldcat>-fieldname.
      ls_field_style-style  = cl_gui_alv_grid=>mc_style_disabled.

      INSERT ls_field_style INTO TABLE <ls_paper_books>-field_style.

    ENDLOOP.


  ENDLOOP.

ENDFORM.

FORM set_alv_grid_handlers.

  go_event_alv_grid = NEW #(  ).   "IMPORTANTE instanciar antes de linkear eventos

  SET HANDLER:
    go_event_alv_grid->handle_data_changed           FOR go_alv_paper_lib,
    go_event_alv_grid->handle_double_click           FOR go_alv_paper_lib,
    go_event_alv_grid->handle_user_command           FOR go_alv_paper_lib,
    go_event_alv_grid->handle_toolbar                FOR go_alv_paper_lib,
    go_event_alv_grid->handle_onf4                   FOR go_alv_paper_lib,
    go_event_alv_grid->handle_data_changed_finished  FOR go_alv_paper_lib,
    go_event_alv_grid->handle_hotspot_click          FOR go_alv_paper_lib.

ENDFORM.

FORM register_events.  "no entiendo muy bien que hace eeta funcion

  DATA: lt_f4 TYPE lvc_t_f4, "tabla para ayuda
        ls_f4 TYPE lvc_s_f4.

  ls_f4-fieldname = 'BI_CATEG'.  "Una estructura para cada columna que queremos mostrar en el f4
  ls_f4-register = abap_true.
  APPEND ls_f4 TO lt_f4.

  ls_f4-fieldname = 'Text'.  "Una estructura para cada columna que queremos mostrar en el f4
  ls_f4-register = abap_true.
  APPEND ls_f4 TO lt_f4.


  go_alv_paper_lib->register_f4_for_fields( it_f4 = lt_f4 ).
  go_alv_paper_lib->register_edit_event(
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_enter  " el id del evento enter es una constante de valor 19 si miramos en la clase  disparadora
    EXCEPTIONS
      error      = 1
      OTHERS     = 2
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.


ENDFORM.

FORM create_alv_grid_variants.

  gs_variant-report = sy-repid.
  gs_variant-username = sy-uzeit.
ENDFORM.

FORM exclude_alv_grid_toolbar.

  DATA ls_exclude TYPE ui_func.
  ls_exclude = cl_gui_alv_grid=>mc_fc_info.
  APPEND ls_exclude TO gt_exclude.

ENDFORM.

FORM create_alv_grid_header.

  DATA: lo_doc_head TYPE REF TO cl_dd_document,
        lv_text     TYPE sdydo_text_element,
        lv_num_reg  TYPE i,
        lv_time     TYPE c LENGTH 8.

  WRITE sy-uzeit TO lv_time.
  lv_text = |Welcome { sy-uname  }|.

  CREATE OBJECT lo_doc_head.

  lo_doc_head->add_text_as_heading(
    EXPORTING
      text          = lv_text
*     sap_color     =
*     sap_fontstyle =
      heading_level = 1
*     a11y_tooltip  =
*  CHANGING
*     document      =
  ).


  DESCRIBE TABLE gt_paper_books LINES lv_num_reg.
  lv_text = |Number of Registers: { lv_num_reg }|.

  lo_doc_head->add_text( text = lv_text ).

  lv_text = | Local Time: { lv_time }|.

  lo_doc_head->add_text( text = lv_text ).

  lo_doc_head->display_document(
    EXPORTING
*     reuse_control      =
*     reuse_registration =
*     container          =
      parent = go_gui_cont_header
*  EXCEPTIONS
*     html_display_error = 1
*     others = 2
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.

*************************ALV LIST *********************************************
FORM e_books.
  IF go_salv_table IS NOT BOUND.
    PERFORM:
             get_data,
             instance_cust_cont USING 'E',
             instance_salv,
             enable_salv_functions,  "funciones standard (toolbar)
             enable_salv_events,
             change_salv_layout,
             change_salv_columns,
             add_salv_aggregations, "EL servidor de practicas no permite el funcionamineto correcto
             add_salv_sorts,  "EL servidor de practicas no permite el funcionamineto correcto
             add_salv_filters,
             add_salv_colors.

  ENDIF.

  PERFORM display_salv.

ENDFORM.


FORM instance_salv.

  DATA lx_salv_msg TYPE REF TO cx_salv_msg.

  TRY.
      cl_salv_table=>factory(
        EXPORTING
*         list_display = if_salv_c_bool_sap=>false
          r_container  = go_custom_container  "our container
*         container_name =
        IMPORTING
          r_salv_table = go_salv_table
        CHANGING
          t_table      = gt_ebooks
      ).
    CATCH cx_salv_msg.
      WRITE lx_salv_msg->get_text( ).

  ENDTRY.
ENDFORM.

FORM display_salv.

  go_salv_table->display( ).

ENDFORM.

FORM enable_salv_functions.

  DATA: lo_functions TYPE REF TO cl_salv_functions_list,
        lv_name      TYPE salv_de_function,
        lv_icon      TYPE string,
        lv_text      TYPE string,
        lv_tooltip   TYPE string.


  lo_functions = go_salv_table->get_functions( ).

  lo_functions->set_all(
*    value = if_salv_c_bool_sap=>true
  ).

  lv_icon = icon_apple_numbers.
  TRY.
      lo_functions->add_function(
        EXPORTING
          name     = 'TOTAL'
          icon     = lv_icon
*         text     = 'Total'
          tooltip  = 'No total de libros electrónicos'
          position = if_salv_c_function_position=>right_of_salv_functions
      ).
    CATCH cx_salv_existing.
    CATCH cx_salv_wrong_call.

  ENDTRY.

ENDFORM.

FORM enable_salv_events.

  DATA lo_events TYPE REF TO cl_salv_events_table.
  IF go_salv_event IS NOT BOUND.

    go_salv_event = NEW #(  ).

    lo_events = go_salv_table->get_event( ).


    SET HANDLER go_salv_event->handle_added_function FOR lo_events.

  ENDIF.
ENDFORM.

FORM change_salv_layout.
  DATA: lo_salv_layout TYPE REF TO cl_salv_layout,
        ls_key         TYPE salv_s_layout_key,
        lv_variant     TYPE slis_vari.
  lo_salv_layout = go_salv_table->get_layout( ).

  ls_key-report = sy-repid.
  ls_key-logical_group = 'LIE'.
*lo_salv_layout->

  lo_salv_layout->set_key( ls_key  ).

  lo_salv_layout->set_save_restriction(
    value = if_salv_c_layout=>restrict_none
  ).

  lv_variant = 'DEFAULT'.
  lo_salv_layout->set_initial_layout( lv_variant  ).

ENDFORM.

FORM change_salv_columns.

  DATA: lo_columns    TYPE REF TO cl_salv_columns_table,
        lo_sng_column TYPE REF TO cl_salv_column.

  lo_columns = go_salv_table->get_columns( ).
  lo_columns->set_optimize( abap_true ).

  TRY.

      lo_sng_column = lo_columns->get_column( columnname = 'MANDT' ).
      lo_sng_column->set_visible( abap_false ).

    CATCH cx_salv_not_found.

  ENDTRY.

ENDFORM.

FORM add_salv_aggregations.

  DATA: lo_aggregations TYPE REF TO cl_salv_aggregations,
        lo_aggregation  TYPE REF TO cl_salv_aggregation,
        lcx_error       TYPE REF TO cx_root.

  lo_aggregations = go_salv_table->get_aggregations( ).



  TRY.
      lo_aggregations->add_aggregation(
        EXPORTING
          columnname  = 'PRECIO'
          aggregation = 1
        RECEIVING
          value       = lo_aggregation
      ).

    CATCH cx_salv_data_error INTO lcx_error.
      WRITE lcx_error->get_text( ).
    CATCH cx_salv_not_found.
    CATCH cx_salv_existing.
  ENDTRY.



ENDFORM.


FORM add_salv_sorts.

  DATA lo_sorts TYPE REF TO  cl_salv_sorts.


  lo_sorts = go_salv_table->get_sorts( ).

  TRY.
      lo_sorts->add_sort(
        EXPORTING
          columnname = 'AUTOR'
*         position   =
          sequence   = if_salv_c_sort=>sort_up
*         subtotal   = if_salv_c_bool_sap=>false
*         group      = if_salv_c_sort=>group_none
*         obligatory = if_salv_c_bool_sap=>false
*  RECEIVING
*         value      =
      ).
    CATCH cx_salv_not_found.
    CATCH cx_salv_existing.
    CATCH cx_salv_data_error.
  ENDTRY.

ENDFORM.

FORM add_salv_filters.

  DATA lo_filters TYPE REF TO  cl_salv_filters.


  lo_filters = go_salv_table->get_filters( ).

  TRY.
      lo_filters->add_filter(
        EXPORTING
          columnname = 'IDIOMA'
          sign       = 'I'
          option     = 'EQ'
          low        = 'S'
*         high       =
*  RECEIVING
*         value      =
      ).
    CATCH cx_salv_not_found.
    CATCH cx_salv_data_error.
    CATCH cx_salv_existing.

  ENDTRY.
ENDFORM.

FORM add_salv_colors.

  DATA: lo_columns   TYPE REF TO cl_salv_columns_table,
        lo_column    TYPE REF TO cl_salv_column_table,
        ls_color     TYPE lvc_s_colo,
        ls_color_all TYPE lvc_s_scol.


  lo_columns = go_salv_table->get_columns( ).


  TRY.
*lo_column ?= LO_COLUMNS->get_column( columnname = 'PRECIO' ).    " ?= ES UN CASTING
*           CATCH cx_salv_not_found.

      LOOP AT gt_ebooks ASSIGNING FIELD-SYMBOL(<ls_ebooks>).

        IF <ls_ebooks>-moneda EQ 'EUR'.
          ls_color_all-color-col = 7.
          ls_color_all-color-int = 0.
          ls_color_all-color-inv = 1.
          APPEND ls_color_all TO <ls_ebooks>-t_color.
        ELSEIF <ls_ebooks>-moneda EQ 'USD'.
          ls_color_all-color-col = 7.
          ls_color_all-color-int = 0.
          ls_color_all-color-inv = 0.
          APPEND ls_color_all TO <ls_ebooks>-t_color.
        ENDIF.
        CLEAR ls_color_all.

      ENDLOOP.

      lo_columns->set_color_column( value =  'T_COLOR').
    CATCH cx_salv_data_error.

  ENDTRY.

ENDFORM.

***************************ALV JERARQUICO*******************************************

FORM categorias_libros.

  IF  go_salv_hier_cat_lib IS NOT BOUND.

    PERFORM:  get_data,
              build_salv_hier,
              enable_salv_hier_func,
              config_salv_hier_col,
              enable_salv_hierseq_events,
              create_salv_hier_top_end.

  ENDIF.

  PERFORM    display_salv_hier.


ENDFORM.

FORM build_salv_hier.

  DATA: lt_binding TYPE salv_t_hierseq_binding,
        ls_binding TYPE salv_s_hierseq_binding.

  ls_binding-master = 'MANDT'.
  ls_binding-slave = 'MANDT'.
  APPEND ls_binding TO lt_binding.

  ls_binding-master = 'BI_CATEG'.
  ls_binding-slave = 'BI_CATEG'.
  APPEND ls_binding TO lt_binding.



  TRY.

      cl_salv_hierseq_table=>factory(
        EXPORTING
          t_binding_level1_level2 = lt_binding
        IMPORTING
          r_hierseq               = go_salv_hier_cat_lib
        CHANGING
          t_table_level1          = gt_hier_cat
          t_table_level2          = gt_hier_lib
      ).
    CATCH cx_salv_data_error.
    CATCH cx_salv_not_found.
  ENDTRY.


ENDFORM.

FORM display_salv_hier.

  go_salv_hier_cat_lib->display( ).

ENDFORM.

FORM enable_salv_hier_func.

  DATA: lo_functions TYPE REF TO cl_salv_functions.


  lo_functions =  go_salv_hier_cat_lib->get_functions( ).

  lo_functions->set_all(
*    value = if_salv_c_bool_sap=>true
  ).

ENDFORM.

FORM get_data_cat_lib.

* ZBI_CLN_LOGALI-ID_CLIENTE
* ZBI_CLN_LOGALI-APELLIDOS
* ZBI_CLN_LOGALI-NOMBRE
* ZBI_CLN_LOGALI-EMAIL
* ZBI_CLN_LOGALI-TIPO_ACCESO

  DATA: lt_cond_table   TYPE TABLE OF hrcond,
        ls_cond_table   TYPE hrcond,
        lt_where_clause TYPE TABLE OF string.

  IF NOT zbi_cat_logali-bi_categ IS INITIAL.
    ls_cond_table-field = 'BI_CATEG'.
    ls_cond_table-opera = 'EQ'.
    ls_cond_table-low = zbi_cat_logali-bi_categ.

    APPEND ls_cond_table TO lt_cond_table.

*else.
*MESSAGE i004(zbi_msg_msaa217).

  ENDIF.

  IF NOT lt_cond_table IS INITIAL.

    CALL FUNCTION 'RH_DYNAMIC_WHERE_BUILD'
      EXPORTING
        dbtable         = 'ZBI_CAT_LOGALI'
      TABLES
        condtab         = lt_cond_table
        where_clause    = lt_where_clause
      EXCEPTIONS
        empty_condtab   = 1
        no_db_field     = 2
        unknown_db      = 3
        wrong_condition = 4
        OTHERS          = 5.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDIF.
  IF NOT lt_where_clause IS INITIAL.
    SELECT * FROM zbi_cat_logali
    INTO TABLE gt_hier_cat
    WHERE (lt_where_clause).

  ELSE.

    SELECT * FROM zbi_cat_logali
    INTO TABLE gt_hier_cat.

  ENDIF.

  IF sy-subrc EQ 0.

    SELECT * FROM zbi_lib_logali
    INTO TABLE gt_hier_lib
    FOR ALL ENTRIES IN gt_hier_cat
    WHERE bi_categ EQ gt_hier_cat-bi_categ.

  ENDIF.

ENDFORM.

FORM config_salv_hier_col.

  DATA: lo_hier_columns TYPE REF TO cl_salv_columns_hierseq,
        lo_hier_column  TYPE REF TO cl_salv_column_hierseq,
        lo_hier_level   TYPE REF TO cl_salv_hierseq_level.

  TRY.
      lo_hier_columns = go_salv_hier_cat_lib->get_columns( level = 1 ).
    CATCH cx_salv_not_found.
  ENDTRY.

  TRY.
      lo_hier_column ?= lo_hier_columns->get_column( columnname = 'MANDT').
    CATCH cx_salv_not_found.
  ENDTRY.


  lo_hier_column->set_technical(
    value = if_salv_c_bool_sap=>true
  ).

  TRY.
      lo_hier_columns->set_expand_column( value = 'DESCRIPCION' ).
    CATCH cx_salv_data_error.
  ENDTRY.


  TRY.
      lo_hier_level = go_salv_hier_cat_lib->get_level( level = 1 ).
    CATCH cx_salv_not_found.
  ENDTRY.


  lo_hier_level->set_items_expanded(
    value = if_salv_c_bool_sap=>false
  ).




****************** level 2 ****************************

  TRY.
      lo_hier_columns = go_salv_hier_cat_lib->get_columns( level = 2 ).
    CATCH cx_salv_not_found.
  ENDTRY.

  TRY.
      lo_hier_column ?= lo_hier_columns->get_column( columnname = 'MANDT').
    CATCH cx_salv_not_found.
  ENDTRY.


  lo_hier_column->set_technical(
    value = if_salv_c_bool_sap=>true
  ).

  TRY.
      lo_hier_column ?= lo_hier_columns->get_column( columnname = 'TITULO' ).
      lo_hier_column->set_cell_type( if_salv_c_cell_type=>hotspot ).
    CATCH cx_salv_not_found.
  ENDTRY.


ENDFORM.



FORM enable_salv_hierseq_events.

  DATA lo_hier_events TYPE REF TO cl_salv_events_hierseq.


  CREATE OBJECT go_salv_event_hierseq.

  lo_hier_events = go_salv_hier_cat_lib->get_event( ).

  SET HANDLER go_salv_event_hierseq->handle_link_click FOR lo_hier_events.


ENDFORM.




FORM create_salv_hier_top_end.

  DATA: lo_header  TYPE REF TO cl_salv_form_layout_grid,
        lo_header1 TYPE REF TO cl_salv_form_layout_grid,
        lo_label   TYPE REF TO cl_salv_form_label,
        lo_label1  TYPE REF TO cl_salv_form_label,
        lo_flow    TYPE REF TO cl_salv_form_layout_flow,
        lv_text    TYPE string,
        lv_number  TYPE i.

  CREATE OBJECT lo_header.

  lo_label = lo_header->create_label( row    = 1
                                      column = 1 ).

  lv_text = |Welcome, { sy-uname } |.
  lo_label->set_text( lv_text ).


  DESCRIBE TABLE gt_hier_lib LINES lv_number.
  lv_text = |Nº de Libros: { lv_number } |.

  lo_flow = lo_header->create_flow(
    row    = 2
    column = 1
*   rowspan =
*   colspan =
  ).

  lo_flow->create_text(
    EXPORTING
*     position =
      text = lv_text
*     tooltip  =
*  RECEIVING
*     r_value  =
  ).

  go_salv_hier_cat_lib->set_top_of_list( value = lo_header ).

**************** END OF LIST
  CREATE OBJECT lo_header1.

  DESCRIBE TABLE gt_hier_cat LINES lv_number.
  lv_text = |Nº of Categories: { lv_number }|.

  lo_label1 = lo_header1->create_label( row    = 1
                                        column = 1 ).
  lo_label1->set_text( lv_text ).

  go_salv_hier_cat_lib->set_end_of_list( value = lo_header1 ).

ENDFORM.

**************************ALV TREE*************************************

FORM categorias_libros_clientes.

  PERFORM: instance_cust_cont USING 'C',
           build_salv_tree,
           build_salv_tree_header,
           get_salv_tree_data,
           set_salv_tree_nodes,
           config_salv_tree_col,
           display_salv_tree.
ENDFORM.




FORM build_salv_tree.

  TRY.
      cl_salv_tree=>factory(
        EXPORTING
          r_container = go_custom_container
*         hide_header =
        IMPORTING
          r_salv_tree = go_salv_tree_cat_lib_cli
        CHANGING
          t_table     = gt_temp_cat_lib_cli
      ).
    CATCH cx_salv_error.
  ENDTRY.

ENDFORM.


FORM display_salv_tree.

  go_salv_tree_cat_lib_cli->display( ).

ENDFORM.

FORM build_salv_tree_header.

  DATA lo_settings TYPE REF TO cl_salv_tree_settings.
  lo_settings =  go_salv_tree_cat_lib_cli->get_tree_settings( ).

  lo_settings->set_hierarchy_header( value = 'Registers' ).
  lo_settings->set_hierarchy_tooltip( value = 'Expand' ).
  lo_settings->set_hierarchy_size( value = 60 ).


ENDFORM.

FORM get_salv_tree_data.

* ZBI_CLN_LOGALI-ID_CLIENTE
* ZBI_CLN_LOGALI-APELLIDOS
* ZBI_CLN_LOGALI-NOMBRE
* ZBI_CLN_LOGALI-EMAIL


  DATA: lt_cond_table   TYPE TABLE OF hrcond,
        ls_cond_table   TYPE hrcond,
        lt_where_clause TYPE TABLE OF string.

  "prepare filter WHERE
  IF NOT zbi_cln_logali-id_cliente IS INITIAL.
    ls_cond_table-field = 'ID_CLIENTE'.
    ls_cond_table-opera = 'EQ'.
    ls_cond_table-low = zbi_cln_logali-id_cliente.

    APPEND ls_cond_table TO lt_cond_table.

  ENDIF.

  IF NOT zbi_cln_logali-apellidos IS INITIAL.
    ls_cond_table-field = 'APELLIDOS'.
    ls_cond_table-opera = 'EQ'.
    ls_cond_table-low = zbi_cln_logali-apellidos.

    APPEND ls_cond_table TO lt_cond_table.

  ENDIF.


  IF NOT zbi_cln_logali-nombre IS INITIAL.
    ls_cond_table-field = 'NOMBRE'.
    ls_cond_table-opera = 'EQ'.
    ls_cond_table-low = zbi_cln_logali-nombre.

    APPEND ls_cond_table TO lt_cond_table.

  ENDIF.

  IF NOT zbi_cln_logali-email IS INITIAL.
    ls_cond_table-field = 'EMAIL'.
    ls_cond_table-opera = 'EQ'.
    ls_cond_table-low = zbi_cln_logali-email.

    APPEND ls_cond_table TO lt_cond_table.

  ENDIF.

  IF NOT lt_cond_table IS INITIAL.

    CALL FUNCTION 'RH_DYNAMIC_WHERE_BUILD'
      EXPORTING
        dbtable         = 'ZBI_CLN_LOGALI'
      TABLES
        condtab         = lt_cond_table
        where_clause    = lt_where_clause
      EXCEPTIONS
        empty_condtab   = 1
        no_db_field     = 2
        unknown_db      = 3
        wrong_condition = 4
        OTHERS          = 5.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDIF.

  IF NOT lt_where_clause IS INITIAL.
    DATA(word) = lt_where_clause[ 1 ].
    REPLACE 'ID_CLIENTE' IN word WITH 'CLIENTES~ID_CLIENTE'.
    SELECT   categorias~bi_categ
             categorias~descripcion
             libros~id_libro
             libros~titulo
             libros~autor
             libros~editoral
             clientes~id_cliente
             clientes~nombre
             clientes~apellidos
             clientes~email
                FROM zbi_lib_logali AS libros
              INNER JOIN zbi_cat_logali AS categorias
                         ON libros~bi_categ EQ categorias~bi_categ
              INNER JOIN zbi_c_l_logali AS relacion
                         ON libros~id_libro EQ relacion~id_libro
              INNER JOIN zbi_cln_logali AS clientes
                         ON relacion~id_cliente EQ clientes~id_cliente
              INTO CORRESPONDING FIELDS OF TABLE gt_cat_lib_cli
              WHERE (word)
              ORDER BY categorias~bi_categ libros~id_libro.

  ELSE.
    SELECT   categorias~bi_categ
                 categorias~descripcion
                 libros~id_libro
                 libros~titulo
                 libros~autor
                 libros~editoral
                 clientes~id_cliente
                 clientes~nombre
                 clientes~apellidos
                 clientes~email
                    FROM zbi_lib_logali AS libros
                  INNER JOIN zbi_cat_logali AS categorias
                             ON libros~bi_categ EQ categorias~bi_categ
                  INNER JOIN zbi_c_l_logali AS relacion
                             ON libros~id_libro EQ relacion~id_libro
                  INNER JOIN zbi_cln_logali AS clientes
                             ON relacion~id_cliente EQ clientes~id_cliente
                  INTO TABLE gt_cat_lib_cli
                  ORDER BY categorias~bi_categ libros~id_libro.
  ENDIF.



ENDFORM.


FORM set_salv_tree_nodes.

  DATA: lo_nodes      TYPE REF TO cl_salv_nodes,
        lo_node       TYPE REF TO cl_salv_node,  "sin S para nodo padre
        lv_text       TYPE lvc_value,
        lv_key_categ  TYPE salv_de_node_key,
        lv_key_titulo TYPE salv_de_node_key.

  lo_nodes = go_salv_tree_cat_lib_cli->get_nodes( ).

  LOOP AT gt_cat_lib_cli ASSIGNING FIELD-SYMBOL(<ls_cat>).

    ON CHANGE OF <ls_cat>-bi_categ.    "on chage of, es u evento que se dispara cada vez que hay un bi categ en el loop
      lv_text = <ls_cat>-descripcion.
      TRY.
          lo_node = lo_nodes->add_node(
            EXPORTING
              related_node = space "significa que es el nodo padre
              relationship = if_salv_c_node_relation=>parent
              text         = lv_text
              expander     = abap_true   "desplegale
              folder       = abap_true ).   "nodo tipo carpetas
        CATCH cx_salv_msg.
      ENDTRY.

      lv_key_categ = lo_node->get_key( ).
    ENDON.

    ON CHANGE OF <ls_cat>-id_libro.

      lv_text = <ls_cat>-titulo.
      TRY.
          lo_node = lo_nodes->add_node(
            EXPORTING
              related_node = lv_key_categ
              relationship = if_salv_c_node_relation=>last_child
              text         = lv_text
              expander     = abap_true   "desplegale
              folder       = abap_true ).   "nodo tipo carpetas


        CATCH cx_salv_msg.
      ENDTRY.

      lv_key_titulo = lo_node->get_key( ).

    ENDON.

    lv_text = <ls_cat>-id_libro.
    TRY.
        lo_node = lo_nodes->add_node(
          EXPORTING
            related_node = lv_key_titulo
            relationship = if_salv_c_node_relation=>last_child
            data_row     = <ls_cat>
            text         = lv_text ).

*        lo_node->set_data_row( value = <ls_cat> ). "el metdo set data row es el que carga los datos en el ultimo hijo

      CATCH cx_salv_msg.
    ENDTRY.


  ENDLOOP.

  lo_nodes->expand_all( ).

ENDFORM.

FORM config_salv_tree_col.

  DATA: lo_columns TYPE REF TO cl_salv_columns_tree,
        lo_column  TYPE REF TO cl_salv_column.

  lo_columns = go_salv_tree_cat_lib_cli->get_columns( ).

  lo_columns->set_optimize(
    value = abap_true
  ).

*DESCRPCION,BI_CATEG, TITULO e ID_CLIENTE.

  TRY.
      lo_column = lo_columns->get_column( columnname = 'DESCRIPCION' ).
      lo_column->set_visible( abap_false ).
    CATCH cx_salv_not_found.

  ENDTRY.

  TRY.
      lo_column = lo_columns->get_column( columnname = 'BI_CATEG' ).
      lo_column->set_visible( abap_false ).
    CATCH cx_salv_not_found.

  ENDTRY.

  TRY.
      lo_column = lo_columns->get_column( columnname = 'TITULO' ).
      lo_column->set_visible( abap_false ).
    CATCH cx_salv_not_found.

  ENDTRY.

  TRY.
      lo_column = lo_columns->get_column( columnname = 'ID_LIBRO' ).
      lo_column->set_visible( abap_false ).
    CATCH cx_salv_not_found.

  ENDTRY.
ENDFORM.

*****************************ALV GUI TREE*****************************************

FORM acceso_categorias_libros.

  PERFORM: instance_cust_cont USING 'A',
           build_gui_tree,
           build_gui_tree_header,
           build_gui_tree_fieldcat,
           set_gui_tree_first_display,
           set_gui_tree_drag_drop,
           gui_tree_add_favourit,
           get_gui_tree_data,
           set_gui_tree_nodes,
           set_gui_tree_events,
           gui_tree_frontend_update.    "por ultimo hay que actalizar los datos

ENDFORM.





FORM build_gui_tree.

  CREATE OBJECT go_gui_tree_acc_cat_lib
    EXPORTING
*     lifetime                    =
      parent                      = go_custom_container
*     shellstyle                  =
      node_selection_mode         = cl_gui_column_tree=>node_sel_mode_single
*     hide_selection              =
      item_selection              = 'X'
*     no_toolbar                  =
      no_html_header              = 'X'
*     i_print                     =
*     i_fcat_complete             =
*     i_model_mode                =
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      illegal_node_selection_mode = 5
      failed                      = 6
      illegal_column_name         = 7
      OTHERS                      = 8.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.

FORM build_gui_tree_header.

  gs_gui_tree_header-heading = 'Registros'.
  gs_gui_tree_header-tooltip = 'Despliegue los nodos'.
  gs_gui_tree_header-width = 65.

ENDFORM.

FORM build_gui_tree_fieldcat.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZBI_ACC_CAT_LIB_LOGALI'
    CHANGING
      ct_fieldcat            = gt_gui_tree_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.


  LOOP AT gt_gui_tree_fieldcat ASSIGNING FIELD-SYMBOL(<ls_fieldcat>).

    IF         <ls_fieldcat>-fieldname EQ 'TIPO_ACCESO'  OR
               <ls_fieldcat>-fieldname EQ 'DESC_ACCESO'  OR
               <ls_fieldcat>-fieldname EQ 'BI_CATEG'     OR
               <ls_fieldcat>-fieldname EQ 'ID_LIBRO'     OR
               <ls_fieldcat>-fieldname EQ 'DESCRIPCION'.

      <ls_fieldcat>-no_out = abap_true.

    ENDIF.
  ENDLOOP.
ENDFORM.

FORM set_gui_tree_first_display.

  go_gui_tree_acc_cat_lib->set_table_for_first_display(
    EXPORTING
*     i_structure_name    =
*     is_variant          =
*     i_save              =
*     i_default           = 'X'
      is_hierarchy_header = gs_gui_tree_header
*     is_exception_field  =
*     it_special_groups   =
*     it_list_commentary  =
*     i_logo              =
*     i_background_id     =
*     it_toolbar_excluding =
*     it_except_qinfo     =
    CHANGING
      it_outtab           = gt_temp_acc_cat_lib
*     it_filter           =
      it_fieldcatalog     = gt_gui_tree_fieldcat
  ).


ENDFORM.

FORM gui_tree_frontend_update.

  go_gui_tree_acc_cat_lib->frontend_update( ).

ENDFORM.

FORM get_gui_tree_data.
  DATA: lt_datos TYPE TABLE OF dd07v,
        lv_where TYPE string.

  IF zbi_cln_logali-tipo_acceso IS INITIAL OR zbi_cln_logali-tipo_acceso EQ 5.
    "do nothing
  ELSE.
    lv_where = 'acceso~tipo_acceso eq ZBI_CLN_LOGALI-tipo_acceso'.
  ENDIF.
  SELECT           acceso~tipo_acceso
                   categorias~bi_categ
                   categorias~descripcion
                   libros~id_libro
                   libros~titulo
                   libros~autor
                   libros~editoral

                      FROM zbi_lib_logali AS libros
                    INNER JOIN zbi_cat_logali AS categorias
                               ON libros~bi_categ EQ categorias~bi_categ
                    INNER JOIN zbi_a_c_logali AS acceso
                               ON categorias~bi_categ EQ acceso~bi_categ

                    INTO CORRESPONDING FIELDS OF TABLE gt_acc_cat_lib
                    WHERE (lv_where)
                    ORDER BY acceso~tipo_acceso  categorias~bi_categ.

  CALL FUNCTION 'DD_DOMVALUES_GET'
    EXPORTING
      domname        = 'ZBI_TIPO_ACCESO'
      text           = 'X'
*     langu          = space
*     bypass_buffer  = space
*  IMPORTING
*     rc             =
    TABLES
      dd07v_tab      = lt_datos
    EXCEPTIONS
      wrong_textflag = 1
      OTHERS         = 2.


  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  LOOP AT gt_acc_cat_lib ASSIGNING FIELD-SYMBOL(<ls_books>).

    LOOP AT lt_datos ASSIGNING FIELD-SYMBOL(<ls_datos>)
    WHERE domvalue_l EQ <ls_books>-tipo_acceso.
      <ls_books>-desc_acceso = <ls_datos>-ddtext.

    ENDLOOP.

  ENDLOOP.


ENDFORM.

FORM  set_gui_tree_nodes.
  DATA: ls_node_layout     TYPE lvc_s_layn,
        lv_node_text       TYPE lvc_value,
        lv_new_node_acceso TYPE lvc_nkey,
        lv_new_node_categ  TYPE lvc_nkey.



  LOOP AT gt_acc_cat_lib ASSIGNING FIELD-SYMBOL(<ls_mmc_tree>).

    ON CHANGE OF <ls_mmc_tree>-tipo_acceso.
      ls_node_layout-isfolder = abap_true.
      ls_node_layout-expander = abap_true.

      lv_node_text = <ls_mmc_tree>-desc_acceso.

      go_gui_tree_acc_cat_lib->add_node(
        EXPORTING
          i_relat_node_key     = space
          i_relationship       = cl_gui_column_tree=>relat_last_child
*         is_outtab_line       =
          is_node_layout       = ls_node_layout
*         it_item_layout       =
          i_node_text          = lv_node_text
        IMPORTING
          e_new_node_key       = lv_new_node_acceso
        EXCEPTIONS
          relat_node_not_found = 1
          node_not_found       = 2
          OTHERS               = 3
      ).
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
    ENDON.

    ON CHANGE OF <ls_mmc_tree>-bi_categ.

      ls_node_layout-isfolder = abap_true.
      ls_node_layout-expander = abap_true.
      lv_node_text = <ls_mmc_tree>-descripcion.

      go_gui_tree_acc_cat_lib->add_node(
        EXPORTING
          i_relat_node_key     = lv_new_node_acceso
          i_relationship       = cl_gui_column_tree=>relat_last_child
*         is_outtab_line       =
          is_node_layout       = ls_node_layout
*         it_item_layout       =
          i_node_text          = lv_node_text
        IMPORTING
          e_new_node_key       = lv_new_node_categ
        EXCEPTIONS
          relat_node_not_found = 1
          node_not_found       = 2
          OTHERS               = 3
      ).
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
    ENDON.



    lv_node_text = <ls_mmc_tree>-id_libro.

    CLEAR ls_node_layout.  "limpio estructura porque trae folder type y expand
    ls_node_layout-dragdropid = gv_fav_line_id.  " le paso el id del nodo donde se puede arrastrary luego para soltar, uso el include de CL

    go_gui_tree_acc_cat_lib->add_node(
      EXPORTING
        i_relat_node_key     = lv_new_node_categ
        i_relationship       = cl_gui_column_tree=>relat_last_child
        is_outtab_line       = <ls_mmc_tree>
        is_node_layout       = ls_node_layout
*       it_item_layout       =
        i_node_text          = lv_node_text
*        IMPORTING
*       e_new_node_key       = lv_new_node_categ
      EXCEPTIONS
        relat_node_not_found = 1
        node_not_found       = 2
        OTHERS               = 3
    ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

  ENDLOOP.
  CLEAR ls_node_layout.
ENDFORM.


FORM gui_tree_add_favourit.

  DATA: ls_node_layout TYPE lvc_s_layn,
        lv_node_text   TYPE lvc_value.

  ls_node_layout-dragdropid = gv_fav_folder_id. "type i
  ls_node_layout-isfolder = abap_true.
  ls_node_layout-n_image = icon_system_favorites.
  lv_node_text = 'FAVORITE'.

  go_gui_tree_acc_cat_lib->add_node(
    EXPORTING
      i_relat_node_key = space
      i_relationship   = cl_gui_column_tree=>relat_last_child
*     is_outtab_line   =
      is_node_layout   = ls_node_layout
*     it_item_layout   =
      i_node_text      = lv_node_text
    IMPORTING
      e_new_node_key   = gv_fav_key
*  EXCEPTIONS
*     relat_node_not_found = 1
*     node_not_found   = 2
*     others           = 3
  ).
  IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.


ENDFORM.

FORM set_gui_tree_drag_drop.
  DATA lv_effect TYPE i.


  CREATE OBJECT: go_line_behaviour,
                 go_fav_behaviour.

  lv_effect = cl_dragdrop=>copy.

  go_line_behaviour->add(
    EXPORTING
      flavor          = 'favorit'
      dragsrc         = abap_true
      droptarget      = space
      effect          = lv_effect
*     effect_in_ctrl  = usedefaulteffect
    EXCEPTIONS
      already_defined = 1
      obj_invalid     = 2
      OTHERS          = 3
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.


  go_line_behaviour->get_handle(
    IMPORTING
      handle      = gv_fav_line_id  " es el indice de la linea a favoritear, cuando creamos registrosn(lines)
    EXCEPTIONS
      obj_invalid = 1
      OTHERS      = 2
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
  lv_effect = cl_dragdrop=>copy.

  go_fav_behaviour->add(
    EXPORTING
      flavor          = 'favorit'
      dragsrc         = space
      droptarget      = abap_true
      effect          = lv_effect "EFECTO COPY
*     effect_in_ctrl  = usedefaulteffect
    EXCEPTIONS
      already_defined = 1
      obj_invalid     = 2
      OTHERS          = 3
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.


  go_fav_behaviour->get_handle(
    IMPORTING
      handle      = gv_fav_folder_id  " type i ESTE VALOR VIENE A CREAR EL NODO FAVORITES
    EXCEPTIONS
      obj_invalid = 1
      OTHERS      = 2
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
*gv_fav_folder_id =

ENDFORM.


FORM set_gui_tree_events.

  CREATE OBJECT go_gui_tree_events.

  SET HANDLER:     go_gui_tree_events->handle_on_drag FOR go_gui_tree_acc_cat_lib,
                   go_gui_tree_events->handle_on_drop FOR go_gui_tree_acc_cat_lib.
ENDFORM.
