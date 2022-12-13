#' Impute Missing Data in  a Dataset
#'
#' Impute a dataframe, with different values depending on proportion and class of observations missing.
#' If a categorical variable is not a factor, character, or logical observation, the function
#' will not impute.
#'
#' @param df A dataframe
#' @param method Method to replace missing data in numerical observations, default is mean, but also can choose "median"
#' @param method_cat Method to replace missing data in categorical observations, default is most frequent, can also select "sample" for random sample.
#'
#' @return A datafame with no missing values in any observation
#' @export
#' @examples
#' \dontrun{
#' ## from 'qacbase' package
#' # library(qacBase)
#' # data(tv)
#' # imputeMiss(tv)
#' # imputeMiss(tv, method = "median", method_cat = "sample")}
imputeMiss <- function(df, method = "mean", method_cat = "frequent"){
  for (col in colnames(df)){
    missing_percentage <- sum(is.na(df[[col]])) / nrow(df)


    if (missing_percentage > 0.05){
      #if numeric, impute based on method and create binary variable columns
      if (is.numeric(df[[col]])){

        median_col <- median(df[[col]], na.rm = TRUE)
        mean_col <- mean(df[[col]], na.rm=TRUE)

        actual_method = ""
        if (method == "median"){

          actual_method = median_col
        } else {
          actual_method = mean_col
        }

        col_na <- ifelse(is.na(df[[col]]),1,0)
        col_imputed <- ifelse(is.na(df[[col]]),actual_method, df[[col]])
        df[[col]] <- col_imputed
        df[,paste0(col, "_na")] <- col_na

      #if factor/categorical, replace missing with "Missing" label
      } else if (is.factor(df[[col]]) || is.logical(df[[col]]) || is.character(df[[col]])){
        col_imputed <- ifelse(is.na(df[[col]]), "Missing", df[[col]])
        df[[col]] <- col_imputed
      }
    }else{
      #if numeric, impute based on method
      if (is.numeric(df[[col]])){

        median_col <- median(df[[col]], na.rm = TRUE)
        mean_col <- mean(df[[col]], na.rm=TRUE)
        actual_method = ""
        if (method == "median"){

          actual_method = median_col
        } else {
          actual_method = mean_col
        }



        col_imputed <- ifelse(is.na(df[[col]]), method, df[[col]])
        df[[col]] <- col_imputed

      #if factor/categorical, replace with most frequent value or random sample
      } else if (is.factor(df[[col]]) || is.logical(df[[col]]) || is.character(df[[col]])){

        sample_col <- sample(df[[col]][!is.na(df[[col]])], size = sum(is.na(df[[col]])), replace = TRUE)
        most_freq_x <- names(which.max(table(df[[col]])))

        actual_method_cat = ""
        if (method_cat == "sample"){
          actual_method_cat = sample_col
        } else {
          actual_method_cat = most_freq_x
        }
        col_imputed <- ifelse(is.na(df[[col]]), actual_method_cat, df[[col]])
        df[[col]] <- col_imputed
      }
    }
  }
  return (df)
}

