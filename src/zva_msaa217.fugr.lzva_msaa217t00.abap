*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZVA_MSAA217.....................................*
TABLES: ZVA_MSAA217, *ZVA_MSAA217. "view work areas
CONTROLS: TCTRL_ZVA_MSAA217
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZVA_MSAA217. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVA_MSAA217.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVA_MSAA217_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVA_MSAA217.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVA_MSAA217_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVA_MSAA217_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVA_MSAA217.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVA_MSAA217_TOTAL.

*.........table declarations:.................................*
TABLES: KNA1                           .
TABLES: MSEG                           .
