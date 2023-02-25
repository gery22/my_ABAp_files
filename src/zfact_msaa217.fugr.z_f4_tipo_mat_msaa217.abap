FUNCTION Z_F4_TIPO_MAT_MSAA217.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  TABLES
*"      SHLP_TAB TYPE  SHLP_DESCT
*"      RECORD_TAB STRUCTURE  SEAHLPRES
*"  CHANGING
*"     REFERENCE(SHLP) TYPE  SHLP_DESCR
*"     REFERENCE(CALLCONTROL) TYPE  DDSHF4CTRL
*"----------------------------------------------------------------------

if callcontrol-step = 'DISP'.

  DELETE record_tab where string+3(4) ne 'ERSA'.

  endif.



ENDFUNCTION.
