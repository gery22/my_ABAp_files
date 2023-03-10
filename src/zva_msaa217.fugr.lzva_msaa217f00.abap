*---------------------------------------------------------------------*
*    view related FORM routines
*---------------------------------------------------------------------*
*...processing: ZVA_MSAA217.....................................*
FORM GET_DATA_ZVA_MSAA217.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM MSEG WHERE
(VIM_WHERETAB) .
    CLEAR ZVA_MSAA217 .
ZVA_MSAA217-MANDT =
MSEG-MANDT .
ZVA_MSAA217-MBLNR =
MSEG-MBLNR .
ZVA_MSAA217-MJAHR =
MSEG-MJAHR .
ZVA_MSAA217-ZEILE =
MSEG-ZEILE .
    SELECT SINGLE * FROM KNA1 WHERE
KUNNR = MSEG-KUNNR .
    IF SY-SUBRC EQ 0.
ZVA_MSAA217-NAME1 =
KNA1-NAME1 .
ZVA_MSAA217-NAME2 =
KNA1-NAME2 .
ZVA_MSAA217-ORT01 =
KNA1-ORT01 .
ZVA_MSAA217-PSTL2 =
KNA1-PSTL2 .
    ENDIF.
<VIM_TOTAL_STRUC> = ZVA_MSAA217.
    APPEND TOTAL.
  ENDSELECT.
  SORT TOTAL BY <VIM_XTOTAL_KEY>.
  <STATUS>-ALR_SORTED = 'R'.
*.check dynamic selectoptions (not in DDIC)...........................*
  IF X_HEADER-SELECTION NE SPACE.
    PERFORM CHECK_DYNAMIC_SELECT_OPTIONS.
  ELSEIF X_HEADER-DELMDTFLAG NE SPACE.
    PERFORM BUILD_MAINKEY_TAB.
  ENDIF.
  REFRESH EXTRACT.
ENDFORM.
*---------------------------------------------------------------------*
FORM DB_UPD_ZVA_MSAA217 .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO ZVA_MSAA217.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_ZVA_MSAA217-ST_DELETE EQ GELOESCHT.
     READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
     IF SY-SUBRC EQ 0.
       DELETE EXTRACT INDEX SY-TABIX.
     ENDIF.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN GELOESCHT.
  SELECT SINGLE FOR UPDATE * FROM MSEG WHERE
  MBLNR = ZVA_MSAA217-MBLNR AND
  MJAHR = ZVA_MSAA217-MJAHR AND
  ZEILE = ZVA_MSAA217-ZEILE .
    IF SY-SUBRC = 0.
    DELETE MSEG .
    ENDIF.
    IF STATUS-DELETE EQ GELOESCHT.
      READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY> BINARY SEARCH.
      DELETE EXTRACT INDEX SY-TABIX.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN OTHERS.
  SELECT SINGLE FOR UPDATE * FROM MSEG WHERE
  MBLNR = ZVA_MSAA217-MBLNR AND
  MJAHR = ZVA_MSAA217-MJAHR AND
  ZEILE = ZVA_MSAA217-ZEILE .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR MSEG.
    ENDIF.
MSEG-MANDT =
ZVA_MSAA217-MANDT .
MSEG-MBLNR =
ZVA_MSAA217-MBLNR .
MSEG-MJAHR =
ZVA_MSAA217-MJAHR .
MSEG-ZEILE =
ZVA_MSAA217-ZEILE .
    IF SY-SUBRC = 0.
    UPDATE MSEG ##WARN_OK.
    ELSE.
    INSERT MSEG .
    ENDIF.
    READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
    IF SY-SUBRC EQ 0.
      <XACT> = ORIGINAL.
      MODIFY EXTRACT INDEX SY-TABIX.
    ENDIF.
    <ACTION> = ORIGINAL.
    MODIFY TOTAL.
  ENDCASE.
ENDLOOP.
CLEAR: STATUS_ZVA_MSAA217-UPD_FLAG,
STATUS_ZVA_MSAA217-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_ZVA_MSAA217.
  SELECT SINGLE * FROM MSEG WHERE
MBLNR = ZVA_MSAA217-MBLNR AND
MJAHR = ZVA_MSAA217-MJAHR AND
ZEILE = ZVA_MSAA217-ZEILE .
ZVA_MSAA217-MANDT =
MSEG-MANDT .
ZVA_MSAA217-MBLNR =
MSEG-MBLNR .
ZVA_MSAA217-MJAHR =
MSEG-MJAHR .
ZVA_MSAA217-ZEILE =
MSEG-ZEILE .
    SELECT SINGLE * FROM KNA1 WHERE
KUNNR = MSEG-KUNNR .
    IF SY-SUBRC EQ 0.
ZVA_MSAA217-NAME1 =
KNA1-NAME1 .
ZVA_MSAA217-NAME2 =
KNA1-NAME2 .
ZVA_MSAA217-ORT01 =
KNA1-ORT01 .
ZVA_MSAA217-PSTL2 =
KNA1-PSTL2 .
    ELSE.
      CLEAR SY-SUBRC.
      CLEAR ZVA_MSAA217-NAME1 .
      CLEAR ZVA_MSAA217-NAME2 .
      CLEAR ZVA_MSAA217-ORT01 .
      CLEAR ZVA_MSAA217-PSTL2 .
    ENDIF.
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_ZVA_MSAA217 USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE ZVA_MSAA217-MBLNR TO
MSEG-MBLNR .
MOVE ZVA_MSAA217-MJAHR TO
MSEG-MJAHR .
MOVE ZVA_MSAA217-ZEILE TO
MSEG-ZEILE .
MOVE ZVA_MSAA217-MANDT TO
MSEG-MANDT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = 'MSEG'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN MSEG TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING 'MSEG'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*
FORM COMPL_ZVA_MSAA217 USING WORKAREA.
*      provides (read-only) fields from secondary tables related
*      to primary tables by foreignkey relationships
MSEG-MANDT =
ZVA_MSAA217-MANDT .
MSEG-MBLNR =
ZVA_MSAA217-MBLNR .
MSEG-MJAHR =
ZVA_MSAA217-MJAHR .
MSEG-ZEILE =
ZVA_MSAA217-ZEILE .
    SELECT SINGLE * FROM KNA1 WHERE
KUNNR = MSEG-KUNNR .
    IF SY-SUBRC EQ 0.
ZVA_MSAA217-NAME1 =
KNA1-NAME1 .
ZVA_MSAA217-NAME2 =
KNA1-NAME2 .
ZVA_MSAA217-ORT01 =
KNA1-ORT01 .
ZVA_MSAA217-PSTL2 =
KNA1-PSTL2 .
    ELSE.
      CLEAR SY-SUBRC.
      CLEAR ZVA_MSAA217-NAME1 .
      CLEAR ZVA_MSAA217-NAME2 .
      CLEAR ZVA_MSAA217-ORT01 .
      CLEAR ZVA_MSAA217-PSTL2 .
    ENDIF.
ENDFORM.
