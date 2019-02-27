# Libraries   ----
library(tidyverse)
library(jsonlite)

# Getting file names    ----
files <- list.files("data", pattern=".json")
fileNames <- str_replace(files, ".json", "")
files <- paste("data/", files, sep="")

# Reading json files    ----

# reads json
df <- lapply(files, function(x){
    y <- as.data.frame(fromJSON(x))
    names(y) <- c("status", "geometry", "description", "feature", "icon")
    return(y)
    })

names(df) <- fileNames

# Saving rda ----
save(df, file = "rda/jsons.rda")
