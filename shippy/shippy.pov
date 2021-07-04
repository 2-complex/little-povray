
#declare background_color = BACKGROUND_COLOR;
#declare shape_on = SHAPE_ON;

// #declare background_color = <1,0,0>;
// #declare shape_on = 1;



global_settings {
  ambient_light rgb 1.5*<1, 1, 1>
  max_trace_level 10
}

camera {
	angle 8
	location z*5
	look_at <0,0,0>
	right x
	up y
}


union {

//
light_source {
	<5,0,2>
    color rgb <1,0.4,0>
}

#if(shape_on)
// Engine
cone {
	<0,0,0>, 1
	<0,0,1.4>, 0

	scale 0.1
	rotate 90*y
	translate 0.1*x

	pigment{ color rgb 8*<1,0.5,0> }
}

// Windhsield
sphere {
	<0,0,0> 0.2

	scale 0.25
	scale 3*x + 0.6*z

	finish {phong .4}
	pigment{color rgb 1.1*<1,0,1>}
	translate 1.05 * z + -0.1*x
}

// Body
difference {
	sphere {
		<0,0,0> 0.2

		scale 0.5
		scale x*3 + 0.5*z
	}

	plane {
		-x 0
		translate 0.1*x
	}

	finish {phong .4}
	pigment{color rgb 1.1*<1,1,1>}
	translate 1.0 * z
}

// Wings
difference {
	sphere {
		<0,0,0> 0.2

		scale 0.5
		scale x*3 + 0.5*z + 2.5*y
	}

	plane {
		-x 0
		translate -0.1*x
	}

	translate 0.17*x

	finish {phong .4}
	pigment{color rgb 1.1*<1,1,1>}
	translate 1.0 * z
}

#end
	translate 0.05 * x + 0.1 * z
	rotate - clock * 360 * z
}



plane {
	z 0

	texture {
		pigment {color rgb background_color}
	}

	translate -6
}

#declare R1 = seed(34567);
#declare splend = 250;

#declare cnt = 0;
#while ( cnt < splend )
  #declare k = 4*(rand(R1)-0.5);
  #declare l = 3*(rand(R1)-0.5);
  light_source {
    <4, 4, 10> + k * <1, -1, 0> + l * <1, 1, 0>
    color rgb 1.1*<1,1,1> / splend
  }
  #declare cnt = cnt +1;
#end

