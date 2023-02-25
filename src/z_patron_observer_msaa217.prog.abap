*&---------------------------------------------------------------------*
*& Report z_patron_observer_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_patron_observer_msaa217.

class lcl_blog definition.

PUBLIC SECTION.

METHODS establecer_entrada importing entrada type string.
EVENTS entrada_nueva EXPORTING value(nueva_entrada) type string.

PRIVATE SECTION.

data entrada_actual TYPE string.

ENDCLASS.

CLASS lcl_blog IMPLEMENTATION.

  METHOD establecer_entrada.
me->entrada_actual = entrada.
skip 2.
write: 'Nueva entrada en el blog:', entrada_actual.
RAISE EVENT entrada_nueva EXPORTING nueva_entrada = me->entrada_actual.
  ENDMETHOD.

ENDCLASS.



class lcl_observador definition ABSTRACT.
PUBLIC SECTION.

METHODS on_entrada_nueva ABSTRACT
        FOR EVENT entrada_nueva of lcl_blog
        importing nueva_entrada.
ENDCLASS.



class lcl_administrador definition INHERITING FROM lcl_observador.

PUBLIC SECTION.
METHODS on_entrada_nueva REDEFINITION.

ENDCLASS.

CLASS lcl_administrador IMPLEMENTATION.

  METHOD on_entrada_nueva.
WRITE: / 'Administrador Notificado de la entrada:', nueva_entrada.
  ENDMETHOD.

ENDCLASS.

class lcl_usuario definition INHERITING FROM lcl_observador.

PUBLIC SECTION.
METHODS on_entrada_nueva REDEFINITION.

ENDCLASS.

CLASS lcl_usuario IMPLEMENTATION.

  METHOD on_entrada_nueva.
WRITE: / 'Administrador Notificado de la entrada:', nueva_entrada.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

data: gr_blog TYPE REF TO lcl_blog,
      gr_admin TYPE REF TO lcl_administrador,
      gr_user TYPE REF TO lcl_usuario.

* instanciar objetos
CREATE OBJECT : gr_blog, gr_admin, gr_user.

* definir handler


set HANDLER: gr_admin->on_entrada_nueva for gr_blog,
             gr_user->on_entrada_nueva for gr_blog.

* crear entrada de blog

gr_blog->establecer_entrada( entrada = 'Hablemos de Abap' ).
