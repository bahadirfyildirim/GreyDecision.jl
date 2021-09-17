using Test
using GreyDecision

@info "Testing Vikor"
include("./testvikor.jl")

@info "Testing topsis"
include("./testtopsis.jl")

@info "Testing Random module"
include("./testrandom.jl")

@info "Testing utility functions"
include("./testutility.jl")

@info "Testing Grey Numbers and their operations"
include("./testgreynumber.jl")

