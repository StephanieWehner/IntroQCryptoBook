#
# Makes a matrix suitable for complex to real conversion for use in Convex.jl. Chiefly it takes as inputs
# two matrices (the real and imaginary parts) and returns the matrix [real -imag; imag real];
#
# 

function makeM(realM::Convex.Variable,imagM::Convex.Variable)

	rows = Convex.AbstractExpr[];
	row = Convex.AbstractExpr[];
      	push!(row, realM);
      	push!(row, -imagM);
    	push!(rows, foldl(hcat, row))

	row = Convex.AbstractExpr[];
      	push!(row, imagM);
      	push!(row, realM);
    	push!(rows, foldl(hcat, row))

  	return foldl(vcat, rows)
end

function makeM(realM::Convex.TransposeAtom,imagM::Convex.TransposeAtom)

        rows = Convex.AbstractExpr[];
        row = Convex.AbstractExpr[];
        push!(row, realM);
        push!(row, -imagM);
        push!(rows, foldl(hcat, row))

        row = Convex.AbstractExpr[];
        push!(row, imagM);
        push!(row, realM);
        push!(rows, foldl(hcat, row))

        return foldl(vcat, rows)
end
