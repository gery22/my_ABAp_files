*&---------------------------------------------------------------------*
*& 1.3. Insertar registros en tablas SORTED y HASHED
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_sorthash_msaa217.

DATA: gt_sorted TYPE SORTED TABLE OF snwd_employees WITH UNIQUE KEY employee_id,
      gt_hashed TYPE HASHED TABLE OF snwd_employees WITH UNIQUE KEY employee_id.


DATA(gwa_snwd_employees) = VALUE snwd_employees( employee_id = '1234567890').

insert gwa_snwd_employees inTO table gt_sorted  .
insert gwa_snwd_employees inTO table gt_hashed  .


cl_demo_output=>write( gt_hashed ).
cl_demo_output=>display( ).
