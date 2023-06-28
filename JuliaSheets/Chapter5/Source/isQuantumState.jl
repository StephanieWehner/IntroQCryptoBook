#
# Checks whether the input rho is a valid quantum state
#

function isQuantumState(rho)

	# defined the cutoff when we consider something to be positive
	epsilon = 10.0^(-15);

	# Check whether it's hermitian
	if (rho != rho')
		return 0;
	end

	# check for positivity
	l = eigvals(rho)[1];
	if (minimum(l) <= - epsilon)
		return 0;
	end

	return 1;
end

	

