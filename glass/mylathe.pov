

#macro MyLathe(meridians, parallels, endpt1, endpt2, foo, inset)

    #local numberOfVertices = parallels*(meridians+1);

    #local cylinder_normals = array[numberOfVertices];
    #local cylinder_vertices = array[numberOfVertices];

    #local i=0; #while(i<parallels*(meridians+1))
        #local cylinder_normals[i] = <0,0,0>;
    #local i=i+1; #end

    object {
        mesh2 {

            #local i=0; #while(i<meridians+1)
            #local j=0; #while(j<parallels)
                #local theta = 2*pi*j/parallels;

                #local T = i/meridians;
                #local h = (1-T)*endpt1 + T*endpt2;
                #local R = foo(theta, h);
                #local V = <R*cos(theta), h, R*sin(theta)>;
                #local cylinder_vertices[parallels*i+j]=V;

            #local j=j+1; #end
            #local i=i+1; #end

            #local i=0; #while(i<meridians)
            #local j=0; #while(j<parallels)
                #local A = parallels*i+j;
                #local B = parallels*(i+1)+j;
                #local C = parallels*(i+1)+mod(j+1,parallels);
                #local D = parallels*i+    mod(j+1,parallels);
                #local N1 = vcross(cylinder_vertices[B]-cylinder_vertices[A], cylinder_vertices[C]-cylinder_vertices[A]);
                #local N2 = vcross(cylinder_vertices[C]-cylinder_vertices[A], cylinder_vertices[D]-cylinder_vertices[A]);
                #local cylinder_normals[A] = cylinder_normals[A] + N1;
                #local cylinder_normals[B] = cylinder_normals[B] + N1+N2;
                #local cylinder_normals[C] = cylinder_normals[C] + N1+N2;
                #local cylinder_normals[D] = cylinder_normals[D] +    N2;
            #local j=j+1; #end
            #local i=i+1; #end


            vertex_vectors {
                numberOfVertices,

                #local i=0; #while(i<meridians+1)
                #local j=0; #while(j<parallels)
                    cylinder_vertices[parallels*i+j] - inset*cylinder_normals[parallels*i+j]
                #local j=j+1; #end
                #local i=i+1; #end
            }

            normal_vectors {
                numberOfVertices,

                #local i=0; #while(i<numberOfVertices)
                    vnormalize(cylinder_normals[i])
                #local i=i+1; #end
            }

            face_indices {
                2*parallels*meridians,
                #local i=0; #while(i<meridians)
                #local j=0; #while(j<parallels)
                    #local A = parallels*i+j;
                    #local B = parallels*(i+1)+j;
                    #local C = parallels*(i+1)+mod(j+1,parallels);
                    #local D = parallels*i+    mod(j+1,parallels);
                    <A,B,C> <A,C,D>
                #local j=j+1; #end
                #local i=i+1; #end
            }
        }
    }
#end

