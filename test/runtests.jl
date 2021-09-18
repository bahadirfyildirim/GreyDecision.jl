using Test
using GreyDecision

@info "Testing Moora"
include("./testmoora.jl")

# Testing Core Library
@info "Testing Grey Numbers and their operations"
include("./testgreynumber.jl")

@info "Testing Stats"
include("./teststats.jl")

@info "Testing utility functions"
include("./testutility.jl")

@info "Testing Random module"
include("./testrandom.jl")


# Testing Grey Decision Methods
@info "Testing topsis"
include("./testtopsis.jl")

@info "Testing Vikor"
include("./testvikor.jl")

@info "Testing Saw"
include("./testsaw.jl")

@info "Testing NDS"
include("./testnds.jl")









