*&---------------------------------------------------------------------*
*& Report z_loop_str_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_loop_str_msaa217.

types: BEGIN OF ty_campos,
       campo1 TYPE string,
       campo2 type string,
       END OF TY_CAMPOS,
       tty_campos TYPE STANDARD TABLE OF ty_campos WITH EMPTY KEY.
data lv_word type string.

data(lt_campos) = VALUE tty_campos(  ( campo1 = 'name')
                                    ( campo1 = 'email' ) ).

lv_word = '<str>'.
loop at lt_campos ASSIGNING FIELD-SYMBOL(<ls_campos>).

CONCATENATE lv_word <ls_campos>-campo1 '<p>' into lv_word.

ENDLOOP.
write lv_word.
