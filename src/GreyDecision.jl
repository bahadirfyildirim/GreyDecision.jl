module GreyDecision

include("./greynumber.jl")
include("./utility.jl")
include("./random.jl")
include("./topsis.jl")
include("./vikor.jl")

import ..GreyNumbers: GreyNumber
import ..Topsis: topsis
import ..Vikor: vikor

export GreyNumbers
export Utility
export Random

export GreyNumber
export topsis, vikor

end # module GreyDecision
