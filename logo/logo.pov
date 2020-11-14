#include "logo.inc"
object{  Povray_Logo pigment
{color rgb 1} translate 3*z}
light_source { <0,4,-2>color
rgb 1.3area_light 8*x,8*y,8,
8adaptive 1 jitter }plane{z,
4pigment{color rgb 1}}sphere
{0, 2 pigment{ color rgb 1 }
translate 5*z}
