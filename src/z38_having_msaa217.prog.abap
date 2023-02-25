*&---------------------------------------------------------------------*
*& Report z38_having_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z38_having_msaa217.

types: BEGIN OF gt_table,
       carrid type s_carr_id,
       cityfrom type s_from_cit,
       count type i,
       end of gt_table.


data gt_table TYPE TABLE of gt_table.


select carrid cityfrom count( * ) from zspfli_msaa217
into table gt_table
GROUP BY carrid cityfrom having cityfrom eq 'FRANKFURT'
order by carrid DESCENDING.  "Lo ordeno descending para que haya algun cambio visible, ya que originalmente esta ASC

if sy-subrc eq 0.

cl_demo_output=>display( gt_table ).

endif.
