# file path constants
BLOB_URL <- Sys.getenv("BLOB_URL")
AZURE_KEY <- Sys.getenv("AZURE_KEY")
CONTAINER_NAME <- 

# Define path to the wolf data
wolf_geojson <- "https://geodataservices.wdfw.wa.gov/arcgis/rest/services/WP_Statewide/Wolf_PackPolygons/MapServer/1/query?outFields=*&where=1%3D1&f=geojson"

# create blob endpoint

# Blob Endpoint
blob_endp <- blob_endpoint(BLOB_URL,
                           key = AZURE_KEY)



# Container connection - visualizations data
container <- blob_container(blob_endp, 
                            CONTAINER_NAME )
