
# Changelog

## Uncertaindata.jl v0.9.0

### New features

- Added `interpolate_and_bin` function.
- Added `InterpolateAndBin` type.
- Added `resample(inds, vals, resampling::InterpolateAndBin{Linear})` method, which interpolates and bins `inds` and `vals` onto an interpolation grid, then bins and summarises the bins. Returns the binned values.
- Added `resample(x::AbstractUncertainIndexValueDataset, resampling::InterpolateAndBin{Linear})` method. 
    Draws a single realisation of both the indices and values of `x` and orders them sequentially according
    to the indices (assuming independent points). Then, interpolate, bin and summarise bins.
- Added `bin` and `bin!` functions.
- Added `bin_mean` function.
- Added `fill_nans`, `fill_nans!` and `interpolate_nans` functions for dealing with data containing `NaN`s.
- Added `findall_nan_chunks` function for identifying consecutive `NaN`s in a dataset.
- Added `RandomSequences` resampling scheme.

## Uncertaindata.jl v0.8.2

### New features

- Added `resample` method for `BinnedWeightedResampling` scheme.
- Added `AbstractBinnedResampling` for binned resamplings.
- Added `AbstractBinnedUncertainValueResampling` abstract type for binnings where 
    the values in each bin is represented by an uncertain value. `BinnedResampling` 
    and `BinnedWeightedResampling` are subtypes `AbstractBinnedUncertainValueResampling`.
- Added `AbstractBinnedSummarisedResampling` abstract type for binnings where the values 
    in each bin are summarised to a single value. `BinnedMeanResampling` and
     `BinnedMeanWeightedResampling` are subtypes `AbstractBinnedResampling`.

### Improvements

- Added more tests for binned resampling schemes.

## Uncertaindata.jl v0.8.1

### New features

- Added `UncertainValueDataset`, `UncertainIndexDataset`, and `UncertainIndexValueDataset` constructors for vectors of numbers (they get converted to `CertainValue`s). 

### Bug fixes

- `rand(x::CertainValue, n::Int)` now returns a length-`n` array with `x` repeated `n` times.

## Uncertaindata.jl v0.8.0

### New functionality

- Added binned resampling methods that uses [`BinnedResampling`](@ref) and [`BinnedMeanResampling`](@ref) schemes.
    - [`resample(::AbstractUncertainIndexValueDataset, ::BinnedResampling`](@ref)
    - [`resample(::AbstractUncertainIndexValueDataset, ::BinnedMeanResampling`](@ref)

### Bug fixes

- Fixed bug where `resample!` method for vectors and tuples of uncertain values didn't return the 
    expected result.

### Improvements

- Improved `resample!` docs.

## Uncertaindata.jl v0.7.0

### New functionality

- Added `resample!` for in-place resampling into pre-allocated containers.

## UncertainData.jl v0.5.1

### Bug fixes

- Strictly increasing or decreasing sequences were not always possible to construct 
    when using `CertainValue`s, because `TruncateRange` instances with equal 
    minimum and maximum was constructed (not possible). It is now possible to 
    resample with sequential constraints even with the `StrictlyIncreasing` 
    and `StrictlyDecreasing` constraints.

## UncertainData.jl v0.5.0

### Breaking changes

- To allow easier multiple dispatch, the `indices` field of a `UncertainIndexValueDataset` is
    now *always* an instance of a subtype of `AbstractUncertainIndexDataset`. The `values` field 
    of a `UncertainIndexValueDataset` is now *always* an instance of a subtype of 
    `AbstractUncertainValueDataset`.

### New functionality

- Experimental support for nested populations.

