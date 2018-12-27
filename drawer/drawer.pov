
#include "rad_def.inc"

#declare background_color = <0.8, 0.8, 0.9>;

global_settings {
  ambient_light rgb 2.0*<1, 1, 1>
  max_trace_level 6
}

camera {
  angle 20
  right 1.0*x
  location 5*<1.0, 1.4, -1.0>
  look_at <0, 0.6, 0>
  up y
}

#declare R1 = seed(34);

#declare woodf = function {
	pattern{
		wood
		turbulence .01
		scale 0.06
	}
}

#declare woodg = function {
	pattern {
		granite
		scale 10
	}
}

#macro wood_texture()
	finish {
		phong .4
		reflection 0.01
	}
	pigment {
		function {
			.5 * woodf(x, y, z) + .5 * woodg(10*x, y, z)
		}
		//#declare c = <rand(R1)-0.2, 0, 0>/4;
		#declare c = <0.2, 0, 0>;

		color_map {
			[0.0, color <1, 1, 1> + c]
			[0.7, color <.9, .8, .3> + c]
			[0.8, color <1, .6, .3> + c]
			[1, color <1, .5, .3> + c]
		}
		rotate <20 * (rand(R1)-.5), 20 * (rand(R1)-0.5), 0>
	}
#end

union {
	difference {
		plane {
			z, -1
			texture {
				pigment {color rgb background_color}
			}
		}

		box { <-1,0,-2> <1,0.7,1> scale 1.01 }
	}

	union {
		difference {
			box { <-1,0,-2> <1,0.7,1> }
			box { <-0.9,0.1,-1.9> <0.9,0.8,0.9> }
			wood_texture()
		}

		box { <-1.1,-0.1,1> <1.1,0.8,1.1> texture{wood_texture() rotate y*90}}

		cylinder{<0,0.35,1.1><0,0.35,1.2> .1 wood_texture()}
		sphere{0 .15 scale 0.5*z translate <0,0.35,1.2> wood_texture()}
	}

	text { ttf "timrom.ttf", "A", 2, 1
		pigment { color rgb <0.2, 0.7, 1.0> }
		finish {
			ambient 0.2
			diffuse 0.6
			phong 0.3
		}

		translate <-0.35, 0, -0.8>
		scale <3.4, 3.4, 0.2>
		rotate <0, 180+45, 0>

	}

#declare R1 = seed(34567);
#declare splend = 275;

#declare cnt = 0;
	#while ( cnt < splend )
	#declare k = 20*(rand(R1)-0.5);
	#declare l = 20*(rand(R1)-0.5);
	light_source {
		<0, 30, 40> + k * <1, -1, 0> + l * <1, 1, 0>
		color rgb 1.1*<1,1,1> / splend
	}
#declare cnt = cnt +1;
#end
	rotate y*90
}

