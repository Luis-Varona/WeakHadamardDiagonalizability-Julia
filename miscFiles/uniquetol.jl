function uniquetol(vec::Vector)
    n = length(vec)
    vecUnique = Vector{eltype(vec)}
    
    for v in vec
        # if all(abs.(v .- vecUnique) .> 1e-5)
        #     vecUnique = vcat(vecUnique, v)
        # end
        if all(isapprox.(vecUnique, v) .== false)
            vecUnique = vcat(vecUnique, v)
        end
    end
end