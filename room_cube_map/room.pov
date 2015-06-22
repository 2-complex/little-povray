#include "rad_def.inc"

#declare factor = 1.0;

global_settings {
    ambient_light rgb factor * <.5, .5, .5>
    radiosity {
        Rad_Settings(Radiosity_Normal, off, off)
    }
    max_trace_level 6
}

#default{finish{ambient 0}}

camera {
    angle 90
    location <0, 5, 0>
    look_at <0, 5, 0> + DIRECTION
    right x
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
texture {
    finish {
        phong .4
        reflection 0.1
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
}
#end


#declare i = -25;
#while(i < 25)
box {
    <0, 0, -40> <0.9, 1, 40>
    wood_texture()
    translate 0.8 * i * x
}
#declare i = i+1;
#end


#declare spread = 3.0;
light_source{
    <1,14,1>
    color rgb 0.8
    area_light spread * x, spread * z, 10, 10
    adaptive 1
    jitter
}

light_source{
    <-9,14,41>
    color rgb 0.8
    area_light spread * x, spread * z, 10, 10
    adaptive 1
    jitter
}

box {<-2,14.9,-6>, <2,15,6> pigment {color rgb 10}}

union {
    box {<-1,0,-1>, <1,20,1> translate <10,0,20>}
    box {<-1,0,-1>, <1,20,1> translate <-10,0,20>}
    box {<-1,0,-1>, <1,20,1> translate <10,0,-20>}
    box {<-1,0,-1>, <1,20,1> translate <-10,0,-20>}

    merge {
        box {<-10,0,-20>, <10,15,20> hollow on}
        box {<-10,0,-20>, <10,15,20> hollow on translate 41*z}
        box {<-3,0,19>, <3,9,22>}
    }

    pigment{color rgb 1}
}

