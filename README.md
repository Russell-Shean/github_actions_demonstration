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



