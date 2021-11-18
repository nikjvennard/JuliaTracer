using ImageFiltering

function blur(A)
    for i in CartesianIndices(A)
        if i[1]+1 > size(A,1) || i[2]+1 > size(A,2)
            continue
        end 
        a = A[i[1],i[2]]
        b = A[i[1],i[2]+1]
        c = A[i[1]+1,i[2]]
        d = A[i[1]+1,i[2]+1]
        avg = (a+b+c+d)/4.0
    
        A[i[1],i[2]] = avg
        A[i[1],i[2]+1] = avg
        A[i[1]+1,i[2]] = avg
        A[i[1]+1,i[2]+1] = avg
    end
return A
end

function blur(A, n)
    for i in 1:n
        for i in CartesianIndices(A)
            if i[1]+1 > size(A,1) || i[2]+1 > size(A,2)
                continue
            end 
            a = A[i[1],i[2]]
            b = A[i[1],i[2]+1]
            c = A[i[1]+1,i[2]]
            d = A[i[1]+1,i[2]+1]
            avg = (a+b+c+d)/4.0
        
            A[i[1],i[2]] = avg
            A[i[1],i[2]+1] = avg
            A[i[1]+1,i[2]] = avg
            A[i[1]+1,i[2]+1] = avg
        end
    end
return A
end

function Base.max(cd1::RGB{Float64}, cd2::RGB{Float64})
    if cd1.r >= cd2.r
        return cd1
    else
        return cd2
    end
end