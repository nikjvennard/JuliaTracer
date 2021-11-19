using ImageView, LinearAlgebra, Colors, FileIO, Meshes
include("Triangle_Intersection.jl")
include("Filters.jl")

scale = 20
aspect = (16, 9)

B = fill(RGB(0.0, 0.0, 0.0), aspect[2]*scale, aspect[1]*scale)

pixels = aspect[2]*aspect[1]*scale
xpixel = aspect[2]*scale
ypixel = aspect[1]*scale


mesh = load("C:/Users/Nik/Desktop/box.obj")

vertsInMesh = length(mesh)
current = 0.0

for f in mesh

    global current = current + 1

    if current % 100 == 0
        print(round((current/vertsInMesh)*100))
    print("\n")
    end

    geo = Triangle(f[1]*2,f[2]*2,f[3]*2)

    for i in CartesianIndices(B)
        
        uv = [(i[2]/(xpixel)-.5)*(xpixel/float(ypixel)), i[1]/(ypixel)-.5]
        uvw = [uv[1]-.2, uv[2]+1.1, -5]

        ray = Ray([0.0,1,-5.5], uvw)

        hit = TriangleIntersection(geo, ray, 1.0)

        infront = max(B[i].r, hit[1])

        if(hit[1] && infront>0.0)
            B[i] = RGB(hit[4][1], hit[4][2], hit[4][3])
        end
    end
end
img = B
imshow(img, aspect="auto")