- Added point-estimators for single uncertain values:
    1. `harmmean(x::AbstractUncertainValue, n::Int)`
    2. `geomean(x::AbstractUncertainValue, n::Int)`
    3. `kurtosis(x::AbstractUncertainValue, n::Int; m = mean(x))`
    4. `moment(x::AbstractUncertainValue, k, n::Int, m = mean(x))`
    5. `percentile(x::AbstractUncertainValue, p, n::Int)`
    6. `renyientropy(x::AbstractUncertainValue, α, n::Int)`
    7. `rle(x::AbstractUncertainValue, n::Int)`
    8. `sem(x::AbstractUncertainValue, n::Int)`
    9. `skewness(x::AbstractUncertainValue, n::Int; m = mean(x))`
    10. `span(x::AbstractUncertainValue, n::Int)`
    11. `summarystats(x::AbstractUncertainValue, n::Int)`
    12. `totalvar(x::AbstractUncertainValue, n::Int)`

- Added statistical estimators for pairs of uncertain values:
    1. `cov(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; corrected::Bool = true)`
    1. `cor(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)`
    1. `countne(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)`
    1. `counteq(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)`
    1. `corkendall(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)`
    1. `corspearman(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)`
    1. `maxad(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)`
    1. `meanad(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)`
    1. `msd(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)`
    1. `psnr(x::AbstractUncertainValue, y::AbstractUncertainValue, maxv, n::Int)`
    1. `rmsd(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; normalize = false)`
    1. `sqL2dist(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)`
    1. `crosscor(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; demean = true)`
    1. `crosscov(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int; demean = true)`
    1. `gkldiv(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)`
    1. `kldivergence(x::AbstractUncertainValue, y::AbstractUncertainValue, n::Int)`

- Added `UncertainValue` constructor for distribution instances.
- Added `UncertainValue` constructor for (potentially nested) truncated distribution instances.
- Implemented `resample` methods for `NTuple`s of uncertain values.
- Added `resample(f::Function, n::Int, x::AbstractUncertainValue, args...; kwargs...)`method for 
    easy evaluation of point-estimates for single uncertain values.
- Added support for `Measurement` instances from 
    [Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl).
    These are treated as uncertain values represented by normal distibutions. 
    Hence, they are given no extra treatment and error propagation is done by 
    resampling, not by exact methods.
- The uncertain value type `UncertainScalarPopulation` may now not only have real-valued scalars 
    as elements of the population. It can now have uncertain values as members of the population!
- Resampling implemented for `UncertainScalarPopulation` so that we can also sample population 
    members that are uncertain values.
- Implemented iteration for `UncertainScalarPopulation`.

### Improvements

- Improved subtyping for theoretical distributions.
- Removed redundant `resample` methods for the `UncertainDataset` type. `UncertainDataset` 
    is a subtype of `AbstractUncertainValueDataset` and has no special behaviour beyond 
    that implemented for the abstract type, so now we just rely on multiple dispatch here.

### Documentation

- Improved documentation statistical methods.
- Other minor documentation improvements.
- Improved documentation for `TruncateStd`.

### Bug fixes

- Fixed error in `show` method for `AbstractUncertainValue`. Not subtypes of `AbstractUncertainValue` has the `distributions` field, so that is now removed from the `show` method.

## UncertainData.jl v0.4.0

### New functionality

- Introduce an abstract resampling type `AbstractUncertainDataResampling` for this 
    package pending the implementation of `AbstractResampling` in StatsBase.jl.

- Added `ConstrainedResampling` resampling scheme.

- Resample vectors of uncertain values without constraints. Syntax:
    1. `resample(::Vector{<:AbstractUncertainValue}` for single draws.
    2. `resample(::Vector{<:AbstractUncertainValue}, ::Int}` for multiple draws.

- Resample vectors of uncertain values with constraint(s) multiple times. Syntax:
    1. `resample(::Vector{<:AbstractUncertainValue}, ::Union{SamplingConstraint, Vector{<:SamplingConstraint}}` for single draws.
    2. `resample(::Vector{<:AbstractUncertainValue}, ::Union{SamplingConstraint, Vector{<:SamplingConstraint}}, ::Int` for multiple draws.

## UncertainData.jl v0.3.0

### New functionality

- Added additional resampling methods for uncertain index and uncertain value datasets, 
    allowing passing vectors of constraints that are mapped to each value in the dataset. The 
    syntax is `resample(::AbstractUncertainValueDataset, ::Vector{<:SamplingConstraint}` for a 
    single draw, and `resample(::AbstractUncertainValueDataset, ::Vector{<:SamplingConstraint}, n::Int`
    for `n` draws.


