*&---------------------------------------------------------------------*
*& Include z_alv_mf_msaa217_sel
*&---------------------------------------------------------------------*

*********Block 1
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
select-OPTIONS: so_carr for spfli-carrid. "Airline Code
SELECTION-SCREEN END OF BLOCK b1.

*********Block 2
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
PARAMETERS: p_list RADIOBUTTON GROUP alv, "ALV List
p_grid RADIOBUTTON GROUP alv, "ALV Grid
p_hier RADIOBUTTON GROUP alv. "ALV Hierarchical


SELECTION-SCREEN END OF BLOCK b2.
