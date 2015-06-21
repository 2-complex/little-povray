
#declare background_color = BACKGROUND_COLOR;
#declare globe_on = GLOBE_ON;
#declare y_rotation = ANGLE;

global_settings {
  ambient_light rgb 2
  max_trace_level 10
}

light_source {
    5*x + 10*z
    color rgb 2
}

camera {
    angle 15
    location z*9
    look_at <0,0,0>
    right x
    up y
}

plane {
    z, -10
    texture {
        pigment {color rgb background_color}
    }
}

#if(globe_on)

sphere {0 1
    pigment{
    image_map {
           png "world_mono.png"
           once
           map_type 2 // cylindrical
        }
        translate <0,-0.5,0>
        scale <1,2,1>
    }
    rotate y_rotation * y
    rotate 23.5 * x
}

#end