## UncertainData.jl v0.2.3

### Improvements

- Added input validation when initialising `TruncateQuantiles`, `TruncateRange` and 
    `TruncateStd`.
- Separate parameters types for `TruncateQuantiles` and `TruncateRange`, so one can do for 
    example `TruncateRange(1, 8.0)`, instead of having to promote to `Float64`.
- Added validation for distribution truncation when resampling.


## UncertainData.jl v0.2.2

### New functionality and syntax changes 

#### Resampling vectors consisting of uncertain values (done in #61)

- `resample(uvals::Vector{AbstractUncertainValue}, n::Int)` is now interpreted as "treat 
    `uvals` as a dataset and sample it `n` times". Thus, it now behaves as 
    `resample(AbstractUncertainDataset, n::Int)`, returning `n` vectors of length 
    `length(uvals)`, where the i-th element is a unique draw of `uvals[i]`.

- `resample_elwise(uvals::Vector{AbstractUncertainValue}, n::Int)` takes over the role as 
    "sample `uvals` element-wise and `n` times for each element". Returns a vector of 
    length `length(uvals)`, where the i-th element is a `n`-element vector of unique draws 
    of `uvals[i]`.

#### Resampling with subtypes of `AbstractUncertainValueDataset`

Currently, this affects the generic `UncertainDataset`s, as well as the specialized 
`UncertainIndexDataset`s and `UncertainValueDataset`s.

- `resample_elwise(uvd::AbstractUncertainValueDataset, n::Int)` is now interpreted as 
    "draw `n` realisations of each value in `uvd`". Returns a vector of length `length(uvals)` 
    where the i-th element is a `n`-element vector of unique draws of `uvals[i]`. This works 
    for `UncertainDataset`s, `UncertainIndexDataset`s, and `UncertainValueDataset`s. 
- `resample_elwise(uvd::AbstractUncertainValueDataset, constraint::Union{SamplingConstraint, Vector{SamplingConstraint}}, n::Int)` 
    is now interpreted as "draw `n` realisations of each value in `uvd`, subjecting each value 
    in `uvd` to some sampling `constraint`(s) during resampling". Returns a vector of 
    length `length(uvals)` where the i-th element is a `n`-element vector of unique draws 
    of `uvals[i]`, where the support of `uvals[i]` has been truncated by the provided 
    `constraint`(s).

### Bug fixes

- Removed extra blank line from print method for `AbstractUncertainPopulation`.

## UncertainData.jl v0.2.1

### New functionality

- `merge(uvals::Vector{<:AbstractUncertainValue}; n = 1000)` now makes it possible to 
    combine many uncertain values of different into one uncertain value represented by a 
    kernel density estimate. This is achieved by resampling each of the values `n` times, 
    then pooling the draws and estimating a total distribution using KDE.
- `merge(uvals::Vector{<:AbstractUncertainValue}; weights::Weights n = 1000)`, 
    `merge(uvals::Vector{<:AbstractUncertainValue}; weights::AnalyticalWeights n = 1000)` 
    and 
    `merge(uvals::Vector{<:AbstractUncertainValue}; weights::ProbabilityWeights n = 1000)`
    merges uncertain values by resampling them proportionally to `weights`, then pooling 
    the draws and performing KDE. These are all functionally equivalent, but implementations
    for different weights are provided for compatibility with StatsBase.
- `merge(uvals::Vector{<:AbstractUncertainValue}; weights::FrequencyWeights n = 1000)` 
    merges uncertain values by sampling them according to the number of samples provided 
    with `weights`.

### Bug fixes
- `resample` didn't work for `UncertainIndexDataset`s due to the data being stored in the 
    `indices` field, not the `values` field as for other subtypes of 
    `AbstractUncertainValueDataset`. This is now fixed.


## UncertainData.jl v0.2.0

### Notes
- Julia 1.1 is required for version > v.0.2.0.

