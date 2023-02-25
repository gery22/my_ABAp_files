*&---------------------------------------------------------------------*
*& Include z_alv_mf_msaa217_top
*&---------------------------------------------------------------------*


TYPE-POOLS slis.   "hay q incluirlo siempre aunque en las versiones nuevas o es neceasario

TABLES : spfli,
         sflight.

TYPES: BEGIN OF gty_flights,
         carrid   TYPE s_carr_id,
         connid   TYPE s_conn_id,
         price    TYPE s_price,
         currency TYPE s_currcode,
         seatsmax TYPE s_seatsmax,
         seatsocc TYPE s_seatsocc,
       END OF gty_flights.

DATA: gt_flights  TYPE TABLE OF gty_flights,       "Tabla interna
      gt_fieldcat TYPE slis_t_fieldcat_alv,        " tabla del tipo slis, catalogo de campos
      gs_layout   TYPE slis_layout_alv,            " estructura para el layout
      gt_events   TYPE slis_t_event,               "tabla interna Para eventoS list top_of_page
      gt_header   TYPE TABLE OF spfli,             "las tablas son Para el alv jerarquico
      gt_items    TYPE TABLE OF sflight.
