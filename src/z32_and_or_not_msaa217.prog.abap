*&---------------------------------------------------------------------*
*& Report z32_and_or_not_msaa217
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z32_and_or_not_msaa217.

data gt_table type table of zspfli_msaa217.

select * from zspfli_msaa217
into table gt_table
WHERE carrid eq 'JL'
or carrid eq 'LH'
and connid between '200' and '500'
AND cityfrom in ( 'TOKIO', 'FRANKFURT', 'NEW YORK' )
AND DEPTIME BETWEEN '100000' AND '190000'.


if sy-subrc eq 0.

cl_demo_output=>display( gt_table ).
endif.
