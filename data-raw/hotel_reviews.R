## code to prepare `hotel_reviews` dataset goes here
library(readr)
hotel_reviews = read_csv("data-raw/hotel_reviews.csv")


usethis::use_data(hotel_reviews, overwrite = TRUE)