### New functionality 
- Spline interpolation on a regular grid. 
- Linear interpolation on an irregular grid. 

### Improvements
- `support_overlap` now returns an interval (from `IntervalArithmetic`), in line with 
    what `support` returns.

## UncertainData.jl v0.1.8

### Bug fixes
- Added missing package dependencies which were not caught by CI.

## UncertainData.jl v0.1.7

### New functionality 
- `UncertainIndexValueDataset`s can now be constructed from vectors of uncertain values. 
    To do so, provide a vector of uncertain values for the indices, and the same for the 
    values, e.g. `UncertainIndexValueDataset([idx1, idx2], [val1, val2])`.
- Index-value dataset realizations can now be 
    [interpolated on a regular grid](resampling/interpolation/gridded.md). 

### Bug fixes 
- `minima` and `maxima` now returns the global minimum for a dataset instead of a vector 
    of elementwise minima and maxima.
- Implemented the option to linearly interpolate index-value dataset realizations. 
    To do so, provide `resample` with a [`RegularGrid`](link) instance. 
- Merged redundant methods for assigning some distributions.
- Fixed non-critical indexing bug for uncertain index-value datasets.
- Removed redudant method definitions and multiple imports of the same files causing 
    definitions to be overwritten and printing warnings statements when loading the package.

## UncertainData.jl v0.1.6

### New functionality 

- Implemented sequential sampling constraints `StrictlyIncreasing` and `StrictlyDecreasing`
    for `UncertainIndexValueDataset`s. 
- Added [UncertainScalarPopulation](uncertain_values/populations.md) type, representing 
    vectors of values that should be sampled according to a vector of probabilities. 
    
### Improvements 
- Improved documentation for `CertainValue`s.
- Added documentation for `UncertainScalarPopulation`.
- Added `UncertainScalarPopulation` to uncertain value overview list in the documentation.
- Fixed duplicate docs for `cot`, `cotd`, `coth` and added missing `acot`, `acotd`, `acoth`
    docs.
- Shortened and updated main documentation page with more links.

### Bug fixes 

- Import `Base` functions properly when defining `CertainValue`, so that no unexpected 
    behaviour is introduced.
- Fixed links in documentation that pointed to the wrong locations.
- Remove model resampling docs which was not supposed to be published until the 
    functionality is properly implemented.

## UncertainData.jl v0.1.5


### New functionality 

- Added [CertainValue](uncertain_values/certainvalue.md) type to represent scalars without
    any uncertainty. Even though a scalar is not uncertain, we'll define it as subtype of 
    `AbstractUncertainValue` to treat certain values alongside uncertain values in datasets. 
- Added plot recipe for `CertainValue`s. They are just plotted as regular points.
- Added method `resample(Vector{AbstractUncertainValue})` for resampling vectors of 
    uncertain values. Operates element-wise, just as for an uncertain dataset. 
- Added an abstract type `SequentialSamplingConstraint` to separate sequential constraints 
    from general constraints that might be applied *before* resampling according to 
    the sequential constraints.
- Added abstract type (`OrderedSamplingAlgorithm`) and composite types 
    (`StartToEnd`, `EndToStart`, `MidpointOutwards`, `ChunksForwards`, `ChunksBackwards`) 
    which indicates how to sample sequential realizations when resampling an uncertain 
    dataset. Only `StartToEnd` is used at the moment.
- Added abstract type `SequentialSamplingConstraint` which is the supertype for all 
    sequential constraints.
- Added function to check if strictly increasing sequences through an uncertain dataset 
    exist: `strictly_increasing_sequence_exists(udata::AbstractUncertainValueDataset`.
- Added function to check if strictly decreasing sequences through an uncertain dataset 
    exist: `strictly_increasing_sequence_exists(udata::AbstractUncertainValueDataset`.
- Added the `StrictlyIncreasing{T} where {T<:OrderedSamplingAlgorithm}` sequential 
    constraint for resampling uncertain datasets. 
- Added the `StrictlyDecreasing{T} where {T<:OrderedSamplingAlgorithm}` sequential 
    constraint for resampling uncertain datasets. 
