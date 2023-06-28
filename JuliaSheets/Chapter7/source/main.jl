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
include("kron.jl");

include("makeM.jl");
include("bloch.jl")
include("func.jl")
include("minEntropy.jl")
include("isQuantumState.jl")
include("D.jl")
include("eVec.jl")