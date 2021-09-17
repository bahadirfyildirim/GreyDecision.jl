module GreyDecision

include("./greynumber.jl")
include("./utility.jl")
include("./random.jl")
include("./topsis.jl")
include("./vikor.jl")
include("./saw.jl")
include("./nds.jl")

import ..GreyNumbers: GreyNumber
import ..Topsis: topsis
import ..Vikor: vikor
import ..Saw: saw
import ..NDS: nds 


export GreyNumbers
export Utility
export Random

export GreyNumber
export topsis, vikor, saw, nds

end # module GreyDecision
