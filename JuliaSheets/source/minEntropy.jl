#
# Computes the min-entropy of the input state rhoAE
#
# rhoAE:  input state
# dA:     dimension of A

function minEntropy(rhoAE,dA)
    
	# Check whether we have a valid state
    	if(isQuantumState(rhoAE) == 0)
        	error("Not a valid quantum state");
    	end
    
    	# Check the dimensions of the state
    	(d1,d2) = size(rhoAE);
    	if(d1 < dA)
        	error("Incorrect dimension dA: Smaller than matrix size.");
    	end
    
    	# Compute the dimension of E (may be 1)
    	dE = Int(round(d1/dA));
    	if (dE*dA != d1)
        	error("Incorrect dimension dA: does not divide matrix size.");
    	end
    
    	# Construct the identity matrix on A
    	idA = I(dA);
    
    	# Julia deals with real variables only, so we need to map the complex problem onto a real one
    	# find the complex and real parts of the input
    	realRho = real(rhoAE);
    	imRho = imag(rhoAE);
    	mapRho = [realRho -imRho;imRho realRho];
    
    	# set up the optimization problem
	if(dE == 1) 
		# unconditional min-entropy

		lambda = Variable(1);
		problem = minimize(lambda);
		problem.constraints += ([(lambda * I(2* dA) - mapRho) in :SDP]);
	else 
		# conditional min-entropy

    		# set up the SDP variables
    		sigmaEReal = Variable(dE,dE);
    		sigmaEImag= Variable(dE,dE);

		problem = minimize(tr(sigmaEReal));
    		problem.constraints += ([makeM(sigmaEReal,sigmaEImag) in :SDP]);
    		problem.constraints += ([(makeM(kron(idA,sigmaEReal),kron(idA,sigmaEImag)) - mapRho) in :SDP]);
	end
    
    	solve!(problem, SCS.Optimizer())
    	problem.status
    	problem.optval

	return (-log2(problem.optval));
end
