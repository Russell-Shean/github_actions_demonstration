# Github Actions Demonstration
This repository shows how Github Actions can be used to automatically execute data processing scripts on a schedule. The scheduled scripts read data in from azure blob storage, execute an R script to process the data, and save the processed data back to azure

# What This Demonstration Shows
This demonstration shows how Github Actions:
1. Can load data stored on a secure Azure Storage Blob
2. Can execute an R script to process data
3. Can save the proccessed data back to a secure Azure Storage Blob
4. Can be scheduled to automatically run steps 1-3 on a pre-defined schedule

# Why this is cool
This is cool because:
1. Automation: We can reliably schedule data processing pipelines to run automatically on a cloud environment. Scripts can be scheduled outside of working hours and don't slow down a user's laptop. 
2. Security: Secrets, such as the Azure API key,  can be stored securely using <a href="https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions">repository secrets</a>.
3. Reproducibility: The R script is run on a virtual machine with only the software defined in the YAML file. The R scripts will always execute in the exact same operating system environment with the same installed software and same installed software. This eliminates the "works on my computer" problem.

# How this works
## Overview
This proof of concept takes data stored in an azure blob, automatically processes it and save the output back to the azure blob. The entire data process is run on the cloud using github actions and runs automatically every day at 3am, 4 am, and 5am. The pipeline also runs every time new code is added to the repository. The schedule and trigger conditions are easy to change. The entire data processing pipeline is written in R, a language we already use extensively. The R code does not need to be modified like in databricks; existing code can be run directly. The github action is defined in a short .yml file using a simple easy-to-learn syntax.

