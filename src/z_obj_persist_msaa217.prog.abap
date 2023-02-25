*&---------------------------------------------------------------------*
*& Report z_obj_persist_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_obj_persist_msaa217.

*&---------------------------------------------------------------------*
*& 3. Crear persistencia con objetos de persistencia
*&---------------------------------------------------------------------*

DATA: gr_actor       TYPE REF TO   zca_pedidos1_msaa217,
      gr_pedidos     TYPE REF TO zcl_pedidos1_msaa217,
      grx_except     TYPE REF TO cx_root,
      gr_pedidos_get TYPE REF TO zcl_pedidos1_msaa217.

* Obtener instancia de la clase actor creado con constructr estatico
gr_actor = zca_pedidos1_msaa217=>agent.


TRY.

*una vez creado el agente, dentro de el se encuentra el metodo para crear objeto persistente, lo asignamosa nuestra ref

    gr_pedidos = gr_actor->create_persistent( i_vbeln = 'Fabio'  ).
    gr_pedidos->set_erdat( i_erdat = sy-datum ).
    gr_pedidos->set_ernam( i_ernam = sy-uname ).
    gr_pedidos->set_uzeit( i_uzeit = sy-timlo ).


CATCH cx_os_object_existing into grx_except.

WRITE / grx_except->get_text( ).

ENDTRY.
COMMIT WORK.

*&---------------------------------------------------------------------*
*& 4. Obtener datos con objetos de persistencia
*&---------------------------------------------------------------------*

try.
gr_pedidos_get = gr_actor->get_persistent( i_vbeln = 'Fabio1' ).
write:  / gr_pedidos_get->get_vbeln( ),
        / gr_pedidos_get->get_erdat( ),
        / gr_pedidos_get->get_ernam( ),
        / gr_pedidos_get->get_uzeit( ).

CATCH cx_os_object_not_found into grx_except.
write grx_except->get_text( ).

ENDTRY.
