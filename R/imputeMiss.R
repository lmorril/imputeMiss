

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

