using Pkg

Pkg.add("SCS")
Pkg.add("Convex")
Pkg.add("Distributions");

using SCS
using Convex
using PyPlot
using Interact
using LinearAlgebra
using Random;
using Distributions;

import Base.kron;

include("../../source/mmp.jl")
include("../../source/bell_test.jl")
include("../../source/partialTrace.jl")
include("../../source/partialTranspose.jl")
include("../../source/check_entangled.jl")
include("../../source/kron.jl");
include("../../source/makeM.jl");
include("../../source/bloch.jl")
include("../../source/func.jl")
include("../../source/minEntropy.jl")
include("../../source/isQuantumState.jl")
include("../../source/D.jl")
include("../../source/eVec.jl")