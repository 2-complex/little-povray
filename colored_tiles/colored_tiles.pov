
global_settings {
  ambient_light rgb 1.5*<1, 1, 1>
  max_trace_level 10
}

camera {
    angle 1
    location 40.1*<0,0,10>
    look_at <0,0,0>
    right 1.0*x
    up y
}

light_source {
    10*<-5,3,9>
    color rgb <1,1,1>

    area_light 8*x,8*y,8,8
    adaptive 1 jitter
}

box {
    <-10,-10,-10>, <10,10,0.4>
    pigment {color rgb <.1,.1,.2>}
    finish {phong .2}
}


union
{

    #declare s1 = seed(1123);

    #local n = 7;

    #local i = 0;
    #while(i < n)

    #local j = 0;
    #while(j < n)

    superellipsoid
    {
        <.1, .1>

        #local theta = rand(s1)*200 + 130;

        scale 0.505
        translate i*x + j*y - 0*z - ((n-1)/2) * <1,1,0>

        pigment {color rgb 0.9*vnormalize(1.2*vaxis_rotate(x+y, <1,1,1>, theta))}
        finish {specular 0.1 phong .2 phong_size 12 metallic 1 reflection{0.4 metallic 0.9}}
    }

    #local j = j+1;
    #end

    #local i = i+1;
    #end


}