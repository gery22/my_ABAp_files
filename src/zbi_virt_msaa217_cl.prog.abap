*&---------------------------------------------------------------------*
*& Include zbi_virt_msaa217_cl
*&---------------------------------------------------------------------*


CLASS lcl_event_alv_grid DEFINITION.

  PUBLIC SECTION.

    METHODS handle_double_click FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING
        es_row_no
        e_column
        e_row.

    METHODS handle_data_changed FOR EVENT data_changed OF cl_gui_alv_grid
      IMPORTING
        er_data_changed
        e_onf4
        e_onf4_after
        e_onf4_before
        e_ucomm.

    METHODS handle_user_command FOR EVENT user_command OF cl_gui_alv_grid
      IMPORTING
        e_ucomm.

    METHODS handle_toolbar FOR EVENT toolbar OF cl_gui_alv_grid
      IMPORTING
        e_interactive
        e_object.

    METHODS handle_onf4 FOR EVENT onf4 OF cl_gui_alv_grid
      IMPORTING
        er_event_data
        es_row_no
        et_bad_cells
        e_display
        e_fieldname
        e_fieldvalue.

    METHODS handle_data_changed_finished FOR EVENT data_changed_finished OF cl_gui_alv_grid
      IMPORTING
        et_good_cells
        e_modified.

    METHODS handle_hotspot_click FOR EVENT hotspot_click OF cl_gui_alv_grid
      IMPORTING
        es_row_no
        e_column_id
        e_row_id.

ENDCLASS.

**********************************************************************

CLASS lcl_event_alv_grid IMPLEMENTATION.

  METHOD handle_data_changed.
    DATA lv_categ TYPE zbi_categorias.  "variable donde capturamos el cambio

    LOOP AT er_data_changed->mt_good_cells ASSIGNING FIELD-SYMBOL(<ls_data_chaged>).

      CASE <ls_data_chaged>-fieldname.

        WHEN 'BI_CATEG'.

          er_data_changed->get_cell_value(
            EXPORTING
              i_row_id    = <ls_data_chaged>-row_id
*             i_tabix     =
              i_fieldname = <ls_data_chaged>-fieldname
            IMPORTING
              e_value     = lv_categ ).

          SELECT SINGLE FROM zbi_cat_logali
          FIELDS bi_categ
          WHERE bi_categ EQ @lv_categ
          INTO @lv_categ.

          IF sy-subrc <> 0.

            er_data_changed->add_protocol_entry(   "este metodo devuelve un MSG concadenando las variables imsgn
              EXPORTING
                i_msgid     = 'ZBI_MSG_MSAA217'
                i_msgty     = 'E'  "EXCEPTION
                i_msgno     = '000'
                i_msgv1     = TEXT-c00
                i_msgv2     = lv_categ
                i_msgv3     = TEXT-c01
*               i_msgv4     =
                i_fieldname = <ls_data_chaged>-fieldname
                i_row_id    = <ls_data_chaged>-row_id ).
*               i_tabix     =

          ENDIF.

        WHEN OTHERS.

      ENDCASE.

    ENDLOOP.
  ENDMETHOD.

  METHOD handle_double_click.
    CASE e_column.

      WHEN 'BI_CATEG'.
        DATA(lv_bi_cat) = gt_paper_books[ es_row_no-row_id ]-bi_categ.
        DATA lt_datos TYPE TABLE OF dd07v.

        SELECT SINGLE tipo_acceso FROM zbi_a_c_logali
        WHERE bi_categ EQ @lv_bi_cat
        INTO @DATA(lv_tipoacc).

        CALL FUNCTION 'DD_DOMVALUES_GET'
          EXPORTING
            domname        = 'ZBI_TIPO_ACCESO'
            text           = 'X'
