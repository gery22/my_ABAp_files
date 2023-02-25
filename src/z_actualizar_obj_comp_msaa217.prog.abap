*&---------------------------------------------------------------------*
*& Report z_actualizar_obj_comp_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_actualizar_obj_comp_msaa217.

DATA: gr_handle_area    TYPE REF TO zcl_cesta_comp_area_msaa217,
      gr_cesta_compras  TYPE REF TO zcl_cesta_compras_msaa217,
      gt_cesta          TYPE me_ekpo,
      gs_insertar_cesta TYPE ekpo. "estructura para insertar valor en tabla

TRY.

    gr_handle_area = zcl_cesta_comp_area_msaa217=>attach_for_update(
*                   client      =
*                   inst_name   = cl_shm_area=>default_instance
*                   attach_mode = cl_shm_area=>attach_mode_default
*                   wait_time   = 0
                     ).
  CATCH cx_shm_inconsistent.
  CATCH cx_shm_no_active_version.
  CATCH cx_shm_exclusive_lock_active.
  CATCH cx_shm_version_limit_exceeded.
  CATCH cx_shm_change_lock_active.
  CATCH cx_shm_parameter_error.
  CATCH cx_shm_pending_lock_removed.
ENDTRY.

gs_insertar_cesta-matnr = 'TheWorldIsMine'.
gs_insertar_cesta-abdat = sy-datum.
gs_insertar_cesta-mandt = '247'.


APPEND gs_insertar_cesta TO gt_cesta.


gr_handle_area->root->set_doc_compras( doc_compras = gt_cesta ).
WRITE 'objeto en memoria compartida'.


TRY.
    gr_handle_area->detach_commit( ).
  CATCH cx_shm_wrong_handle.
  CATCH cx_shm_already_detached.

ENDTRY.
