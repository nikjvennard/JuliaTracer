using ImageView, LinearAlgebra
include("Triangle_Intersection.jl")

scale = 25
aspect = (16, 9)

A = zeros(aspect[2]*scale,aspect[1]*scale)
pixels = aspect[2]*aspect[1]*scale

for i in CartesianIndices(A)
    uv = [i[2]/(aspect[2]*scale), i[1]/(aspect[1]*scale)]
    uvw = [uv[1], uv[2], 1]

    geo = Triangle([1,.5,1],[1,1,1],[5,.5,1])
    ray = Ray([0,0,-2], uvw)

    hit = TriangleIntersection(geo, ray, 1000.0)

    A[i] = hit
end

img = A
imshow(img, aspect="auto")