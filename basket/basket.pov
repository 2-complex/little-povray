#include "colors.inc"
#include "textures.inc"

camera {
    location <4,7,1>
    look_at  <0, 1.5, 0>
    right x*image_width/image_height
}

background {Black}

plane{ y, 0 texture{pigment{color rgb <0.25,0.3,0.25>} normal{granite .1 scale <0.3,0.3,0.3>}} }

light_source {
    3*<1, 3, -3>
    color rgb 1.5*White
    area_light x, z, 5, 5
    jitter
}



#declare R = 0.01;
#declare lsteps = 40000;
#declare isteps = 1000;
#declare jsteps = 41;
#declare rows = 30;
#declare weave_displacement = (0.015)/2;


#macro colorFunction(Theta, Phi)
    #if(Phi < (34-abs(mod(Theta,72)-34)+35) )
        <0.7,0.3,0.1>
    #else
        <1,1,0.5>
    #end
#end

union {

    union {
        #declare i = 0;
        #while(i<lsteps+2000)
            #declare T = i/lsteps;
            #declare phi = min(T*90, 90);
            #declare theta = mod(T*360*rows, 360);
            sphere{ vrotate(vrotate((-1 + weave_displacement*sin(2*pi*T*((jsteps-0.5)*rows)))*y, phi*x), theta*y), R 
                texture{pigment{color rgb colorFunction(theta, phi)}}
            }
            #declare i = i+1;
        #end
    }
    
    union {
        #declare j = 0;
        #while(j<(2*jsteps))
            #declare U = j/(2*jsteps);
            
            #declare i = 0;
            #while(i<isteps)
                #declare T = i/isteps;
                sphere{ vrotate(vrotate(-y + 2*(mod(j,2)-0.5)*weave_displacement*y*sin((rows*T-2*U)*pi), T*90*x), (U*360)*y), R }
                #declare i = i+1;
            #end
            #declare j = j+1;
        #end
        
        texture{pigment{color rgb <1,1,0.5>}}
    }
    
    translate y
    scale 3
}

