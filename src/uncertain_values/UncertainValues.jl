using Reexport

@reexport module UncertainValues
    using IntervalArithmetic
    import IntervalArithmetic: interval
    using Distributions
    using RecipesBase
    using StaticArrays
    using Measurements
    import KernelDensity: KernelDensity, UnivariateKDE, default_bandwidth, kde
    import StatsBase: StatsBase,
        ProbabilityWeights, pweights, 
        FrequencyWeights, fweights,
        Weights, weights,
        AnalyticWeights, aweights

    ##########################################
    # Abstract types
    ##########################################
    include("abstract_types/AbstractUncertainValue.jl")

    include("abstract_types/AbstractTheoreticalDistributionScalarValue.jl")

    include("abstract_types/AbstractPopulation.jl")
    include("abstract_types/AbstractScalarPopulation.jl")

    include("abstract_types/AbstractEmpirical.jl")
    
    include("abstract_types/AbstractUncertainScalarKDE.jl")


    ##########################################
    # Distributions
    ##########################################
    include("distributions/assign_dist.jl")

    ##########################################
    # Fitted distribution type
    ##########################################
    include("distributions/fitted_distribution.jl")



    ##########################################
    # Composite uncertain scalar types
    ##########################################
    # Theoretical distributions with known parameters
    include("UncertainScalarsTheoretical.jl")

    # Theoretical distributions with fitted parameters
    include("UncertainScalarsTheoreticalFitted.jl")

    # Kernel density estimated distributions
    include("UncertainScalarsKDE.jl")

    # Populations with weighted probabilities
    include("UncertainScalarPopulation.jl")
    
    # Certain values (i.e. values without uncertainty)
    include("CertainScalar.jl")

    ##########################################
    # Composite uncertain vector types
    ##########################################
    include("UncertainVectorsTheoretical.jl")
    include("UncertainVectorsTheoreticalFitted.jl")
    include("UncertainVectorsKDE.jl")


    # Define common constructor, so a similar syntax may be used to construct
    # all types of uncertain values.
    include("UncertainValue.jl")

    ##########################################
    # Comparisons
    ##########################################
    include("operations/comparisons.jl")

    # Conversions
    include("convert.jl")

    export KernelDensity, UnivariateKDE, default_bandwidth, kde
        ProbabilityWeights, pweights, 
        FrequencyWeights, fweights,
        Weights, weights,
        AnalyticWeights, aweights
end #module

"""
	UncertainValues

A module defining uncertain value types.
"""
UncertainValues
