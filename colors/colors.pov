
global_settings {
  ambient_light rgb 1.5*<1, 1, 1>
  max_trace_level 10
}

camera {
	angle 25
	location 1.2*<0,-10,6>
	look_at <0,-1.2,0>
	right 16/9*x
	up y
}

light_source {
	<-5,3,9>
	color rgb <1,1,1>
	fade_distance 10
	fade_power 2
	
	area_light 8*x,8*y,8,8
	adaptive 1 jitter	
}

box {
	<-10,-10,-10>, <10,10,-1>
	pigment {color rgb 1}
	finish {phong .2}
}

union {
	#local n = 7;
	#local i = 0;
	#while(i < n)
	superellipsoid {
		<.2, .2>
		#local theta = i*360/n;
		scale 0.5
		translate 1.6*x - 0.5*z
		rotate theta*z
		pigment{color rgb 0.9*vnormalize(1.2*vaxis_rotate(x+y, <1,1,1>, theta))}
		finish {specular 0.1 phong .2 phong_size 12 metallic 1 reflection{0.9 metallic 0.9}}
	}
	#local i = i+1;
	#end

	
}