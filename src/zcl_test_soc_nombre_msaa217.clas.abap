class ZCL_TEST_SOC_NOMBRE_MSAA217 definition
  public
  final
  create public
  for testing
  duration short
  risk level harmless .

public section.

  methods COMPROBAR_VUELO FOR TESTING.
protected section.
private section.
ENDCLASS.



CLASS ZCL_TEST_SOC_NOMBRE_MSAA217 IMPLEMENTATION.


  method COMPROBAR_VUELO.

    data: lr_vuelo TYPE REF TO lcl_vuelo,
          lv_resultado TYPE s_carr_id.

    CREATE OBJECT lr_vuelo.

    lr_vuelo->obtener_aerolinea(
      EXPORTING
        connid1 = '0788'
      IMPORTING
        carrid1 = lv_resultado ).

    cl_aunit_assert=>assert_char_cp(
      EXPORTING
        act              =      'AZ'                               " Actual Object
        exp              =       lv_resultado                              " Expected Template
        msg              =      'Nombre equivocado' ).                              " Message in Case of Error
*        level            = if_aunit_constants=>severity-medium " Error Severity
*        quit             = if_aunit_constants=>quit-test       " Flow Control in Case of Error
*      RECEIVING
*        assertion_failed =                                     " Condition not met


  endmethod.
ENDCLASS.
