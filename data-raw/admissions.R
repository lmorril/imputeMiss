## code to prepare `admissions` dataset goes here
library(readr)
admissions = read_csv("data-raw/admissions.csv")


usethis::use_data(admissions, overwrite = TRUE)
