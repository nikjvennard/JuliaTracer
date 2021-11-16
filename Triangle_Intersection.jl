using LinearAlgebra

mutable struct Triangle
    v0::Vector{Float64}
    v1::Vector{Float64}
    v2::Vector{Float64}
end

mutable struct Ray
    origin::Vector{Float64}
    direction::Vector{Float64}
end

function TriangleIntersection(triangle, ray)
    ϵ = 0.00001
    v0 = triangle.v0; v1 = triangle.v1; v2 = triangle.v2
    edge1 = [0.0,0.0,0.0]; edge2 = [0.0,0.0,0.0]; h = [0.0,0.0,0.0]; s = [0.0,0.0,0.0]; q = [0.0,0.0,0.0]
    a = 0.0; f = 0.0; u = 0.0; v = 0.0
    edge1 = v1 - v0
    edge2 = v2 - v0
    h = cross(edge2, ray.direction)
    a = dot(h, edge1)
    if a > -ϵ && a < ϵ
        return false
    end
    f = 1.0 / a
    s = ray.origin - v0
    u = f * dot(h, s)
    if u < 0.0 || u > 1.0
        return false
    end
    q = cross(edge1, s)
    v = f * dot(q, ray.direction)
    if v < 0.0 || u + v > 1.0
        return false
    end
    t = f * dot(q, edge2)
    if t > ϵ
        return true
    end
    return false
end

function TriangleIntersection(triangle, ray, farclip)
    ray.direction = ray.direction * farclip
    ϵ = 0.00001
    v0 = triangle.v0; v1 = triangle.v1; v2 = triangle.v2
    edge1 = [0.0,0.0,0.0]; edge2 = [0.0,0.0,0.0]; h = [0.0,0.0,0.0]; s = [0.0,0.0,0.0]; q = [0.0,0.0,0.0]
    a = 0.0; f = 0.0; u = 0.0; v = 0.0
    edge1 = v1 - v0
    edge2 = v2 - v0
    h = cross(edge2, ray.direction)
    a = dot(h, edge1)
    if a > -ϵ && a < ϵ
        return false
    end
    f = 1.0 / a
    s = ray.origin - v0
    u = f * dot(h, s)
    if u < 0.0 || u > 1.0
        return false
    end
    q = cross(edge1, s)
    v = f * dot(q, ray.direction)
    if v < 0.0 || u + v > 1.0
        return false
    end
    t = f * dot(q, edge2)
    if t > ϵ
        return true
    end
    return false
end