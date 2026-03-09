// Weibull OR Gate Model
// System lifetime = min(T1, T2)
// Independent Weibull components

data {
  int<lower=1> N;
  vector<lower=0>[N] t;
}

parameters {
  real<lower=0> beta1;   // shape component 1
  real<lower=0> eta1;    // scale component 1

  real<lower=0> beta2;   // shape component 2
  real<lower=0> eta2;    // scale component 2
}

model {

  // Weakly informative priors
  beta1 ~ lognormal(0, 1);
  beta2 ~ lognormal(0, 1);
  eta1  ~ lognormal(0, 1);
  eta2  ~ lognormal(0, 1);

  for (n in 1:N) {

    // Component hazards
    real h1 = (beta1 / eta1) *
              pow(t[n] / eta1, beta1 - 1);

    real h2 = (beta2 / eta2) *
              pow(t[n] / eta2, beta2 - 1);

    // System hazard
    real h_sys = h1 + h2;

    // Cumulative system hazard (numerically stable)
    real H_sys =
        pow(t[n] / eta1, beta1)
      + pow(t[n] / eta2, beta2);

    // Log-likelihood
    target += log(h_sys) - H_sys;
  }
}

