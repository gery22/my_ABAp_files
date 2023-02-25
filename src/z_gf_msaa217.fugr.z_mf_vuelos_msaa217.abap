FUNCTION z_mf_vuelos_msaa217.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  S_CARRID
*"     REFERENCE(IV_LIST) TYPE  FLAG OPTIONAL
*"  TABLES
*"      ET_FLIGHTS STRUCTURE  SFLIGHT
*"  EXCEPTIONS
*"      EX_VUELOS
*"----------------------------------------------------------------------
  DATA ls_flights TYPE sflight.

  SELECT * FROM sflight
    INTO  TABLE et_flights
WHERE carrid = iv_carrid.

  IF sy-subrc EQ 0 AND iv_list EQ abap_true.

    LOOP AT et_flights INTO ls_flights.
      WRITE: / ls_flights-carrid,
               ls_flights-connid,
               ls_flights-fldate,
               ls_flights-price,
               ls_flights-currency.
    ENDLOOP.
  ELSEIF sy-subrc NE 0.
    RAISE ex_vuelos.
  ENDIF.


ENDFUNCTION.
