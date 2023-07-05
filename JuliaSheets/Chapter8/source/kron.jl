#
# A function kron which can take the kronecker product of 
# a numerical values matrix and an variable using in Convex.jl
#
# Adapted from an online post

function kron(a::Array{Float64,2}, b::Convex.Variable)

  	rows = Convex.AbstractExpr[]
  	for i in 1:size(a)[1]
    		row = Convex.AbstractExpr[]
    		for j in 1:size(a)[2]
      		push!(row, a[i, j] * b)
    		end
    		push!(rows, foldl(hcat, row))
  	end
  	return foldl(vcat, rows)
end

