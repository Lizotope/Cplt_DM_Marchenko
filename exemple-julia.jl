using Plots
using LinearAlgebra
using Distributions


# Loi normale centrée réduite
loi = Normal(0,1)

N = 2000; 
X = rand(loi,N);

histogram(X,legend=false;xlims=(-5,+5))

μ̂ = SommePartielle = zeros(N)

SommePartielle[1] = X[1];
for i = 2:N
    SommePartielle[i] = SommePartielle[i-1] + X[i];
    μ̂[i] = 1/(i+1)* SommePartielle[i];
end

plot(μ̂,label=false,ylims=(-1,+1))

# Loi sans moyenne - Cauchy
c = Cauchy(0,1)

N = 2000; 
Xc = rand(c,N);

histogram(Xc,legend=false;xlims=(-5,+5))

μ̂ = SommePartielle = zeros(N);

SommePartielle[1] = Xc[1];
for i = 2:N
    SommePartielle[i] = SommePartielle[i-1] + Xc[i];
    μ̂[i] = 1/(i+1)* SommePartielle[i];
end

plot(μ̂,label=false)


# Moyenne empirique 2D

μ = [1, 2]

Σ = [1.0  0.7 ;  0.7  2.0   ];

loi = MvNormal(μ,Σ);

# N-échantillon i.i.d. selon N(µ,∑)

N = 10000;
X = rand(loi,N);

# Marginale 1
histogram(X[1,:], legend=false;xlims=(-4,+5))

# Marginale 2
histogram(X[2,:], legend=false;xlims=(-4,+5))

scatter([X[1,i] for i=1:N],[X[2,i] for i=1:N],label=false,xlims=(-5,+5),ylims=(-5,+5))

# moyenne empirique

S = zeros(2); for i = 1:N S += X[:,i] end; μ̂ =  1/N * S;
# μ̂ = 1/N * sum(X,dims=2)

println("Moyenne empirique : ", μ̂ )

# covariance empirique
S = zeros(2,2); 
for i = 1:N S += (X[:,i]-μ̂) * (X[:,i]-μ̂)' end
Ĉ =  1/(N-1) * S;

println("Covariance empirique : ", Ĉ )

