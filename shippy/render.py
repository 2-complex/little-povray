
import os

f = open('shippy.pov', 'r')
povtext = f.read()
f.close()

def render_once(color):
    s = povtext.replace('BACKGROUND_COLOR', color)
    s = s.replace('SHAPE_ON', '1')
    f = open('out/tmp.pov', 'w')
    f.write(s)
    f.close()
    os.system('povray shippy.ini tmp.pov -Oout/out')
    os.remove('out/tmp.pov')

render_once('<0,0,1>')

