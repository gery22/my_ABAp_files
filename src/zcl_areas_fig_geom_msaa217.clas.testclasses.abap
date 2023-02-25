*"* use this source file for your ABAP unit test classes
CLASS zcl_test_perimetro_msaa217 DEFINITION DEFERRED.
CLASS zcl_areas_fig_geom_msaa217 DEFINITION LOCAL FRIENDS zcl_test_perimetro_msaa217.

CLASS zcl_test_perimetro_msaa217 DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
.
*?﻿<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0">
*?<asx:values>
*?<TESTCLASS_OPTIONS>
*?<TEST_CLASS>zcl_Test_Perimetro_Msaa217
*?</TEST_CLASS>
*?<TEST_MEMBER>f_Cut
*?</TEST_MEMBER>
*?<OBJECT_UNDER_TEST>ZCL_AREAS_FIG_GEOM_MSAA217
*?</OBJECT_UNDER_TEST>
*?<OBJECT_IS_LOCAL/>
*?<GENERATE_FIXTURE>X
*?</GENERATE_FIXTURE>
*?<GENERATE_CLASS_FIXTURE>X
*?</GENERATE_CLASS_FIXTURE>
*?<GENERATE_INVOCATION>X
*?</GENERATE_INVOCATION>
*?<GENERATE_ASSERT_EQUAL>X
*?</GENERATE_ASSERT_EQUAL>
*?</TESTCLASS_OPTIONS>
*?</asx:values>
*?</asx:abap>
  PRIVATE SECTION.
    DATA:
      f_cut TYPE REF TO zcl_areas_fig_geom_msaa217.  "class under test

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: perimetro_rectangulo FOR TESTING.
ENDCLASS.       "zcl_Test_Perimetro_Msaa217


CLASS zcl_test_perimetro_msaa217 IMPLEMENTATION.

  METHOD class_setup.



  ENDMETHOD.


  METHOD class_teardown.



  ENDMETHOD.


  METHOD setup.


    CREATE OBJECT f_cut.
  ENDMETHOD.


  METHOD teardown.



  ENDMETHOD.


  METHOD perimetro_rectangulo.

    DATA base TYPE i.
    DATA altura TYPE i.
    DATA perimetro TYPE i.
    base = 5.
    altura = 10.
    perimetro = f_cut->perimetro_rectangulo(
        base = base
        altura = altura ).

    cl_abap_unit_assert=>assert_equals(
      act   = perimetro
      exp   = 30          "<--- please adapt expected value
      msg   = 'Error en el perimetro'
*     level =
    ).
  ENDMETHOD.




ENDCLASS.
