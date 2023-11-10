test_that("Testing function", {
  example1 <- data.frame(obs = sort(rnorm(n = 100)),
                         pred = c(sort(rnorm(n = 99, mean = 0.6, sd = 1)), NA))
  example1 <- base_metrics(example1, correlation = "pearson")
  expect_equal(example1,
               "Please remove missing and non-numeric values from the predictions and observations")

  example2 <- data.frame(obs = sort(rnorm(n = 100)),
                         pred = c(sort(rnorm(n = 99, mean = 0.6, sd = 1)), "AB"))
  example2 <- base_metrics(example2, correlation = "pearson")
  expect_equal(example2,
               "Please remove missing and non-numeric values from the predictions and observations")

  example3 <- data.frame(obs = sort(rnorm(n = 100)),
                         pred = c(sort(rnorm(n = 99, mean = 0.6, sd = 1)), "0.3"))
  example3 <- base_metrics(example3, correlation = "spearman")
  expect_equal(dim(example3), c(3,2))
  expect_true(is.numeric(example3$score))
  expect_true(is.character(example3$score_name))
})
