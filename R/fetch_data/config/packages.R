# install pacman if it isn't already
suppressWarnings(
  if(!require("pacman",
              warn.conflicts = FALSE,
              quietly = TRUE)){ install.packages("pacman")}
)


# load packages using pacman
suppressWarnings(
  pacman::p_load("AzureStor",
                 "lubridate",
                 "sf" ))
