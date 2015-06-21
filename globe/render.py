
import os

f = open('globe.pov', 'r')
povtext = f.read()
f.close()

def render_once ( color, color_name, angle, frame):
    s = povtext.replace('BACKGROUND_COLOR', color)
    s = s.replace('GLOBE_ON', '1')
    s = s.replace('ANGLE', str(angle))
    f = open('out/tmp.pov', 'w')
    f.write(s)
    f.close()
    os.system( 'povray globe.ini out/tmp.pov -oout/globe_%.5d.png'%frame )
    os.remove( 'out/tmp.pov' )

numFrames = 32

for frame in range(0, numFrames):
    render_once('<0, 0, 1>', 'blue', frame * 360.0 / numFrames, frame)

