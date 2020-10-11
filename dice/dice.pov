
global_settings
{
    ambient_light rgb 1.5*<1, 1, 1>
    max_trace_level 10
}

camera
{
    angle 25
    location 1.5*<-5,12,20>
    look_at <6, 0, 8>
    right 16/9*x
    up y
}

light_source
{
    <-10,10,8>
    color rgb <1,1,1>
    fade_distance 10
    fade_power 2
    area_light 10*x,10*z,8,8
    adaptive 1 jitter
}

box
{
    <-1000,-2,-1000>, <1000,1000,1000>
    pigment {color rgb 0.2*z}
    finish {phong .2}

    hollow on
}


#local die_pattern_k = 0.50;
#local die_hole_radius = 0.20;
#local die_hole_height = 1;

#macro hole_pattern(A,B,C, D,E,F, G,H,I, axis)
union
{
    #if(A=1) sphere { <die_pattern_k, die_pattern_k, die_hole_height>, die_hole_radius } #end
    #if(B=1) sphere { <0, die_pattern_k, die_hole_height>, die_hole_radius } #end
    #if(C=1) sphere { <-die_pattern_k, die_pattern_k, die_hole_height>, die_hole_radius } #end

    #if(D=1) sphere { <die_pattern_k, 0, die_hole_height>, die_hole_radius } #end
    #if(E=1) sphere { <0, 0, die_hole_height>, die_hole_radius } #end
    #if(F=1) sphere { <-die_pattern_k, 0, die_hole_height>, die_hole_radius } #end

    #if(G=1) sphere { <die_pattern_k, -die_pattern_k, die_hole_height>, die_hole_radius } #end
    #if(H=1) sphere { <0, -die_pattern_k, die_hole_height>, die_hole_radius } #end
    #if(I=1) sphere { <-die_pattern_k, -die_pattern_k, die_hole_height>, die_hole_radius } #end

    rotate axis
}
#end

#local die_finish = finish
{
    specular 0.1
    phong .2 phong_size 12 metallic 1
    reflection
    {
        0.0
        metallic 0.1
    }
};

#macro die()
difference
{
    superellipsoid
    {
        <.2, .2>
        pigment{color rgb 2}
        finish {die_finish}
    }

    union
    {
        hole_pattern(0,0,0, 0,1,0, 0,0,0, 0) // 1
        hole_pattern(1,1,1, 0,0,0, 1,1,1, 180*x) // 6

        hole_pattern(1,0,0, 0,1,0, 0,0,1, -90*y) // 3
        hole_pattern(1,0,1, 0,0,0, 1,0,1, 90*y) // 4

        hole_pattern(0,0,1, 0,0,0, 1,0,0, 90*x) // 2
        hole_pattern(1,0,1, 0,1,0, 1,0,1, -90*x) // 5

        pigment{color rgb 0}
        finish {die_finish}
    }

    scale 0.3
}
#end


// DICE
union
{
    die()
    rotate -90*x
    translate y
    translate <4, 0, 8>
}

union
{
    die()
    rotate 90*x
    rotate -75*y
    translate y
    translate <4, 0, 9>
}

#declare board_surface_height = 0.7;

#macro m_triangle(X, C)
union
{
    prism
    {
        linear_sweep
        linear_spline
        0, board_surface_height,
        3, <X,0>, <X+0.5,6>, <X+1,0>

        pigment{color C}
    }
    prism
    {
        linear_sweep
        linear_spline
        0, board_surface_height,
        3, <X,16>, <X+0.5,10>, <X+1,16>

        pigment{color C}
    }
}
#end

#local epsilon = 0.001;


#macro board_surface()
union 
{
    union
    {
        #local N = 0;
        #while(N<6)
            m_triangle(N, <1,1,1>)
            #local N = N + 2;
        #end

        #local N = 1;
        #while(N<6)
            m_triangle(N, <0,0,0>)
            #local N = N + 2;
        #end
    }

    box
    {
        <0,0,0>, <6,board_surface_height-epsilon,16>
        texture {normal{ granite 0.2 scale 0.1 } pigment {color rgb <0.0, 0.6, 0.3>}}
    }
}
#end

#declare box_height = 1.25;
#declare box_thickness = 0.3;

#macro my_wood(R, T)
pigment
{
    wood
    color_map {
      [0.0 color <218,165,32> / 200]
      [0.9 color <139,69,19> / 200]
      [1.0 color <150,42,52> / 200]
    }
    turbulence 0.008
    scale 0.1
    translate T
    rotate R
}
#end

