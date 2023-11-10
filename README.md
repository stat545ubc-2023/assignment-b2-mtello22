
<!-- README.md is generated from README.Rmd. Please edit that file -->

# evaluate.regressor

<!-- badges: start -->
<!-- badges: end -->

The goal of evaluate.regressor is to provide tools to evaluate
supervised regressor outputs.

## Installation

You can install the development version of evaluate.regressor from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("stat545ubc-2023/evaluate.regressor")
```

## Example

This is a basic example which shows you how to evaluate a simple
regressor:

``` r
library(evaluate.regressor)

# Evaluate a data.frame with at least two columns
my_pred <- data.frame(obs = sort(rnorm(n = 100)), 
                      pred = sort(rnorm(n = 100, mean = 0.6, sd = 1)))

# Evaluate using Spearman correlation 
base_metrics(my_pred, correlation = "spearman")
#>             score_name     score
#> 1                 RMSE 0.7924398
#> 2            r_squared 0.4163609
#> 3 spearman_correlation 1.0000000
```

The function `base_metrics` calculates a given correlation score
(‘Spearman’, ‘Pearson’ or ‘Kendall’), root mean square error (RMSE), and
R-squared.
