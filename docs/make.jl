
using Documenter
using DocumenterMarkdown
using UncertainData
using Distributions
using KernelDensity
using StatsBase
using Measurements
using Interpolations

PAGES = [
    "index.md",
    "Uncertain values" => [
        "uncertain_values/uncertainvalues_examples.md",
        "uncertain_values/uncertainvalues_overview.md",
        "uncertain_values/uncertainvalues_kde.md",
        "uncertain_values/uncertainvalues_fitted.md",
        "uncertain_values/uncertainvalues_theoreticaldistributions.md",
        "uncertain_values/uncertainvalues_certainvalue.md",
        "uncertain_values/uncertainvalues_populations.md",
        "uncertain_values/uncertainvalues_Measurements.md",
        "uncertain_values/merging.md"
    ],
	"Uncertain datasets" => [
        "uncertain_datasets/uncertain_datasets_overview.md",
        "uncertain_datasets/uncertain_index_dataset.md",
        "uncertain_datasets/uncertain_value_dataset.md",
        "uncertain_datasets/uncertain_dataset.md",
        "uncertain_datasets/uncertain_indexvalue_dataset.md"
	],
    "Uncertain statistics" => [
        "Core statistics" => [
            "uncertain_statistics/core_stats/core_statistics.md",
            "uncertain_statistics/core_stats/core_statistics_point_estimates.md",
            "uncertain_statistics/core_stats/core_statistics_pairwise_estimates.md",
            "uncertain_statistics/core_stats/core_statistics_datasets_single_dataset_estimates.md",
            "uncertain_statistics/core_stats/core_statistics_datasets_pairwise_estimates.md",
            "uncertain_statistics/core_stats/core_statistics_datasets.md"
        ],

        "Hypothesis tests" => [
			"uncertain_statistics/hypothesistests/hypothesis_tests_overview.md",
            "uncertain_statistics/hypothesistests/one_sample_t_test.md",
            "uncertain_statistics/hypothesistests/equal_variance_t_test.md",
            "uncertain_statistics/hypothesistests/unequal_variance_t_test.md",
            "uncertain_statistics/hypothesistests/exact_kolmogorov_smirnov_test.md",
            "uncertain_statistics/hypothesistests/approximate_twosample_kolmogorov_smirnov_test.md",
            "uncertain_statistics/hypothesistests/jarque_bera_test.md",
            "uncertain_statistics/hypothesistests/mann_whitney_u_test.md",
            "uncertain_statistics/hypothesistests/anderson_darling_test.md"
        ],
    ],
    "Sampling constraints" => [
        "sampling_constraints/available_constraints.md",

        "sampling_constraints/constrain_uncertain_values.md",

        "sampling_constraints/ordered_sequence_exists.md",
        "sampling_constraints/sequential_constraints.md"
    ],
    "Resampling" => [
        "resampling/resampling_overview.md",
        "resampling/resampling_uncertain_values.md",
        "resampling/resampling_uncertain_datasets.md",
        "resampling/resampling_uncertain_indexvalue_datasets.md",

        "resampling/sequential/resampling_uncertaindatasets_sequential.md",
        "resampling/sequential/resampling_indexvalue_sequential.md",
        "resampling/sequential/strictly_increasing.md",
        "resampling/sequential/strictly_decreasing.md",

        "resampling/interpolation/interpolation.md",
        "resampling/interpolation/gridded.md",
        "resampling/resampling_schemes/resampling_schemes_uncertain_value_collections.md",
        "resampling/resampling_schemes/resampling_schemes_uncertain_indexvalue_collections.md",
        "resampling/resampling_schemes/resampling_with_schemes_uncertain_value_collections.md",
        "resampling/resampling_schemes/resampling_with_schemes_uncertain_indexvalue_collections.md",
        "resampling/resampling_inplace.md"
        #"resampling/models/resampling_with_models.md"
    ],

    "Propagation of errors" => [
        "propagation_of_errors/propagation_of_errors.md"
    ],
    
    "Mathematics" => [
        "mathematics/elementary_operations.md",
        "mathematics/trig_functions.md"
    ],

    "Tutorials" => [
        "tutorials/tutorial_overview.md",
        "tutorials/tutorial_transforming_data_to_regular_grid.md"
    ],

    "implementing_algorithms_for_uncertaindata.md",
    
    "changelog.md",

    "publications.md",

    "citing.md"
]

makedocs(
    modules = [UncertainData],
    sitename = "UncertainData.jl documentation",
    format = Markdown(),
    pages = PAGES
)

if !Sys.iswindows()
    deploydocs(
        deps   = Deps.pip("mkdocs==0.17.5", "mkdocs-material==2.9.4",
        "python-markdown-math", "pygments", "pymdown-extensions"),
        repo   = "github.com/kahaaga/UncertainData.jl.git",
        target = "site",
        make = () -> run(`mkdocs build`)
    )
end
