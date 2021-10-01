module GreyDecision

include("./greynumber.jl")
include("./utility.jl")
include("./stats.jl")
include("./random.jl")
include("./topsis.jl")
include("./vikor.jl")
include("./saw.jl")
include("./nds.jl")
include("./moora.jl")
include("./electre.jl")

import ..GreyNumbers: GreyNumber, kernel
import ..Topsis: topsis
import ..Vikor: vikor
import ..Saw: saw
import ..NDS: nds 
import ..Moora: moora
import ..Electre: electre

export GreyNumbers
export Utility
export Random
export Stats 

export GreyNumber
export topsis, vikor, saw, nds, moora, electre

end # module GreyDecision
