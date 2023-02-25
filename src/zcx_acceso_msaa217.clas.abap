CLASS zcx_acceso_msaa217 DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .

    CONSTANTS:
      BEGIN OF zcx_acceso_msaa217,
        msgid TYPE symsgid VALUE 'ZMSJ_MSAA217',
        msgno TYPE symsgno VALUE '000',
        attr1 TYPE scx_attrname VALUE 'MSGV1',
        attr2 TYPE scx_attrname VALUE 'MSGV2',
        attr3 TYPE scx_attrname VALUE 'MSGV3',
        attr4 TYPE scx_attrname VALUE 'MSGV4',
      END OF zcx_acceso_msaa217 .
    CONSTANTS usuario_inactivo TYPE sotr_conc VALUE '000C292775F91EDCBB83602F214B0FA8' ##NO_TEXT.
    DATA msgv1 TYPE msgv1 .
    DATA msgv2 TYPE msgv2 .
    DATA msgv3 TYPE msgv3 .
    DATA msgv4 TYPE msgv4 .

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        !msgv1    TYPE msgv1 OPTIONAL
        !msgv2    TYPE msgv2 OPTIONAL
        !msgv3    TYPE msgv3 OPTIONAL
        !msgv4    TYPE msgv4 OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCX_ACCESO_MSAA217 IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    me->msgv1 = msgv1 .
    me->msgv2 = msgv2 .
    me->msgv3 = msgv3 .
    me->msgv4 = msgv4 .
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = zcx_acceso_msaa217 .
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
