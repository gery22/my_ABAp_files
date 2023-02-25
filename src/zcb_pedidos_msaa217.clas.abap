class ZCB_PEDIDOS_MSAA217 definition
  public
  inheriting from CL_OS_CA_COMMON
  abstract
  create public .

public section.

  methods CREATE_TRANSIENT
    returning
      value(RESULT) type ref to ZCL_PEDIDOS_MSAA217
    raising
      CX_OS_OBJECT_EXISTING .

  methods IF_OS_FACTORY~CREATE_TRANSIENT
    redefinition .
protected section.

  types TYP_OBJECT_REF type ref to ZCL_PEDIDOS_MSAA217 .
  types:
    TYP_OBJECT_REF_TAB type standard table of
      TYP_OBJECT_REF with non-unique default key .
  types:
    begin of TYP_SPECIAL_OBJECT_INFO ,
      OBJECT_ID type TYP_INTERNAL_OID ,
      ID_STATUS type TYP_ID_STATUS ,
    end of TYP_SPECIAL_OBJECT_INFO .
  types:
    TYP_SPECIAL_OBJECT_INFO_TAB type sorted table of
      TYP_SPECIAL_OBJECT_INFO with unique key
      OBJECT_ID .
  types:
    TYP_DB_DELETE_TAB type standard table of
      TYP_SPECIAL_OBJECT_INFO with non-unique default key .

  data CURRENT_SPECIAL_OBJECT_INFO type TYP_SPECIAL_OBJECT_INFO .
  data SPECIAL_OBJECT_INFO type TYP_SPECIAL_OBJECT_INFO_TAB .

  methods PM_CREATE_REPRESENTANT
    returning
      value(RESULT) type TYP_OBJECT_REF .

  methods LOAD_SPECIAL_OBJECT_INFO
    redefinition .
  methods SAVE_SPECIAL_OBJECT_INFO
    redefinition .
private section.
ENDCLASS.



CLASS ZCB_PEDIDOS_MSAA217 IMPLEMENTATION.


  method CREATE_TRANSIENT.
***BUILD 090501
*      returning RESULT type ref to ZCL_PEDIDOS_MSAA217
************************************************************************
* Purpose        : Create a new transient object
*
* Version        : 2.0
*
* Precondition   : --
*
* Postcondition  : The object exists in memory until it is RELEASEd
*
* OO Exceptions  : propagates EXT_PM_CREATED_TRANSIENT
*
* Implementation : 1. Create a new object
*                  2. Register the object as TRANSIENT and initialize it
*                  3. Clean up
*
************************************************************************
* Changelog:
* - 2000-03-06   : (BGR) Initial Version 2.0
* - 2000-07-28   : (SB)  OO Exceptions
************************************************************************

  data: THE_OBJECT   type        TYP_OBJECT_REF.

  clear CURRENT_OBJECT_IREF.

* * 1. Create a new object without OID
  THE_OBJECT = PM_CREATE_REPRESENTANT( ).

* * 2. Register the object as TRANSIENT and initialize it
  call method OS_PM_CREATED_TRANSIENT.

* * 3. Clean up
  clear CURRENT_SPECIAL_OBJECT_INFO.
  result = THE_OBJECT.

           "CREATE_TRANSIENT
  endmethod.


  method IF_OS_FACTORY~CREATE_TRANSIENT.
***BUILD 090501
  endmethod.


  method LOAD_SPECIAL_OBJECT_INFO.
***BUILD 090501
************************************************************************
* Purpose        : Load CURRENT_SPECIAL_OBJECT_INFO from
*                  SPECIAL_OBJECT_INFO
*
* Version        : 2.0
*
* Precondition   : Index is set in CURRENT_OBJECT_INDEX
*
* Postcondition  : entry is loaded
*
* OO Exceptions  : -
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-02   : (BGR) Initial Version
************************************************************************

  read table SPECIAL_OBJECT_INFO into CURRENT_SPECIAL_OBJECT_INFO
       index CURRENT_OBJECT_INDEX.

           "LOAD_SPECIAL_OBJECT_INFO
  endmethod.


  method PM_CREATE_REPRESENTANT.
***BUILD 090501
     " returning result         type TYP_OBJECT_REF
************************************************************************
* Purpose        : Create a new representative object including a new
*                  entry in administrative data (OBJECT_INFO and
*                  SPECIAL_OBJECT_INFO)
*
* Version        : 2.0
*
* Precondition   : --
*
* Postcondition  : A new object exists, corresponding entries in
*                  OBJECT_INFO and SPECIAL_OBJECT_INFO have been
*                  inserted, CURRENT is set
*
* OO Exceptions  : --
*
* Implementation : 1. Create object
*                  2. Get internal OID for the new object
*                  3. Create new entry in SPECIAL_OBJECT_INFO
*                  4. Let super class create a new entry in OBJECT_INFO
*
************************************************************************
* Changelog:
* - 2000-03-07   : (BGR) Initial Version 2.0
************************************************************************

  data: NEW_OBJECT type ref to ZCL_PEDIDOS_MSAA217.

* * 1. Create object
  create object NEW_OBJECT.

* * 2. Get internal OID for the new object and set CURRENT_SPECIAL_OI
  clear CURRENT_SPECIAL_OBJECT_INFO.

  CURRENT_SPECIAL_OBJECT_INFO-OBJECT_ID =
      OS_GET_INTERNAL_OID_BY_REF( I_OBJECT = NEW_OBJECT ).

* * 3. Create new entry in SPECIAL_OBJECT_INFO
  insert CURRENT_SPECIAL_OBJECT_INFO into table SPECIAL_OBJECT_INFO.

* * 4. Let super class create a new entry in OBJECT_INFO
  call method OS_CREATE_NEW_ENTRY_FOR_REPR
       exporting I_OBJECT = NEW_OBJECT
                 I_INTERNAL_OID = CURRENT_SPECIAL_OBJECT_INFO-OBJECT_ID.

  result = NEW_OBJECT.

           "PM_CREATE_REPRESENTANT
  endmethod.


  method SAVE_SPECIAL_OBJECT_INFO.
***BUILD 090501
************************************************************************
* Purpose        : Save CURRENT_SPECIAL_OBJECT_INFO into
*                  SPECIAL_OBJECT_INFO
*
* Version        : 2.0
*
* Precondition   : Index is set in CURRENT_OBJECT_INDEX
*
* Postcondition  : entry is saved
*
* OO Exceptions  : -
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 2000-03-02   : (BGR) Initial Version
************************************************************************

  modify SPECIAL_OBJECT_INFO from CURRENT_SPECIAL_OBJECT_INFO
         index CURRENT_OBJECT_INDEX.

           "SAVE_SPECIAL_OBJECT_INFO
  endmethod.
ENDCLASS.