#macro board_box()
union
{
    prism
    {
        linear_sweep
        linear_spline
        0, box_height,
        4, <0,0>, <6,0>, <6+box_thickness,-box_thickness>, <-box_thickness,-box_thickness>

        pigment
        {
            wood
            color_map {
                [0.0 color <100,42,52> / 200]
                [0.6 color <160,100,32> / 200]
                [0.9 color <139,69,19> / 200]
                [1.0 color <100,42,52> / 200]
            }
            turbulence 0.01
            scale 0.05
            translate 6.1*x + y
            rotate 90.3*y
        }
    }

    prism
    {
        linear_sweep
        linear_spline
        0, box_height,
        4, <0,0>, <0,16>, <-box_thickness, 16+box_thickness>, <-box_thickness,-box_thickness>

        pigment
        {
            wood
            color_map {
                [0.0 color <100,42,52> / 200]
                [0.6 color <160,100,32> / 200]
                [0.9 color <139,69,19> / 200]
                [1.0 color <100,42,52> / 200]
            }
            turbulence 0.01
            scale 0.05
            translate 6.1*x + y
            rotate 0.3*y
        }
    }

    prism
    {
        linear_sweep
        linear_spline
        0, box_height,
        4, <0, 16>, <-box_thickness, 16+box_thickness>, <6+box_thickness, 16+box_thickness>, <6, 16>

        pigment
        {
            wood
            color_map {
                [0.0 color <100,42,52> / 200]
                [0.6 color <160,100,32> / 200]
                [0.9 color <139,69,19> / 200]
                [1.0 color <100,42,52> / 200]
            }
            turbulence 0.01
            scale 0.05
            translate 7*x + y
            rotate 90.3*y
        }
    }

    prism
    {
        linear_sweep
        linear_spline
        0, box_height,
        4, <6, 0>, <6+box_thickness, -box_thickness>, <6+box_thickness, 16+box_thickness>, <6, 16>

        pigment
        {
            wood
            color_map {
                [0.0 color <100,42,52> / 200]
                [0.6 color <160,100,32> / 200]
                [0.9 color <139,69,19> / 200]
                [1.0 color <100,42,52> / 200]
            }
            turbulence 0.01
            scale 0.05
            translate 6.1*x + y
            rotate 0.3*y
        }
    }

    pigment { color rgb 1 }
}
#end


#macro piece(X, Y, C)
cylinder
{
    <0.5+X, 0, 0.5+Y>, <0.5+X, 0.9, 0.5+Y>, 0.5
    pigment {color rgb 2*C}
    finish {phong .2}
}
#end

#declare small = 0.01;

#macro hinge()
    box{<-0.2,0,-1>, <0.2,0.01,1>}
    cylinder{<0, 0, -1>, <0, 0, -0.5-small>, 0.05}
    cylinder{<0, 0, -0.5+small>, <0, 0, -small>, 0.05}
    cylinder{<0, 0, small>, <0, 0, 0.5-small>, 0.05}
    cylinder{<0, 0, 0.5+small>, <0, 0, 1>, 0.05}
#end 


union
{
    union
    {
        board_surface()
        board_box()

        piece(0, 0, 0)
        piece(0, 1, 0)
        piece(0, 2, 0)
        piece(0, 3, 0)
        piece(0, 4, 0)
        piece(0, 5, 0)

        piece(0, 15-0, 1)
        piece(0, 15-1, 1)
        piece(0, 15-2, 1)
        piece(0, 15-3, 1)
        piece(0, 15-4, 1)
        piece(0, 15-5, 1)

        piece(4, 15-0, 0)
        piece(4, 15-1, 0)
        piece(4, 15-2, 0)

        piece(4, 0, 1)
        piece(4, 1, 1)
        piece(4, 2, 1)
    }

    union
    {
        board_surface()
        board_box()

        piece(0, 0, 1)
        piece(0, 1, 1)
        piece(0, 2, 1)
        piece(0, 3, 1)
        piece(0, 4, 1)
        piece(0, 5, 1)

        piece(0, 15-0, 0)
        piece(0, 15-1, 0)
        piece(0, 15-2, 0)
        piece(0, 15-3, 0)
        piece(0, 15-4, 0)
        piece(0, 15-5, 0)

        piece(5, 0, 0)
        piece(5, 1, 0)

        piece(5, 15-0, 1)
        piece(5, 15-1, 1)

        translate 6.7 * x
    }

    union
    {
        union
        {
            hinge()
            translate <6.65 - box_thickness, 1.245, 3>
        }

        union 
        {
            hinge()
            translate <6.65 - box_thickness, 1.245, 13>
        }

        pigment {color rgb <0.9, 0.9, 0.8>}
        finish {specular 0.1 phong .2 phong_size 12 metallic 1 reflection{0.9 metallic 0.9}}
    }
}





