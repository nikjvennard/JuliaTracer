using ImageView, LinearAlgebra, Colors, FileIO, Meshes
include("Intersections/Triangle_Intersection.jl")
include("Filters.jl")
include("Intersections/Box.jl")
include("Intersections/Sphere.jl")

#------------------------------------------------------------------------------#
#                              Init Camera and Resolution                      #                                             
#------------------------------------------------------------------------------#

scale = 20
aspect = (16, 9)

B = fill(RGB(0.0, 0.0, 0.0), aspect[2]*scale, aspect[1]*scale)

pixels = aspect[2]*aspect[1]*scale
xpixel = aspect[2]*scale
ypixel = aspect[1]*scale

mesh = load("C:/Users/Nik/Desktop/box.obj")
bounds = findBounds(mesh)
vertsInMesh = length(mesh)
meshbounds = []
cameraOrigin = [0, 0, -10.5]

#---------------------------------------------------------------------------#
#                              Finding bounds                               #
#---------------------------------------------------------------------------#

@time begin

for i in CartesianIndices(B)
    uv = [(i[2]/(xpixel)-.5)*(xpixel/float(ypixel)), i[1]/(ypixel)-.5]
    uvw = [uv[1], uv[2], -10]
    ray = Ray(cameraOrigin, uvw)
    if(rayBoxIntersection(ray, bounds) == true)
        push!(meshbounds, i)
    end 
end

end

#---------------------------------------------------------------------------#
#                              Trace in bounds                              #
#---------------------------------------------------------------------------#

@time begin

face = 0

for f in mesh
    
    print(face); print(" / "); print(vertsInMesh); print(" %"); print((face/vertsInMesh)*100.0) ;print("\n");
    global face += 1

    for i in meshbounds  
        uv = [(i[2]/(xpixel)-.5)*(xpixel/float(ypixel)), i[1]/(ypixel)-.5]
        uvw = [uv[1], uv[2], -10]
        ray = Ray(cameraOrigin, uvw)
        geo = Triangle(f[1]*2,f[2]*2,f[3]*2)
        hit = TriangleIntersection(geo, ray, 1.0)
        box =  rayBoxIntersection(ray, bounds)
        infront = max(B[i].r, hit[1])
    
        if(hit[1] && infront>0.0)
             B[i] = RGB(hit[4][1], hit[4][2], hit[4][3])
        end
        
    end
end
end

#---------------------------------------------------------------------------#
#                            Print Image to Screen                          #
#---------------------------------------------------------------------------#

img = reverse(B, dims=1)
imshow(img)
