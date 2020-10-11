
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

#macro my_arrow(V)
cylinder
{
    <0,0,0>, V, 0.1
    pigment {color rgb V}
}
#end

union
{
    my_arrow(x)
    my_arrow(y)
    my_arrow(z)

    scale 10
}
