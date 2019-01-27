# Test interpolation methods
x = 1:10 
y = rand(10)
xgrid = 0:0.5:10 

# Test that interpolation functions work
y_intp = linear_interpolation(x, y, xgrid)

@test length(y_intp) == length(xgrid)
@test y_intp isa Vector{Float64}

# Test that interpolation work for uncertain index-value datasets
timeinds = [UncertainValue(Normal, i, 0.1) for i = 1:5]
measurements = [UncertainValue(Gamma, i, i + rand(1:2)) for i = 1:5]

d = UncertainIndexValueDataset(timeinds, measurements)
grid = RegularGrid(0, 5, 0.4)

@test length(resample(d, grid)) == 2
@test length(resample(d, StrictlyIncreasing(), grid)) == 2
