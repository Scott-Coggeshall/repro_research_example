# read in Excel file with data and clean it
tidy_excel <- function(file_path){
  
  
  data_tbl <- xlsx_cells(file_path)
  

  dat <- data_tbl %>% behead("up-left", "swab_number") %>% behead("up", "plate_number") %>% 
    behead("left", "swab_type") %>% select(swab_type, swab_number, plate_number, numeric)
  
  dat
  
}


clean_data <- function(uncleaned_data){
  
  # add unique id for each swab 
  dat$id <- rep(1:(nrow(dat)/2), each = 2)
  
  # remove "Plate " prefix but set plate_number as factor
  dat$plate_number <- factor(gsub("Plate ", "", dat$plate_number))
  
  # set swab_type as factor and re-level so that Copan Floq is 
  # reference level
  
  dat$swab_type <- factor(dat$swab_type)
  dat$swab_type <- relevel(dat$swab_type, "Copan Floq")
  
  dat
  
  
}