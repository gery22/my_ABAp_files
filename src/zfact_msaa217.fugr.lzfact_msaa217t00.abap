*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZFACT_MSAA217...................................*
DATA:  BEGIN OF STATUS_ZFACT_MSAA217                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZFACT_MSAA217                 .
CONTROLS: TCTRL_ZFACT_MSAA217
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZFACT_MSAA217                 .
TABLES: ZFACT_MSAA217                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
