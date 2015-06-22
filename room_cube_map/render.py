
import os

f = open("room.pov")
original = f.read()
f.close()

for direction, name in [
        ("<1,0,0>", "pos_x"),
        ("<-1,0,0>", "neg_x"),
        ("<0,1,0>", "pos_y"),
        ("<0,-1,0>", "neg_y"),
        ("<0,0,1>", "pos_z"),
        ("<0,0,-1>", "neg_z")]:
    t = original.replace("DIRECTION", direction)
    f = open("tmp.pov", "w")
    f.write(t)
    f.close()
    os.system('povray +H512 +W512 tmp.pov')
    os.system('mv tmp.png ' + name + ".png")
    os.remove("tmp.pov")

