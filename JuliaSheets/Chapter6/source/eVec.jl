# Makes a vector in the standard basis
#
#
# n: dimension
# j: element of the standard basis

function eVec(n,j)
	vO = zeros(n,1);
	vO[j] = 1;
	return vO;
end

