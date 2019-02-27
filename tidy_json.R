# Libraries   ----
library(tidyverse)
library(jsonlite)
library(rebus)

# Reading rda json files    ----

# load rda json
load("rda/jsons.rda")

# Tidying json files    ----

df2 <- lapply(df, function(x){
    
    # creates id, 
    # cleans description,
    # counts # variables inside description
    # separates type/source from description
    y <- x %>%
        mutate(id = 1:length(description), 
               description = 
                   str_replace_all(description,
                                   pattern = or("<b>", "</b>", "<h3>"), 
                                   replacement = ""),
               ct = str_count(description, pattern="<br/>")) %>%
        separate(description, into = c("type", "description"), sep = "</h3>")
    
    # number of var
    nVar <- unique(y$ct)+1
    # temp var names
    cl <- paste("V", rep(1:nVar, each=2), c(1, 2), sep="_")
    
    # separates type from source
    # separates source from source year
    # separates description into var names and values
    # discards icon, feature and count of var
    y2 <- y %>%
        separate(type, into = c("type", "source"), sep="\\. ") %>%
        separate(source, into = c("source", "sYear"), sep="\\, ") %>%
        separate(description, 
                 into = cl,
                 sep = or(":", "<br/>")) %>%
        select(-c(icon, feature, ct))
    
    # names of the columns with var names
    cols <- paste("V", 1:nVar, 1, sep="_")
    # var names
    colsNam <- c("status", "geometry", "type", "source", "sYear", 
                 as.character((y2 %>% select(cols))[1,]), "id")
    # selects only the value columns and set names
    y3 <- y2 %>% select(-cols)
    names(y3) <- colsNam
    
    return(y3)
})

# Saving files  ----

names <- names(df2)

lapply(names, FUN=function(x){
    write.csv(df2[[x]], paste("results/", x, ".csv"))})

save(df2, file="rda/tidyJson.rda")
