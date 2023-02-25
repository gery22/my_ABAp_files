*&---------------------------------------------------------------------*
*& Include zbi_virt_msaa217_top
*&---------------------------------------------------------------------*



TABLES: zbi_lib_logali, "Biblioteca Virtual – Libros
        zbi_cat_logali, "Biblioteca Virtual – Categorías
        zbi_cln_logali, "Biblioteca Virtual – Clientes
        zbi_a_c_logali, "Biblioteca Virtual – Relación Tipo acceso/Categorías
        zbi_c_l_logali. "Biblioteca Virtual – Relación Cliente/Libros

**********************************************************************

TYPES:
  BEGIN OF gty_paper_books,
    ddbb        TYPE abap_bool,
    field_style TYPE lvc_t_styl.         "agregamos una columna de estilo para luego manipular desde el buildcatalog
    INCLUDE STRUCTURE zbi_lib_logali.  "  basicamente agrego una coluna mas a la estr/tabla
TYPES: END OF gty_paper_books.

***************************ALV GRID*******************************************

DATA:
  ok_code             TYPE syucomm,           " variale (navegadora) para el PAI sy-ucommm es lo que el usuario "teclea"
  go_custom_container TYPE REF TO cl_gui_custom_container,  "es el container que crwamos en el layout  de screen
  go_gui_cont_header  TYPE REF TO cl_gui_container,  " sirve para hacer el header
  go_gui_cont_body    TYPE REF TO cl_gui_container, " no hay header sin body
  gt_fieldcat         TYPE lvc_t_fcat,  "tabla t predeterminada para catalogo de campos
  go_alv_paper_lib    TYPE REF TO cl_gui_alv_grid,  "clase standard referenciada para usar sus metodos de aqui sale el ALV
  gt_paper_books      TYPE TABLE OF gty_paper_books,  " tabla interna para almacenar datos
  gs_layout           TYPE lvc_s_layo,   " esttructura para layout
  gs_variant          TYPE disvariant,  " str for variant
  gt_exclude          TYPE ui_functions, " exclude toolbar  function
  gv_first_time       TYPE abap_bool.
CLASS lcl_event_alv_grid DEFINITION DEFERRED.  " porque sin esto o encuentra las clases que se definen en el include que eta luego del TOP
CLASS lcl_salv_event DEFINITION DEFERRED.
DATA: go_event_alv_grid TYPE REF TO lcl_event_alv_grid,
      go_salv_event     TYPE REF TO lcl_salv_event.


****************************Salv lists********************************

TYPES:
  BEGIN OF gty_ebooks.
    INCLUDE STRUCTURE zbi_lib_logali.
TYPES: t_color TYPE lvc_t_scol,

  END OF gty_ebooks.


DATA: go_salv_table TYPE REF TO cl_salv_table,
      gt_ebooks     TYPE TABLE OF  gty_ebooks.

***************************ALV JERARQUICO*************************************

DATA: gt_hier_cat          TYPE TABLE OF zbi_cat_logali,
      gt_hier_lib          TYPE TABLE OF zbi_lib_logali,
      go_salv_hier_cat_lib TYPE REF TO cl_salv_hierseq_table.

CLASS lcl_event_salv_hierseq DEFINITION DEFERRED.
DATA      go_salv_event_hierseq  TYPE REF TO lcl_event_salv_hierseq.


***********************   -ALV TREE-   **************************************

DATA: go_salv_tree_cat_lib_cli TYPE REF TO cl_salv_tree,
      gt_cat_lib_cli           TYPE TABLE OF zbi_cat_lib_cli_logali,
      gt_temp_cat_lib_cli      TYPE TABLE OF zbi_cat_lib_cli_logali.


***************************ALV GUI TREE**************************************

DATA: go_gui_tree_acc_cat_lib TYPE REF TO cl_gui_alv_tree,
      gs_gui_tree_header      TYPE treev_hhdr,
      gt_gui_tree_fieldcat    TYPE lvc_t_fcat,
      gt_acc_cat_lib          TYPE TABLE OF zbi_acc_cat_lib_logali,
      gt_temp_acc_cat_lib     TYPE TABLE OF zbi_acc_cat_lib_logali,
      gv_fav_key              TYPE lvc_nkey,
      gv_fav_folder_id        TYPE i,
      gv_fav_line_id          TYPE i,
      go_line_behaviour       TYPE REF TO cl_dragdrop,
      go_fav_behaviour        TYPE REF TO cl_dragdrop.

CLASS lcl_gui_tree_events DEFINITION DEFERRED.

DATA: go_gui_tree_events TYPE REF TO lcl_gui_tree_events.
