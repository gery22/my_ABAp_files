*&---------------------------------------------------------------------*
*& Report z23_sel_package_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z23_sel_package_msaa217.


DATA: gt_flights TYPE SORTED TABLE OF zscarr_msaa217
                 WITH NON-UNIQUE KEY carrid carrname,
      gwa_flight TYPE zscarr_msaa217.

SELECT * FROM zscarr_msaa217 INTO TABLE gt_flights PACKAGE SIZE 2.

  LOOP AT gt_flights INTO gwa_flight.

    WRITE: / gwa_flight-carrid, gwa_flight-carrname.

  ENDLOOP.
  SKIP 1.
ENDSELECT.
