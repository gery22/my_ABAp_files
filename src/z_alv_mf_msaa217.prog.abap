*&---------------------------------------------------------------------*
*& Report z_alv_mf_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_alv_mf_msaa217.

INCLUDE: z_alv_mf_msaa217_top,
         z_alv_mf_msaa217_sel,
         z_alv_mf_msaa217_f01.

START-OF-SELECTION.
  PERFORM:  get_data,
            build_field_cat,
            build_layout,
            add_events.

  CASE abap_true.

    WHEN p_list.
      PERFORM display_alv_list.

    WHEN p_grid.
      PERFORM display_alv_grid.

    WHEN p_hier.
      PERFORM display_alv_hier.

  ENDCASE.
