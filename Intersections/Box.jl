function findBounds(Mesh)
    
    maxX = 0.0;
    minX = 0.0;
    maxY = 0.0;
    minY = 0.0;
    maxZ = 0.0;
    minZ = 0.0;

    for t in Mesh
        for p in t
            if p[1] > maxX
                maxX = p[1];
            end
            if p[1] < minX
                minX = p[1];
            end
            if p[2] > maxY
                maxY = p[2];
            end
            if p[2] < minY
                minY = p[2];
            end
            if p[3] > maxZ
                maxZ = p[3];
            end
            if p[3] < minZ
                minZ = p[3];
            end
        end
    end

    return minX, minY, minZ, maxX, maxY, maxZ;

end

function rayBoxIntersection(ray, box)
    tmin = (box[1]-ray.origin[1]) / ray.direction[1];
    tmax = (box[4]-ray.origin[1]) / ray.direction[1];

    if tmin > tmax
        temp = tmin;
        tmin = tmax;
        tmax = temp;
    end

    tymin = (box[2]-ray.origin[2]) / ray.direction[2];
    tymax = (box[5]-ray.origin[2]) / ray.direction[2];

    if tymin > tymax
        temp = tymin;
        tymin = tymax;
        tymax = temp;
    end

    if ((tmin > tymax) || (tymin > tmax))
        return false;
    end

    if tymin > tmin
        tmin = tymin;
    end

    if tymax < tmax
        tmax = tymax;
    end

    tzmin = (box[3]-ray.origin[3]) / ray.direction[3];
    tzmax = (box[6]-ray.origin[3]) / ray.direction[3];

    if tzmin > tzmax
        temp = tzmin;
        tzmin = tzmax;
        tzmax = temp;
    end

    if ((tmin > tzmax) || (tzmin > tmax))
        return false;
    end

    if tzmin > tmin
        tmin = tzmin;
    end

    if tzmax < tmax
        tmax = tzmax;
    end
    
    return true
end
    
