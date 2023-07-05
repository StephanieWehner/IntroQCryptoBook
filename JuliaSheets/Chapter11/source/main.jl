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


include("mmp.jl")
include("bell_test.jl")
include("partialTrace.jl")
include("partialTranspose.jl")
include("check_entangled.jl")

include("kron.jl");
include("makeM.jl");
include("bloch.jl")
include("func.jl")
include("minEntropy.jl")
include("isQuantumState.jl")
include("D.jl")
include("eVec.jl")
