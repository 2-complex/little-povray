camera {
    angle 20
    location z*64
    look_at <0,0,0>
    right x
    up y
}

light_source
{
    <0,0,8>
    color rgb 1.5
    area_light 12*x,12*y,16,16
    adaptive 1
    jitter
}

#local R = seed(8);
#local Y=-20;
#while(Y<20)
    #local X=-20;
    #while(X<20)
        box
        {
            0, x+y+z
            pigment
            {
                color rgb 1
            }

            translate <X,Y,0.7*rand(R)>
            scale <1,1,4>
        }
        #local X = X+1;
    #end
    #local Y = Y+1;
#end
