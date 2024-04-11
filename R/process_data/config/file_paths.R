# file path constants
BLOB_URL <- Sys.getenv("BLOB_URL")
AZURE_KEY <- Sys.getenv("AZURE_KEY")
CONTAINER_NAME <- Sys.getenv("CONTAINER_NAME")


# create blob endpoint

# Blob Endpoint
blob_endp <- blob_endpoint(BLOB_URL,
                           key = AZURE_KEY)



# Container connection - visualizations data
container <- blob_container(blob_endp, 
                            CONTAINER_NAME )
