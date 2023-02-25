*&---------------------------------------------------------------------*
*& Report za22_01_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT za22_01_msaa217.

"declare structure (array)
DATA gs_products TYPE zprod_jhp.

"declare internal table

DATA gt_products TYPE TABLE OF zprod_jhp.



SELECTION-SCREEN BEGIN OF BLOCK block1 WITH FRAME TITLE TEXT-001.

  SELECTION-SCREEN SKIP.

  SELECT-OPTIONS so_matnr FOR gs_products-matnr .

SELECTION-SCREEN END OF BLOCK block1.



SELECTION-SCREEN BEGIN OF BLOCK block2 WITH FRAME TITLE TEXT-002.

SELECTION-SCREEN END OF BLOCK block2.



SELECTION-SCREEN BEGIN OF BLOCK block3 WITH FRAME TITLE TEXT-003.

  PARAMETERS:
    pa_mat  TYPE matnr,
    pa_desc TYPE c  LENGTH 80.

SELECTION-SCREEN END OF BLOCK block3.

SELECTION-SCREEN SKIP.

SELECTION-SCREEN BEGIN OF BLOCK block4 WITH FRAME TITLE TEXT-004.

  PARAMETERS:
    pa_ins RADIOBUTTON GROUP prd,
    pa_mod RADIOBUTTON GROUP prd,
    pa_del RADIOBUTTON GROUP prd,
    pa_rea RADIOBUTTON GROUP prd.
SELECTION-SCREEN END OF BLOCK block4.


SELECTION-SCREEN SKIP 2.
PARAMETERS:
  pa_1 TYPE c AS CHECKBOX,
  pa_2 TYPE c AS CHECKBOX,
  pa_3 TYPE c AS CHECKBOX DEFAULT 'x',
  pa_4 TYPE c AS CHECKBOX.

START-OF-SELECTION.

  gs_products-matnr = pa_mat.
  gs_products-descr = pa_desc.
  gs_products-cre_date = sy-datum.

  CASE abap_true.

    WHEN pa_ins.

      INSERT zprod_jhp FROM gs_products.

    WHEN pa_mod.

      UPDATE zprod_jhp SET descr = pa_desc
      WHERE matnr EQ pa_mat.


    WHEN pa_del.

      DELETE FROM zprod_jhp
      WHERE matnr EQ pa_mat.



    WHEN pa_rea.

      SELECT FROM zprod_jhp
      FIELDS *
      INTO TABLE @gt_products.

  ENDCASE.

  LOOP AT gt_products INTO gs_products.

    WRITE / gs_products.
  ENDLOOP.
