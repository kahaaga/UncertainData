module UncertainData

using Distributions
using IntervalArithmetic
using RecipesBase
using StatsBase
using StaticArrays
using Statistics
using KernelDensity



display_update = false
version = "v0.10.4"
update_name = "update_$version"

if display_update
if !isfile(joinpath(@__DIR__, update_name))
printstyled(stdout,
"""
\nUpdate message: UncertainData $version

- Fixed some minor bugs.
"""; color = :light_magenta)
touch(joinpath(@__DIR__, update_name))
end
end

include("definitions.jl")

# Uncertain values
include("uncertain_values/UncertainValues.jl")

# Uncertain datasets
include("uncertain_datasets/UncertainDatasets.jl")

# Sampling constraints
include("sampling_constraints/SamplingConstraints.jl")

# Interpolation and interpolation grids 
include("interpolation_and_binning/InterpolationsAndGrids.jl")

# Resampling
include("resampling/Resampling.jl")

# Mathematics 
include("mathematics/UncertainMathematics.jl")

# Uncertain statistics
include("statistics/UncertainStatistics.jl")

# Plot recipes
include("plot_recipes/UncertainDataPlotRecipes.jl")

# Operations between uncertain UncertainValues
include("uncertain_values/operations/merging.jl")

# Example datasets 
include("example_datasets/example_uvals.jl")
include("example_datasets/example_constraints.jl")
include("example_datasets/example_uncertainindexvalue_dataset.jl")

export UncertainScalarBinomialDistributed

include("sensitivity_testing/SensitivityTests.jl")

end # module
