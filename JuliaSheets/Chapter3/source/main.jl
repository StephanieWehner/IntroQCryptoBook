using Pkg

Pkg.add("Convex");
Pkg.add("SCS");
Pkg.add("Distributions");

using PyPlot
using Interact
using Convex;
using SCS;
using Convex: AbstractExpr;
using LinearAlgebra;
using Random;
using Distributions;


import Base.kron;
include("../../source/kron.jl");
include("../../source/makeM.jl");
include("../../source/bloch.jl")
include("../../source/func.jl")
include("../../source/minEntropy.jl")
include("../../source/eVec.jl")
include("../../source/isQuantumState.jl")
include("../../source/D.jl")