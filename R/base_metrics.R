#' base_metrics
#' @description
#' This function calculates three common scores for evaluation of regression models: R-squared, Root Mean Squared Error (RMSE), and a correlation score among "pearson", "kendall", or "spearman". Takes as input a data.frame object with two independent columns for the observed ("obs") and predicted values ("pred").
#'
#' @import dplyr
#' @import magrittr
#' @importFrom stats cor
#'
#' @param df Data frame with the predictions and observations as independent columns. The name was chosen to indicate the input is a data frame object
#' @param correlation Correlation method to pass cor() function. Accepted values: "pearson", "kendall", "spearman". Default NULL.
#' @param pred_name Name of the column containing the predictions. The name was selected to guide the user about what column to select. Default "pred"
#' @param obs_name Name of the column containing the observations or prediction targets The name was selected to guide the user about what column to select. Default "obs".
#' @return A dataframe with two columns: first the name of the score calculated, second the score numeric value.
#' @export
base_metrics <- function(df, correlation = NULL,
                         pred_name = "pred",
                         obs_name = "obs"){
  if(!(correlation %in% c("pearson", "kendall", "spearman"))){
    return("Please specify a valid correlation for the function cor() between: \"pearson\", \"kendall\", or \"spearman\" ")
  }

  # Extract predictions and observations
  predictions <- df %>%
    dplyr::select(dplyr::all_of(pred_name)) %>%
    unlist() %>%
    as.numeric()

  observations <- df %>%
    dplyr::select(dplyr::all_of(obs_name)) %>%
    unlist() %>%
    as.numeric()

  # Verify non missing values in predictions or observations
  if(any(is.na(predictions)) || any(is.na(observations))) {
    return("Please remove missing and non-numeric values from the predictions and observations")
  }

  # Calculate correlation
  correlation_score <- cor(x = predictions, y = observations, method = correlation)

  # Calculate rmse
  rmse_score <- sqrt(mean((observations - predictions)^2))

  # Calculate R-squared
  SSR <- sum((observations - predictions)^2)
  SST <- sum((observations - mean(observations))^2)
  rsquared_score <- 1 - (SSR /SST)

  # Make output data frame
  output <- data.frame(score_name = c("RMSE", "r_squared",
                                      paste(correlation, "correlation",
                                            sep = "_")),
                       score = c(rmse_score, rsquared_score, correlation_score))
  return(output)
}

