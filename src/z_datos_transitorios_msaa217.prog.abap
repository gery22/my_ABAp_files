*&---------------------------------------------------------------------*
*& Report z_datos_transitorios_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_datos_transitorios_msaa217.

*&---------------------------------------------------------------------*
*& 6. Crear objetos transitorios
*&---------------------------------------------------------------------*

DATA: gr_actor   TYPE REF TO   zca_pedidos1_msaa217,
      gr_pedidos TYPE REF TO zcl_pedidos1_msaa217,
      grx_except TYPE REF TO cx_root.

*obtener instanca clase actor
gr_actor = zca_pedidos1_msaa217=>agent.

TRY.
    gr_pedidos = gr_actor->create_transient( i_vbeln = 'Fabio'  ).
    gr_pedidos->set_ernam( i_ernam = sy-uname ).

  CATCH cx_os_object_existing INTO  grx_except.
    WRITE grx_except->get_text( ).

ENDTRY.




TRY.
    gr_pedidos = gr_actor->get_transient( i_vbeln = 'Fabio' ).

    WRITE / gr_pedidos->get_ernam( ).


  CATCH cx_os_object_not_found INTO  grx_except.
    WRITE grx_except->get_text( ).

ENDTRY.

WRITE / 'Thanks for using my program'.
