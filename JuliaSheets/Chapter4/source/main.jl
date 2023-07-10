using Pkg
Pkg.add("SCS")
Pkg.add("Convex")

using SCS
using Convex
using PyPlot
using Interact
using LinearAlgebra

include("../../source/mmp.jl")
include("../../source/bell_test.jl")
include("../../source/partialTrace.jl")
include("../../source/partialTranspose.jl")
include("../../source/check_entangled.jl")
