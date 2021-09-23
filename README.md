# GreyDecision.jl

A Julia package for Grey Numbers, their operations, and Grey Decision tools.

## Grey Numbers 

### Basic Arithmetic
```julia
julia> g = GreyNumber(5.0, 6.0)
GreyNumber{Float64}(5.0, 6.0)

julia> h = GreyNumber(11.0, 8.0)
GreyNumber{Float64}(8.0, 11.0)

julia> g + h
GreyNumber{Float64}(13.0, 17.0)

julia> g - h
GreyNumber{Float64}(-6.0, -2.0)

julia> g * h
GreyNumber{Float64}(40.0, 66.0)

julia> g / h
GreyNumber{Float64}(0.45454545454545453, 0.75)
```

### Integration of other Julia Base operations
```julia
julia> zero(GreyNumber)
GreyNumber{Float64}(0.0, 0.0)

julia> one(GreyNumber)
GreyNumber{Float64}(1.0, 1.0)

julia> zeros(GreyNumber{Float64}, 2, 3)
2×3 Matrix{GreyNumber{Float64}}:
 GreyNumber{Float64}(0.0, 0.0)  GreyNumber{Float64}(0.0, 0.0)  GreyNumber{Float64}(0.0, 0.0)
 GreyNumber{Float64}(0.0, 0.0)  GreyNumber{Float64}(0.0, 0.0)  GreyNumber{Float64}(0.0, 0.0)

julia> ones(GreyNumber{Float64}, 2, 3)
2×3 Matrix{GreyNumber{Float64}}:
 GreyNumber{Float64}(1.0, 1.0)  GreyNumber{Float64}(1.0, 1.0)  GreyNumber{Float64}(1.0, 1.0)
 GreyNumber{Float64}(1.0, 1.0)  GreyNumber{Float64}(1.0, 1.0)  GreyNumber{Float64}(1.0, 1.0)
```

### Mathematical functions on Grey Numbers
```julia
julia> g
GreyNumber{Float64}(5.0, 6.0)

julia> g^2.0
GreyNumber{Float64}(25.0, 36.0)

julia> sqrt(g)
GreyNumber{Float64}(2.23606797749979, 2.449489742783178)

julia> g * 10
GreyNumber{Float64}(50.0, 60.0)

julia> sum([g, h])
GreyNumber{Float64}(13.0, 17.0)
```

## Grey Decision Analysis

List and examples for implemented methods

### Topsis

```julia
julia> decmat = [
               GreyNumber(1.0, 2.0) GreyNumber(2.0, 3.0) GreyNumber(3.0, 4.0);
               GreyNumber(2.0, 3.0) GreyNumber(1.0, 2.0) GreyNumber(3.0, 4.0);
               GreyNumber(3.0, 4.0) GreyNumber(2.0, 3.0) GreyNumber(1.0, 2.0);
           ]; # Decision matrix with Grey Numbers

julia> w = [0.5, 0.4, 0.1]; # Weights

julia> fns = [maximum, maximum, minimum]; # Direction of optimization

julia> scores = topsis(decmat, w, fns)
3-element Vector{GreyNumber{Float64}}:
 GreyNumber{Float64}(0.2350699228751952, 0.83613099715003)
 GreyNumber{Float64}(0.24317523558639148, 1.002942207810138)
 GreyNumber{Float64}(0.10851899761349458, 1.23913068959885)

 julia> scores |> sortperm |> last # Best strategy is 2nd.
 2
```

### Simple Additive Weighting (SAW)

### Vikor

### Non-dominated sorting

### Moora

### Electre


