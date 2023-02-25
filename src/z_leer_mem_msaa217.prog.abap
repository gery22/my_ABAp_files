*&---------------------------------------------------------------------*
*& Report z_leer_mem_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_leer_mem_msaa217.



DATA: gr_handle_area    TYPE REF TO zcl_cesta_comp_area_msaa217,
      gr_cesta_compras  TYPE REF TO zcl_cesta_compras_msaa217,
      gt_cesta          TYPE me_ekpo,
      gs_insertar_cesta TYPE ekpo. "estructura para insertar valor en tabla

TRY.

    gr_handle_area = zcl_cesta_comp_area_msaa217=>attach_for_read(
*                   client    =
*                   inst_name = cl_shm_area=>default_instance
                     ).
  CATCH cx_shm_inconsistent.
  CATCH cx_shm_no_active_version.
  CATCH cx_shm_read_lock_active.
  CATCH cx_shm_exclusive_lock_active.
  CATCH cx_shm_parameter_error.
  CATCH cx_shm_change_lock_active.
ENDTRY.

gr_handle_area->root->get_doc_compras(
  IMPORTING
    doc_compras = gt_cesta
).

TRY.
    gr_handle_area->detach( ).
  CATCH cx_shm_wrong_handle.
  CATCH cx_shm_already_detached.

ENDTRY.



LOOP AT gt_cesta INTO gs_insertar_cesta.

  WRITE gs_insertar_cesta-mandt.

endloop.
