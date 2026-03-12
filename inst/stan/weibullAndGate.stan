// and_gate.stan
data {
  int<lower=0> N;          // number of observed system failures
  vector<lower=0>[N] t;    // observed failure times (max of two components)
}

parameters {
  real<lower=0> beta1;     // shape 1
  real<lower=0> eta1;      // scale 1
  real<lower=0> beta2;     // shape 2
  real<lower=0> eta2;      // scale 2
}

model {
  // Priors
  beta1 ~ normal(1, 1) T[0,];
  eta1  ~ normal(100, 50) T[0,];
  beta2 ~ normal(1, 1) T[0,];
  eta2  ~ normal(100, 50) T[0,];

  // Likelihood
  for (i in 1:N) {
    real f1 = (beta1 / eta1) * pow(t[i] / eta1, beta1 - 1) * exp(-pow(t[i] / eta1, beta1));
    real F1 = 1 - exp(-pow(t[i] / eta1, beta1));
    real f2 = (beta2 / eta2) * pow(t[i] / eta2, beta2 - 1) * exp(-pow(t[i] / eta2, beta2));
    real F2 = 1 - exp(-pow(t[i] / eta2, beta2));

    real f_sys = f1 * F2 + f2 * F1;

    target += log(f_sys);
  }
}
