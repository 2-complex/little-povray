
#include "mylathe.pov"
#include "rand.inc"

global_settings { max_trace_level 10 }

light_source { <3,8,-5> color <1,1,1> }

#declare camera_loc = <10,15,9>;
#declare look_at_loc = <0,1.5,0>;

camera {
    location camera_loc
    look_at look_at_loc
    right x*image_width/image_height
    angle 15
}

sky_sphere{pigment{ image_map{ png "room.png" map_type 1 interpolate 2 } }  rotate y*23}

#declare glass_profile = function(Theta,x)  { max( 0.8-100*x*x, -0.04*x+0.13, sqrt(0.8-(x-2)*(x-2))+0.001*x*x*x) }
#declare glass_outer_layer = MyLathe(100, 100, 0, 2.25, glass_profile, 0);


object{ glass_outer_layer
    texture{
        pigment {color rgbf <1,1,1,0.1>}
        finish {
            specular 0.1
            phong .2
            phong_size 1
            metallic 1
            reflection{0.9 metallic 0.9}
        }
    }
    interior{ior 1.01} scale 1.3*y
}

plane{y, 0 pigment{ color rgb 1}}

