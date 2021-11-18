using ImageView, LinearAlgebra, Colors, FileIO, Meshes
include("Triangle_Intersection.jl")
include("Filters.jl")

scale = 10
aspect = (16, 9)

B = fill(RGB(1.0, 0.0, 0.0), aspect[2]*scale, aspect[1]*scale)

pixels = aspect[2]*aspect[1]*scale


mesh = load("C:/Users/Nik/Desktop/dragon.obj")

vertsInMesh = length(mesh)
current = 0.0

for f in mesh

    global current = current + 1

    if current % 100 == 0
        print(round((current/vertsInMesh)*100))
    print("\n")
    end

    geo = Triangle(f[1]*.4,f[2]*.4,f[3]*.4)

    for i in CartesianIndices(B)
        
        uv = [i[2]/(aspect[2]*scale)-.5, i[1]/(aspect[1]*scale)-.5]
        uvw = [uv[1], uv[2]+1, -5]

        ray = Ray([0.0,1,-5.5], uvw)

        hit = TriangleIntersection(geo, ray, 1.0)

        B[i] += RGB(float(hit))
        
    end
end
img = B
imshow(img, aspect="auto")

