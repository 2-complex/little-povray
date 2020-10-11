
global_settings
{
    ambient_light rgb 2.3*<1, 1, 1>
    max_trace_level 10
}

camera
{
    angle 40
    location 3*<1,2,3>
    look_at <0,0,0>

    up y
    right 16/9*x
}

light_source
{
    <-10,3,15>
    color rgb <1,1,1>
}


#macro my_wood(R, T, )
pigment
{
    wood
    color_map {
        [0.0 color <100,42,52> / 200]
        [0.6 color <160,100,32> / 200]
        [0.9 color <139,69,19> / 200]
        [1.0 color <100,42,52> / 200]
    }
    turbulence 0.02
    scale 0.1
    translate .8*(x+y)
    rotate 92*y
    rotate 2*x
}
#end

box
{
    <-1, -1, -1>, <1, 1, 1>
    my_wood(0, 0)
}
