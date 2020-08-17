# read in Excel file with data and clean it
tidy_excel <- function(file_path){
  
  
  data_tbl <- xlsx_cells(file_path)
  

  dat <- data_tbl %>% behead("up-left", "swab_number") %>% behead("up", "plate_number") %>% 
    behead("left", "swab_type") %>% select(swab_type, swab_number, plate_number, numeric)
  
  dat
  
}


clean_data <- function(uncleaned_data){
  
  # add unique id for each swab 
  uncleaned_data$id <- rep(1:(nrow(uncleaned_data)/2), each = 2)
  
  # remove "Plate " prefix but set plate_number as factor
  uncleaned_data$plate_number <- factor(gsub("Plate ", "", uncleaned_data$plate_number))
  
  # set swab_type as factor and re-level so that Copan Floq is 
  # reference level
  
  uncleaned_data$swab_type <- factor(uncleaned_data$swab_type)
  uncleaned_data$swab_type <- relevel(uncleaned_data$swab_type, "Copan Floq")
  
  uncleaned_data <- uncleaned_data %>% rename(count = numeric)
  
  uncleaned_data
  
  
}