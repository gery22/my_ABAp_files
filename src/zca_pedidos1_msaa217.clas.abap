class ZCA_PEDIDOS1_MSAA217 definition
  public
  inheriting from ZCB_PEDIDOS1_MSAA217
  final
  create private .

public section.

  class-data AGENT type ref to ZCA_PEDIDOS1_MSAA217 read-only .

  class-methods CLASS_CONSTRUCTOR .
protected section.
private section.
ENDCLASS.



CLASS ZCA_PEDIDOS1_MSAA217 IMPLEMENTATION.


  method CLASS_CONSTRUCTOR.
***BUILD 090501
************************************************************************
* Purpose        : Initialize the 'class'.
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : Singleton is created.
*
* OO Exceptions  : -
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 1999-09-20   : (OS) Initial Version
* - 2000-03-06   : (BGR) 2.0 modified REGISTER_CLASS_AGENT
************************************************************************
* GENERATED: Do not modify
************************************************************************

  create object AGENT.

  call method AGENT->REGISTER_CLASS_AGENT
    exporting
      I_CLASS_NAME          = 'ZCL_PEDIDOS1_MSAA217'
      I_CLASS_AGENT_NAME    = 'ZCA_PEDIDOS1_MSAA217'
      I_CLASS_GUID          = '000C292775F91EECBB97E0F6662369D7'
      I_CLASS_AGENT_GUID    = '000C292775F91EECBB97E116892DC9D7'
      I_AGENT               = AGENT
      I_STORAGE_LOCATION    = ''
      I_CLASS_AGENT_VERSION = '2.0'.

           "CLASS_CONSTRUCTOR
  endmethod.
ENDCLASS.
