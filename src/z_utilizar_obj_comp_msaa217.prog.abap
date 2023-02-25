*&---------------------------------------------------------------------*
*& Report z_utilizar_obj_comp_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_utilizar_obj_comp_msaa217.

DATA: gr_handle_area    TYPE REF TO zcl_cesta_comp_area_msaa217,
      gr_cesta_compras  TYPE REF TO zcl_cesta_compras_msaa217,
      gt_cesta          TYPE me_ekpo,
      gs_insertar_cesta TYPE ekpo. "estructura para insertar valor en tabla

gs_insertar_cesta-matnr = '13213131'.
gs_insertar_cesta-abdat = sy-datum.
gs_insertar_cesta-mandt = '300'.


APPEND gs_insertar_cesta TO gt_cesta.

TRY.

    gr_handle_area = zcl_cesta_comp_area_msaa217=>attach_for_write(
*        EXPORTING
*          client      =
*          inst_name   = cl_shm_area=>default_instance
*          attach_mode = cl_shm_area=>attach_mode_default
*          wait_time   = 0
*        RECEIVING
*          handle      =
          ).
  CATCH cx_shm_exclusive_lock_active.
  CATCH cx_shm_version_limit_exceeded.
  CATCH cx_shm_change_lock_active.
  CATCH cx_shm_parameter_error.
  CATCH cx_shm_pending_lock_removed.

ENDTRY.

CREATE OBJECT gr_cesta_compras AREA HANDLE gr_handle_area.


gr_cesta_compras->set_doc_compras( doc_compras = gt_cesta ).

TRY.

    gr_handle_area->set_root( root = gr_cesta_compras ).

  CATCH cx_shm_initial_reference.
  CATCH cx_shm_wrong_handle.

ENDTRY.

TRY.

    gr_handle_area->detach_commit( ).
  CATCH cx_shm_wrong_handle.
  CATCH cx_shm_already_detached.
  CATCH cx_shm_secondary_commit.
  CATCH cx_shm_event_execution_failed.
  CATCH cx_shm_completion_error.

ENDTRY.

WRITE 'objeto en memoria compartida'.
