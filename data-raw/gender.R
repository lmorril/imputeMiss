## code to prepare `gender` dataset goes here
library(readr)
gender = read_csv("data-raw/gender.csv")
sinew::makeOxygen(gender, add_fields = "source")

usethis::use_data(gender, overwrite = TRUE)
