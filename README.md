
# imputeMiss

<!-- badges: start -->
<!-- badges: end -->

<img src="pic.jpeg" width="300"/>

The goal of imputeMiss is to make imputing missing data easier in all datasets. Dealing with missing data is a long, and often overwhelming process. This function offers flexibility for the user to quickly impute missing values in their datasets. This functions behaves differently depending on the proportion of missing data by observation.

## Installation

You can install the development version of imputeMiss from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("lmorril/imputeMiss")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(imputeMiss)
library(qacBase)
imputeMiss(tv, method = "median")
```

