# CDHU #
Project to clean and analyse data from CDHU Sao Paulo

* Folders 
  * data - json files extracted from http://www.sihab.emplasageo.sp.gov.br/#
  * rda - r data of the read files  
  * results - csv files of tidy files

* Files
  * CDHU.Rproj - file of the project
  * save_rjson.R - saves the read json files into rda
  * tidy_json.R - saves the tidy json into rda and results
    * creates id, cleans description, counts variables inside description and separates type/source from description
    * separates type from source, separates source from source year, separates description into var names and values and discards icon, feature and count of var
    * selects only the value columns and set names
    * saves the tidy json into rda and results