- Added resampling methods

    1. `resample(udata, sequential_constraint::StrictlyIncreasing{T} where {T <: StartToEnd}`
    2. `resample(udata, sequential_constraint::StrictlyDecreasing{T} where {T <: StartToEnd}`
    3. `resample(udata, constraint::SamplingConstraint, sequential_constraint::StrictlyIncreasing{T} where {T <: StartToEnd}`
    4. `resample(udata, constraint::SamplingConstraint, sequential_constraint::StrictlyDecreasing{T} where {T <: StartToEnd}`
    5. `resample(udata, constraint::Vector{SamplingConstraint}, sequential_constraint::StrictlyIncreasing{T} where {T <: StartToEnd}`
    6. `resample(udata, constraint::Vector{SamplingConstraint}, sequential_constraint::StrictlyDecreasing{T} where {T <: StartToEnd}`

### Improvements 
- Added [documentation on sequential constraints]("sampling_constraints/sequential_constraints.md"), clearly separating it from the general constraints. 


## UncertainData.jl v0.1.4

### Breaking changes 
- Elementary operations for `(scalar, uncertain_value)`, `(uncertain_value, scalar)` and 
    `(uncertain_value, uncertain_value)` pairs now returns an uncertain value instead of 
    a vector of resampled realizations. The default behaviour is to perform a kernel 
    density estimate over the vector of results of the element-wise operations (which 
    was previously returned without representing it as an uncertain value).

### New functionality 
- Implemented constraints for datasets that have already been constrained. 
    `constrain(udata::ConstrainedDataset, s::SamplingConstraint)` will now return another 
    `ConstrainedDataset`. The same applies for `ConstrainedIndexDataset` and 
    `ConstrainedValueDataset`.
- Added `maximum(Vector{AbstractUncertainValue})` and 
    `minimum(Vector{AbstractUncertainValue})` methods.
- Added plot recipe for `Vector{AbstractUncertainValue}`s. Behaves just as plotting an
    uncertain dataset, assuming an implicit indices `1:length(v)`. Error bars may be 
    tuned by providing a second argument of quantiles to `plot`, e.g. `plot(v, [0.2, 0.8]`
    gives error bars covering the 20th to 80th percentile range of the data.

### Improvements 
- Added documentation for `StrictlyIncreasing` and `StrictlyDecreasing` sampling 
    constraints.
- Added `show` function for `AbstractUncertainIndexDataset`. `show` errored previously, 
    because it assumed the default behaviour of `AbstractUncertainValueDataset`, which 
    does not have the `indices` field.

### Bug fixes
- Fixed bug when resampling an uncertain dataset using the `NoConstraint` constraint, 
    which did not work to due to a reference to a non-existing variable.
- Fixed test bug where when resampling an uncertain value with the `TruncateStd` sampling
    constraint, the test compared the result to a fixed scalar, not the standar deviation 
    of the value. This sometimes made the travis build fail.


## UncertainData.jl v0.1.3

### New functionality 
- Allow both the `indices` and `values` fields of `UncertainIndexValueDataset` to be any 
    subtype of `AbstractUncertainValueDataset`. This way, you don't **have** to use an 
    index dataset type for the indices if not necessary.

### Improvements 
- Improved documentation for `UncertainIndexDataset`, `UncertainValueDataset`, 
    `UncertainDataset` and `UncertainIndexValueDataset` types and added an 
    [overview page](uncertain_datasets/uncertain_datasets_overview.md) in the documentation 
    to explain the difference between these types.
- Added an [overview](resampling/resampling_overview.md) section for the resampling 
    documentation.
- Cleaned and improved [documentation for uncertain values](uncertain_values/uncertainvalues_overview.md). 
- Added separate [documentation for the uncertain index dataset type](uncertain_datasets/uncertain_index_dataset.md).
- Added separate [documentation for the uncertain value dataset type](uncertain_datasets/uncertain_value_dataset.md).
- Improved [documentation for the generic uncertain dataset type](uncertain_datasets/uncertain_dataset.md) 
- Merged documentation for sampling constraints and resampling.
- Added missing documentation for the `sinc`, `sincos`, `sinpi`, `cosc` and `cospi` trig 
    functions.

