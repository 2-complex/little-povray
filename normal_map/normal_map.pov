
global_settings {
  ambient_light rgb 1.5*<1, 1, 1>
  max_trace_level 10
}

camera {
	angle 25
	location 1.2*<0,0,10>
	look_at <0,0,0>
	right 1*x
	up y
}

light_source {
	100*<0,1,1>
	color rgb <1,0,0>
}

light_source {
	100*<1,0,1>
	color rgb <0,0,1>
}

plane {
	z, -1
	texture {normal{ granite 0.2 scale 0.8 } pigment {color rgb 1}}
}

