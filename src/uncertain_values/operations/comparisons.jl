import Base.<
import Base.isapprox

Base.:<(x::T1, y::CertainScalar{T2}) where {T1 <: Real, T2 <: Real} = x < y.value
Base.:<(x::CertainScalar{T1}, y::T2) where {T1 <: Real, T2 <: Real} = x.value < y
Base.isless(x::CertainScalar{T1}, y::CertainScalar{T2}) where {T1 <: Real, T2 <: Real} = isless(x.value, y.value)
Base.isapprox(x::CertainScalar{T1}, y::T2) where {T1 <: Real, T2 <: Real} = isapprox(x.value, y)
Base.isapprox(x::T1, y::CertainScalar{T2}) where {T1 <: Real, T2 <: Real} = isapprox(x, y.value)