*           langu          = space
*           bypass_buffer  = space
*  IMPORTING
*           rc             =
          TABLES
            dd07v_tab      = lt_datos
          EXCEPTIONS
            wrong_textflag = 1
            OTHERS         = 2.

        IF sy-subrc <> 0.
          MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
        ENDIF.

        LOOP AT lt_datos  ASSIGNING FIELD-SYMBOL(<ls_book>)
        WHERE domvalue_l EQ lv_tipoacc.
          DATA(texto) = <ls_book>-ddtext.
          MESSAGE texto TYPE 'I'.
        ENDLOOP.
    ENDCASE.
  ENDMETHOD.

  METHOD handle_user_command.
    DATA:
      lt_ddbb_books TYPE TABLE OF zbi_lib_logali,
      ls_ddbb_books TYPE zbi_lib_logali.

    CASE e_ucomm.
      WHEN 'A_SAVE'.

        " PASAMOS A UNA TABLA TIPO DDBB CADA FILA QUE TUVO CAMBIOS (X)
        LOOP AT gt_paper_books ASSIGNING FIELD-SYMBOL(<ls_paper_books>)
                WHERE ddbb EQ abap_true.

          ls_ddbb_books = CORRESPONDING #( <ls_paper_books> ).
          APPEND ls_ddbb_books TO lt_ddbb_books.

        ENDLOOP.
        IF sy-subrc EQ 0.
          MODIFY zbi_lib_logali FROM TABLE lt_ddbb_books.

          IF sy-subrc <> 0.
            MESSAGE e000(zbi_msg_msaa217).
          ENDIF.
        ENDIF.

      WHEN OTHERS.

    ENDCASE.
  ENDMETHOD.

  METHOD handle_toolbar.

    " optional agregar botones a la toolbar
    DATA ls_toolbar TYPE stb_button.
    ls_toolbar = VALUE #( function  = 'A_SAVE'
                          quickinfo = 'Save'
                          icon      = '@F_SAVE@').

    APPEND ls_toolbar TO e_object->mt_toolbar.

  ENDMETHOD.

  METHOD handle_onf4.

    TYPES: BEGIN OF lty_categories,
             bi_categ    TYPE zbi_categorias,
             descripcion TYPE text60,
           END OF lty_categories.

    DATA: lt_return_tab TYPE STANDARD TABLE OF ddshretval,
          ls_categories TYPE lty_categories.

    FIELD-SYMBOLS <lt_modify_data> TYPE lvc_t_modi.

    CASE e_fieldname.
      WHEN 'BI_CATEG'.

        SELECT bi_categ, descripcion
        FROM zbi_cat_logali
        INTO TABLE @DATA(lt_categories)
        WHERE bi_categ NE @space.

        IF sy-subrc EQ 0.

          CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
            EXPORTING
*             ddic_structure   = space
              retfield    = 'BI_CATEG'
*             pvalkey     = space
              dynpprog    = sy-repid
              dynpnr      = sy-dynnr
              dynprofield = 'BI_CATEG'
*             stepl       = 0
*             window_title     =
*             value       = space
              value_org   = 'S'     "importante aqui structure y no Celda
*             multiple_choice  = space
*             display     = space
*             callback_program = space
*             callback_form    = space
*             callback_method  =
*             mark_tab    =
*  IMPORTING
*             user_reset  =
            TABLES
              value_tab   = lt_categories  "tabla con opciones de ayuda
*             field_tab   =
              return_tab  = lt_return_tab   "seleccion
*             dynpfld_mapping  =
*  EXCEPTIONS
*             parameter_error  = 1
*             no_values_found  = 2
*             others      = 3
            .
          IF sy-subrc <> 0.
            WRITE 'Error Help'.

          ELSE.

            DATA(ls_return_tab) = lt_return_tab[ 1 ].

            IF sy-subrc EQ 0.
              ASSIGN er_event_data->m_data->* TO <lt_modify_data>.
              APPEND VALUE #( row_id = es_row_no-row_id
                              fieldname = e_fieldname
                              value = ls_return_tab-fieldval ) TO <lt_modify_data>.
            ENDIF.
          ENDIF.
        ENDIF.
      WHEN OTHERS.
    ENDCASE.

    er_event_data->m_event_handled = abap_true.  "importante : hay que avisar al evento que nosotros harems el handle

  ENDMETHOD.

  METHOD handle_data_changed_finished.

    CHECK e_modified EQ abap_true.

    LOOP AT et_good_cells
            ASSIGNING FIELD-SYMBOL(<ls_good_cells>).

      READ TABLE gt_paper_books
            ASSIGNING FIELD-SYMBOL(<ls_books>)
            INDEX <ls_good_cells>-row_id.

      IF sy-subrc EQ 0.
        <ls_books>-ddbb = abap_true.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD handle_hotspot_click.

    CASE e_column_id.
      WHEN 'ID_LIBRO'.
        DATA(lv_id_book) = gt_paper_books[ es_row_no-row_id ]-id_libro.

        IF sy-subrc EQ 0.

          SELECT FROM zbi_cln_logali AS cust
          INNER JOIN zbi_c_l_logali AS rel ON
          cust~id_cliente EQ rel~id_cliente
          FIELDS cust~id_cliente, cust~nombre, cust~apellidos
          WHERE rel~id_libro EQ @lv_id_book
          INTO table@DATA(lt_customers).

          IF sy-subrc EQ 0.
            CALL FUNCTION 'POPUP_WITH_TABLE'
              EXPORTING
                endpos_col   = 160
                endpos_row   = 15
                startpos_col = 20
                startpos_row = 10
                titletext    = 'Customer'
*  IMPORTING
*               choice       =
              TABLES
                valuetab     = lt_customers
*  EXCEPTION
*               break_off    = 1
*               others       = 2
              .
            IF sy-subrc <> 0.
              MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
            ENDIF.
          ENDIF.
        ENDIF.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

***********************************************************************

CLASS lcl_salv_event DEFINITION.

  PUBLIC SECTION.

    METHODS handle_added_function FOR EVENT added_function
      OF cl_salv_events_table
      IMPORTING e_salv_function.

ENDCLASS.

