# process data
# This file:
#    1. loads the raw data from azure blob storage
#    2. Filters the data a simple demonstration of how R scripts can be executed on GHA
#    3. Saves the data back to the azure  blob

# load packages
source("R/process_data/config/packages.R")

#load file paths
source("R/process_data/config/file_paths.R")


# read in the data 
temp_file <- tempfile()

# download the file from the blob 
# onto the GHA runner
# (This will disapear after the job is complete)
storage_download(container,
                 src = paste0("raw_data/wolf_packs.csv"),
                 dest = temp_file)

# read in the data
wolf_packs <- read.csv(temp_file)

# filter the data
lone_wolves <- wolf_packs |>
  filter(PackStatus == "Single Wolf Territory")


print(paste0("There are ", nrow(lone_wolves), " single wolf packs in Washington State!"))



# write the wolves dataset to file as a csv
temp_file <- tempfile()
write.csv(lone_wolves, temp_file)



# upload the wolves dataset to the Azure blob

upload_time <- Sys.time() |> 
  lubridate::with_tz("America/Los_Angeles") |>
  format("%Y-%m-%d_%H-%M-%S")

# archived version
upload_blob(container,
            src = temp_file,
            dest = paste0("proccesed_data/",
                          "lone_wolves_",
                          upload_time,
                          ".csv"))

#overwrite most recent version
upload_blob(container,
            src = temp_file,
            dest = paste0("proccesed_data/lone_wolves.csv"))