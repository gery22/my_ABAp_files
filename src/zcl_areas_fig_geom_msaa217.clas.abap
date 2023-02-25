class ZCL_AREAS_FIG_GEOM_MSAA217 definition
  public
  final
  create public .

public section.
protected section.
private section.

  methods PERIMETRO_RECTANGULO
    importing
      !BASE type I
      !ALTURA type I
    returning
      value(PERIMETRO) type I .
ENDCLASS.



CLASS ZCL_AREAS_FIG_GEOM_MSAA217 IMPLEMENTATION.


  method PERIMETRO_RECTANGULO.

    perimetro = ( base + altura ) * 2.
  endmethod.
ENDCLASS.
