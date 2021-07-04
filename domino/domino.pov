
#include "colors.inc"
#include "textures.inc"

camera {
    location 2.0*<2.0, 0.5, 1>
    look_at  <0,2,1>/2
    right x*image_width/image_height
}

background {Black}

plane{  y, -0.10
    texture{
        pigment { color rgb <0,0,0> }
        finish{reflection 0.0}
    }
}

plane{ y, 0 texture{pigment{color rgb <0.1,0.1,0.1, 1>} finish{reflection 0.2}} }

light_source {
	2*<1, 8, 3>
    color rgb 1.5*White
}

light_source {
	2*<1, 8, 3> +y
    color rgb 1.5*White
}



#declare WoodTexture = texture{
	pigment{
            wood
            turbulence .05
            color_map {
             [0.0, 1.001 color rgb <0.90, 0.20, 0.10>
                         color rgb <0.50, 0.10, 0.05>]
            }
            scale 0.05
            rotate 45*y
            translate x
        }
        finish{reflection .1 ambient 0.2 diffuse 0.9 phong 0.75  phong_size 80 }
}



#declare Margin = 0.03;
#declare Inlay = 0.005;
#declare ButtonSize = 0.1;
#declare ButtonDepth = 0.005;
#declare Thickness = 0.3;
#declare ButtonMargin = 0.21;



difference {
    box{<0,0,0>,<0.3,2,1>}
    union
    {
        #declare i=0;
        #while(i<3)
            #declare j=0;
            #while(j<3)
                sphere{
                    0,1 
                    texture{pigment{White}}
                    scale <ButtonDepth,ButtonSize,ButtonSize>
                    translate x*(Thickness-Inlay)
                    translate ButtonMargin*<0,1,1>
                    translate ((1-2*ButtonMargin)/2)*<0,i,j>
                }
            #declare j=j+1;
            #end
        #declare i=i+1;
        #end


        box{ <Thickness-Inlay, Margin,Margin>,<Thickness+0.1, 1-Margin,1-Margin> }
        box{ <Thickness-Inlay, Margin,Margin>,<Thickness+0.1, 1-Margin,1-Margin> translate y }
    }
    
    texture{WoodTexture}
}












