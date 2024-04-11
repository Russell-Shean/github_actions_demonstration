# load packages
source("R/fetch_data/config/packages.R")

#load file paths
source("R/fetch_data/config/file_paths.R")


# read in the data 
raw_wolves <- sf::st_read(wolf_geojson)

# drop geometry attribute from dataset
wolves_df <- raw_wolves |> 
  sf::st_drop_geometry()



# write the wolves dataset to file as a csv
temp_file <- tempfile()
write.csv(wolves_df, temp_file)



# upload the wolves dataset to the Azure blob

upload_time <- Sys.time() |> 
  lubridate::with_tz("America/Los_Angeles") |>
  format("%Y-%m-%d_%H-%M-%S")

#upload an archived version
upload_blob(container,
            src = temp_file,
            dest = paste0("raw_data/",
                          "wolf_packs_",
                          upload_time,
                          ".csv"))

#overwrite with the most recent version
upload_blob(container,
            src = temp_file,
            dest = paste0("raw_data/wolf_packs.csv"))

