
#declare factor = 0.8;

global_settings {
  ambient_light rgb factor * <.5, .5, .5>
  max_trace_level 6
}

camera {
  angle 20
  location <3, 4, 20>
  look_at <0, 1, 0>
  right 4*x/3
  up y
}

#declare R1 = seed(34);

#declare woodf = function{
  pattern{
    wood
    turbulence .01
    scale 0.04
  }
}

#declare woodg = function{
  pattern{
    granite
    scale 10
  }
}


intersection {
  box {<-1, -1, -1> <1, 1, 1> scale <10, 1, 10>}
  
  union {
    #declare vx = -10;
    #while ( vx < 10 )
    
    union {
      #declare vy = -3;
      #while ( vy < 3 )
      
      box {
        <0, -.1, 0> <.3, 0, 4>
        
        texture {
          finish {
            phong .4
            reflection 0.1
          }
          pigment {
            function {
              .5 * woodf(x, y, z) + .5 * woodg(10*x, y, z)
            }
            #declare c = <rand(R1)-0.2, 0, 0>/4;
            color_map {
              [0.0, color <1, 1, 1> + c]
              [0.7, color <.9, .8, .3> + c]
              [0.8, color <1, .7, .3> + c]
              [1, color <1, .6, .3> + c]
            }
            rotate <20 * (rand(R1)-.5), 20 * (rand(R1)-0.5), 0>
          }
        }
        
        translate vy*4*(z)
        translate vx*.3*(x)
      }
      
      #declare vy = vy +1;
      #end
      
      translate rand(R1)*z*5
    }
  
    #declare vx = vx +1;
    #end
  
    scale 3
    rotate 90*y
  }

}

sphere {
  y, 1
  finish {phong .4 reflection 0.1}
  pigment {color rgb 1.1 * <1,1,1>}
}


union {
  difference {
    intersection{plane{z, 0} plane{-z, .1}}
    union{
      box {-z <1, 1, 1>}
      box {-z <1, 1, 1> translate x*1.1}
      box {-z <1, 1, 1> translate x*1.1 + y*1.1}
      box {-z <1, 1, 1> translate y*1.1}
    }
    
    texture {pigment {color rgb <0, 0, 0>}}
  }
  
  plane { z, -4
    texture {
      pigment {color rgb 5*<1, 1, 1>}
    }
  }
  
  #declare R1 = seed(35);
  #declare splend = 300;

  #declare cnt = 0;
  #while ( cnt < splend )
    light_source {
      <0, 0, -3> + 2 * rand(R1) * x + 2 * rand(R1) * y
      color rgb factor * <1, 1, 1> / splend
    }
  #declare cnt = cnt +1;
  #end
  
  
  scale 3
  translate -10*z + y - x
}