CLASS lcl_salv_event IMPLEMENTATION.

  METHOD handle_added_function.

    CASE e_salv_function.

      WHEN 'TOTAL'.

        DATA lv_tot TYPE i.
        DESCRIBE TABLE gt_ebooks LINES lv_tot.
        MESSAGE i003(zbi_msg_msaa217) WITH lv_tot.


      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.

**********************************************************************
******* Hier

CLASS lcl_event_salv_hierseq DEFINITION.

  PUBLIC SECTION.

    METHODS handle_link_click   FOR EVENT link_click
      OF cl_salv_events_hierseq
      IMPORTING column
                level
                row.

ENDCLASS.

CLASS lcl_event_salv_hierseq IMPLEMENTATION.

  METHOD handle_link_click.

    READ TABLE gt_hier_lib INTO DATA(ls_books) INDEX row.

    IF ls_books-autor EQ 'Alferova E'.

      MESSAGE 'ALFEROVA IS SOOOOOOO HOT' TYPE 'I'.   "Easter Egg

    ELSE.

      SELECT nombre, apellidos, email FROM zbi_cln_logali
      INTO TABLE @DATA(lt_result)
      WHERE id_cliente EQ ( SELECT id_cliente FROM zbi_c_l_logali
                            WHERE id_libro EQ @ls_books-id_libro ).




      IF sy-subrc EQ 0.
        CALL FUNCTION 'POPUP_WITH_TABLE'
          EXPORTING
            endpos_col   = 80
            endpos_row   = 15
            startpos_col = 20
            startpos_row = 10
            titletext    = 'Bought by'
*  IMPORTING
*           choice       =
          TABLES
            valuetab     = lt_result
*  EXCEPTION
*           break_off    = 1
*           others       = 2
          .
        IF sy-subrc <> 0.
          MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
        ENDIF.
      ELSE.

        MESSAGE  i005(zbi_msg_msaa217) WITH ls_books-titulo.

      ENDIF.
*  EXCEPTION
*               break_off    = 1
*               others       = 2
      .
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
    ENDIF.


  ENDMETHOD.

ENDCLASS.
***************************GUI ALV TREE*******************************************

CLASS lcl_drag_drop_object DEFINITION.

  PUBLIC SECTION.
    DATA: gs_data      TYPE zbi_acc_cat_lib_logali, "structura que recibe los datos arrastrados
          gv_node_text TYPE lvc_value.


ENDCLASS.

*value(DRAG_DROP_OBJECT) type ref to CL_DRAGDROPOBJECT
*      value(NODE_KEY) type LVC_NKEY .

CLASS lcl_gui_tree_events DEFINITION.

  PUBLIC SECTION.

    METHODS: handle_on_drag FOR EVENT on_drag
      OF cl_gui_alv_tree
      IMPORTING sender
                node_key
                fieldname
                drag_drop_object, "devuelve un objeto a rellenar

      handle_on_drop FOR EVENT on_drop
        OF cl_gui_alv_tree
        IMPORTING sender
                  drag_drop_object "devielve el objeto rellenado anteriormente
                  node_key.


ENDCLASS.

CLASS lcl_gui_tree_events IMPLEMENTATION.

  METHOD handle_on_drag.
    DATA lo_drag_drop TYPE REF TO lcl_drag_drop_object.

    CREATE OBJECT lo_drag_drop.


    sender->get_outtab_line(
      EXPORTING
        i_node_key     = node_key  " lo trae el evento
      IMPORTING
        e_outtab_line  = lo_drag_drop->gs_data
        e_node_text    = lo_drag_drop->gv_node_text
*       et_item_layout =
*       es_node_layout =
      EXCEPTIONS
        node_not_found = 1
        OTHERS         = 2
    ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    drag_drop_object->object = lo_drag_drop. " asigno el objeto como atributo del parametro recibido
  ENDMETHOD.

  METHOD handle_on_drop.

    DATA: lo_drag_drop   TYPE REF TO lcl_drag_drop_object,
          ls_layout_node TYPE lvc_s_layn.  "ES PARA AGREGARLE UN ICONO

    ls_layout_node-n_image = icon_system_favorites.

    CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.   "un modo para capturar un error de casting
      lo_drag_drop ?= drag_drop_object->object.

      go_gui_tree_acc_cat_lib->add_node(
        EXPORTING
          i_relat_node_key     = gv_fav_key
          i_relationship       = cl_gui_column_tree=>relat_last_child
          is_outtab_line       = lo_drag_drop->gs_data
          is_node_layout       = ls_layout_node
*         it_item_layout       =
          i_node_text          = lo_drag_drop->gv_node_text
*    IMPORTING
*         e_new_node_key       =
        EXCEPTIONS
          relat_node_not_found = 1
          node_not_found       = 2
          OTHERS               = 3
      ).
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

      sender->expand_node( i_node_key = gv_fav_key ).
      sender->frontend_update( ).

    ENDCATCH.

    IF sy-subrc EQ 0.
      drag_drop_object->abort( ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
