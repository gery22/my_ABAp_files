*&---------------------------------------------------------------------*
*& Report z_del_persis_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_del_persis_msaa217.

*&---------------------------------------------------------------------*
*& 5. Eliminar datos con objetos de persistencia
*&---------------------------------------------------------------------*

DATA: gr_actor   TYPE REF TO   zca_pedidos1_msaa217,
      gr_pedidos TYPE REF TO zcl_pedidos1_msaa217,
      grx_except TYPE REF TO cx_root.

*obtener instanca clase actor
gr_actor = zca_pedidos1_msaa217=>agent.

TRY.


    gr_actor->delete_persistent( i_vbeln = 'Fabio' ).

    WRITE /'Se ha eliminado el registro'.

  CATCH cx_os_object_not_existing INTO grx_except.
    WRITE grx_except->get_text( ).
ENDTRY.

COMMIT WORK.