For this example data is stored in the following azure blob: https://sadohpowerbi.blob.core.windows.net/test-gha             
This is what the blob storage looks like:           
![image](https://github.com/DOH-EPI-Coders/wolves_of_github/assets/119683040/80850aad-1a3f-4446-ae3c-206d7d225aee)        

This is what the raw data looks like:           
![image](https://github.com/DOH-EPI-Coders/wolves_of_github/assets/119683040/ea0a3ce0-c3d2-4397-8cb7-70ac1c70c2e0)              

The data is taken from a publicly available WA Dept of Fish and Wildlife dataset of wolf pack locations in Washington State: https://geo.wa.gov/datasets/0c4006dd46e44b67b69fe097b4f92b5b_0

The github action launches an ubuntu virtual machine, installs R and other required software, runs an R script to process then saves the data to the azure blob storage. The Azure API key and other sensitive credentials are stored securely using GitHub <a href="https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions ">secrets</a> and are never visible in the repository. In this example, all the R script does is load the data from azure, filter the dataset so it only contains wolf packs with a single wolf, and then saves the processed data to azure, but much more complicated data processing scripts would be easy to automate in the same way using GitHub Actions.         

Here's what the Azure blob  with all the processed data looks like. All of these datasets  were processed and saved automatically. All of the datasets uploaded between 2am and 5am are from scheduled runs that run automatically every day.        
![image](https://github.com/DOH-EPI-Coders/wolves_of_github/assets/119683040/bafe2540-6bbc-45ac-b951-7628455dbae9)           

Here's what the processed data looks like:       
![image](https://github.com/DOH-EPI-Coders/wolves_of_github/assets/119683040/abd8156c-9178-4001-9d95-3ddc30ca5429)              

Github actions, automatically logs the job and records outputs and any errors. Here's what that looks like:           
![image](https://github.com/DOH-EPI-Coders/wolves_of_github/assets/119683040/d957d175-5258-45fb-b42f-b8b6410f8cc8)                          
          
<hr>                  
            
![image](https://github.com/DOH-EPI-Coders/wolves_of_github/assets/119683040/0c815215-f283-4ff6-9aec-450ce3147790)                              
          
<hr>          

![image](https://github.com/DOH-EPI-Coders/wolves_of_github/assets/119683040/3d900a5f-3261-41f1-a511-f82e163f1226)                

This Github Action also automatically creates a log file and saves it to the repository. <a href="https://github.com/DOH-EPI-Coders/wolves_of_github/tree/main/logs/log">Here</a>'s where the logs are stored. Here's what the logs looks like:                

![image](https://github.com/DOH-EPI-Coders/wolves_of_github/assets/119683040/68f2811e-7768-4777-9be6-8e42b53f8544)          

If a run fails, Github Actions automatically sends an email notification:           

![image](https://github.com/DOH-EPI-Coders/wolves_of_github/assets/119683040/4737668c-2729-43e9-9182-fd7b8c79b9fc)          

It's easy to see where the error occured in the job status page:          

![image](https://github.com/DOH-EPI-Coders/wolves_of_github/assets/119683040/9781402b-8fdb-4677-bf2e-bc7adc27cb1f)                        
         
<hr>          

![image](https://github.com/DOH-EPI-Coders/wolves_of_github/assets/119683040/813f0485-90f9-4c71-b71f-6982d1ad5495)





# Why this is cool
- This gives us a fully cloud-based solution right now without having to wait for Posit Workbench, Cedar, or Databricks.
- Existing R code can be run without modification
- Code is run on a clean environment allowing for reproducibility and eliminating the risk of errors caused by different versions of R, R packages, or operating systems. The virtual machine and the software on it are exactly the same every time. 
- We can schedule the entire data processing pipeline to run on a schedule in a much more reliable way than we could on task scheduler
- If a run fails,  Github automatically sends out a notification email. Github actions automatically generates an error log so it's easy to troubleshoot
- We can automatically test our code each time a change is commited to the repository
- GitHub Actions an industry standard tool for continous integration and development (CI/CD) and facilitates agile development and test-driven development
- There's so much more than can be down with this. There are github actions to send emails, update websites, deploy apps, build models, etc.
- Easy to learn! Way simpler than batch scripts :D

# Potential downsides
- Cost: DOH already has an alloted amount of GitHub action minutes.  We're currently way under the allotment, but if multiple teams build production pipelines using GitHub Actions, we may need a larger allotment.
- Data Security: The data is never stored in the github repository, the github actions virtual machine and the code repository is never publicly accesible, and API creditentials are securely stored and handled, however it's not clear if Github Actions has ever been evaluated or approved for processing sensitive data by OIT.
- OIT approval: Even if cost and data security concerns can be resolved, OIT will almost certainly still need to evaluate and approve this type of use of GitHub Actions. Approval could take some time. 


<hr>       

## Details
Here are some more details about how this process work.        
All the automatic steps that Github Actions run are defined in this file: https://github.com/DOH-EPI-Coders/wolves_of_github/blob/main/.github/workflows/run_R_code.yml        

## Step 1: Define when the action should run
This action is set up to run whenever anyone commits new code to the main branch of the repository. There are a variety of other triggers that could be used: https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows
```{yml}
on:
  push:
    branches: main
```
This GitHub action also runs automatically on a shedule. Here are two links describing how to set up the schedule:  https://medium.com/tradeling/how-to-schedule-jobs-using-github-actions-9f32667706ea, https://jasonet.co/posts/scheduled-actions/
```{yml}
# run the job at a scheduled time
# This is 9 AM UTC which should correspond to 2 am in Seattle
  schedule:
  - cron: "0 9 * * *"
  # run again at 3 am and 4 am
  - cron: "0 10 * * *"
  - cron: "0 11 * * *"
```

## Step 2: Set up a virtual machine
This action runs on an ubuntu virtual machine
```{yml}
jobs:
  import-data:
    runs-on: ubuntu-latest
```

## Step 3: Install R
The action then installs R and all its dependencies
```{yml}
      - name: Set up R
        uses: r-lib/actions/setup-r@v2

      - name: Install linux dependencies
        run: sudo apt-get install libcurl4-openssl-dev libharfbuzz-dev libfribidi-dev

```

## Step 4: checkout files
The action then loads all the code stored in the repository onto the virtual machine
```{yml}

      - name: Check out repository
        uses: actions/checkout@v4


```

## Step 5: Load environmental variables
Github has a way to securely store secrets.        
https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions         
These secrets can then be securely loaded onto the the virtual machine for use in subsequent steps         
```{yml}
     env: 
          AZURE_KEY: ${{ secrets.AZURE_KEY }}
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          GH_PAT: ${{ secrets.GH_PAT }}


```

## step 6: execute R script
The R script does all the actual data processing. It starts by loading several packages and performing a variety of configuration steps. The R script then loads the data in from the Azure blob storage

```{r}
library(AzureStor)

# create temporary file
temp_file <- tempfile()

# Download data from blob storage to temporary file located on virtual machine
storage_download(container,
              src = paste0(azure_input_paths$raw_data, "/wa_wolfs.csv"),
              dest = temp_file)


# read the data from the temp file into R on the virutal machine
wolfs3 <- read.csv(temp_file)


```

The R script then performs some data transformations. In this example it's just a simple filter, but it'd work for our normal complicated R scripts that we write for backend data processing. 

```{r}

# wolf processing
lone_wolfs <- wolfs3 |> filter(PackStatus == "Single Wolf Territory")

print(paste0("There are ", nrow(lone_wolfs), " lone wolves in Washington State!"))
```

Finally the R script saves the proccesed data to a different location on the Azure Blob       
```{r}
# write out lone_wolfs to file
temp_file <- tempfile()

write.csv(lone_wolfs, temp_file)

upload_time <- Sys.time() |> 
  lubridate::with_tz("America/Los_Angeles") |>
  format("%Y-%m-%d_%H-%M-%S")


upload_blob(container,
            src = temp_file,
            dest = paste0(azure_output_paths$data,
            "lone_wolfs_",
            upload_time,
            ".csv"))


```