## UncertainData.jl v0.1.2

### New functionality
- Support [elementary mathematical operations](mathematics/elementary_operations.md) 
    (`+`, `-`, `*` and `/`) between arbitrary 
    uncertain values of different types. Also works with the combination of scalars and 
    uncertain values. Because elementary operations should work on arbitrary uncertain 
    values, a resampling approach is used to perform the mathematical operations. This 
    means that all mathematical operations return a vector containing the results of 
    repeated element-wise operations (where each element is a resampled draw from the 
    furnishing distribution(s) of the uncertain value(s)). The default number of 
    realizations is set to `10000`. This allows calling `uval1 + uval2` for two uncertain 
    values `uval1` and `uval2`. If you need to tune the number of resample draws to `n`, 
    you need to use the `+(uval1, uval2, n)` syntax (similar for the operators). In the 
    future, elementary operations might be improved for certain combinations of uncertain
    values where exact expressions for error propagation are now, for example using the 
    machinery in `Measurements.jl` for normally distributed values.
- Support for [trigonometric functions] (mathematics/trig_functions.md) added (`sin`, `sind`, `sinh`, `cos`,
    `cosd`, `cosh`, `tan`, `tand`, `tanh`, `csc`, `cscd`, `csch`, `csc`, `cscd`, `csch`, 
    `sec`, `secd`, `sech`, `cot`, `cotd`, `coth`, `sincos`, `sinc`, `sinpi`, `cosc`, 
    `cospi`). Inverses are also defined (`asin`, `asind`, `asinh`, `acos`,
    `acosd`, `acosh`, `atan`, `atand`, `atanh`, `acsc`, `acscd`, `acsch`, `acsc`, `acscd`, 
    `acsch`, `asec`, `asecd`, `asech`, `acot`, `acotd`, `acoth`).
    Beware: if the support of the funishing distribution for an uncertain value lies partly 
    outside the domain of the function, you risk encountering errors.
    These also use a resampling approach, using `10000` realizations by default. 
    Use either the `sin(uval)` syntax for the default, and `sin(uval, n::Int)` to tune the 
    number of samples.
- Support non-integer multiples of the standard deviation in the `TruncateStd` sampling 
    constraint.

### Fixes 
- Fixed bug in resampling of index-value datasets, where the `n` arguments wasn't used. 
- Bugfix: due to `StatsBase.std` not being defined for `FittedDistribution` instances, 
    uncertain values represented by `UncertainScalarTheoreticalFit` instances were not 
    compatible with the `TruncateStd` sampling constraint. Now fixed!
- Added missing `resample(uv::AbstractUncertainValue, constraint::TruncateRange, n::Int)` 
    method.

### Improvements 
- Improved resampling documentation for `UncertainIndexValueDataset`s. Now shows 
    the documentation for the main methods, as well as examples of how to use different 
    sampling constraints for each individual index and data value.
- Improved resampling documentation for `UncertainDataset`s. Now shows 
    the documentation for the main methods.


## UncertainData.jl v0.1.1

### New functionality 
- Indexing implemented for `UncertainIndexValueDataset`. 
- Resampling implemented for `UncertainIndexValueDataset`.
- Uncertain values and uncertain datasets now support `minimum` and `maximum`.
- `support(uv::AbstractUncertainValue)` now always returns an interval from 
    [IntervalArithmetic.jl](https://github.com/JuliaIntervals/IntervalArithmetic.jl/)
- `support_overlap` now computes overlaps also for fitted theoretical distributions.
- Added more plotting recipes. 
- All implemented uncertain data types now support resampling. 

### Improvements
- Improved general documentation. Added a reference to [
    Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl) and an explanation 
    for the differences between the packages.
- Improved resampling documentation with detailed explanation and plots.


## UncertainData.jl v0.1.0

- Basic functionality in place.
