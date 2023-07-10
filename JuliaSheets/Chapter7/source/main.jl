using Pkg

Pkg.add("Convex");
Pkg.add("SCS");

using PyPlot
using Interact
using Convex;
using SCS;
using Convex: AbstractExpr;
using LinearAlgebra;

import Base.kron;
include("../../source/kron.jl");
include("../../source/makeM.jl");
include("../../source/bloch.jl")
include("../../source/func.jl")
include("../../source/minEntropy.jl")
include("../../source/isQuantumState.jl")
include("../../source/D.jl")
include("../../source/eVec.jl")