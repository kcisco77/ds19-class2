# Functions to fetch public Biketown trip data
# https://www.biketownpdx.com/system-data

# pacman allows checking for and isntalling missing packages
if (!require("pacman")) {install.packages("pacman)")}; library(pacman)
pacman::p_load("lubridate")
pacman::p_load("dplyr")
pacman::p_load("stringr")
pacman::p_load("readr")

# another way to do same thing using base r
#pkgs <- c("lubridate", "dplyr" , "stringer", "readr")
#install.packages(pkgs)

get_data <- function (start="7/2016", end=NULL, 
                      base_url="https://s3.amazonaws.com/biketown-tripdata-public/",
                      outdir="data/biketown/") {
  # takes start and end in mm/yyyy format, and tries to download resulting files
  
  # if no end date given, set to now
  end <- ifelse(is.null(end), format(now(), "%m/%Y"), end)
  
  # make url function only available within get_data
  make_url <- function(date, base_url) {
    url <- paste0(base_url, format(date, "%Y_%m"), ".csv")
    return(url)
  }
  
  # parse date range
  start_date <- lubridate::myd(start, truncated = 2)
  end_date <- myd(end, truncated = 2)
  date_range <- seq(start_date, end_date, by="months")
  
  # lapply(a, b) just applies function b to sequence a and 
  # reutrns a list of the modified sequence
  urls <- lapply(date_range, make_url, base_url=base_url)
  
  # for loops can be easier for early development of code
  for (u in urls) {
    download.file(u, destfile = paste0(outdir, 
                                       str_sub(u, -11)))
  }
 }

### Manual Run ###
#params
# start = "11/2018"
# end = "8/2018"
# 
# get_data(start)
