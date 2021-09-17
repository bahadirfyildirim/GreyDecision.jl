using Test
using GreyDecision

@info "Testing NDS"
include("./testnds.jl")

@info "Testing saw"
include("./testsaw.jl")

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

