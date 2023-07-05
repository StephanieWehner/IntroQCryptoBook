#
# Computes the trace distance between two quantum states
#
# rho1: input state 1
# rho2: input state 2
#

function traceDist(rho1,rho2)

	# Check whether the inputs are valid quantum states
	if(isQuantumState(rho1) == 0)
		error("Input 1 is not a valid quantum states.");
	end
 	if(isQuantumState(rho2) == 0)
                error("Input 2 is not a valid quantum states.");
        end

	# Check whether they are both of the same dimension
	if(length(rho1) != length(rho2))
		error("Input states must have the same dimension.");
	end

	# Compute the difference operator and its eigenvalues
	A = rho1 - rho2;
	eigA = eigvals(A);
	

	# Sum up the positive eigenvalues
	s = 0;
	for j = 1:length(eigA)
		if(eigA[j] > 0)
			s = s + eigA[j];
		end
	end

	return s;
end

