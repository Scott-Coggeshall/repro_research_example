# read in Excel file with data and clean it
tidy_excel <- function(file_path){
  
  
  data_tbl <- xlsx_cells(file_path)
  

  dat <- data_tbl %>% behead("up-left", "swab_number") %>% behead("up", "plate_number") %>% 
    behead("left", "swab_type") %>% select(swab_type, swab_number, plate_number, numeric, character)
  
  dat
  
}


clean_data <- function(uncleaned_data){
  
  # add unique id for each swab 
  uncleaned_data$id <- rep(1:(nrow(uncleaned_data)/2), each = 2)
  
  
  # strip asterisk and greater than sign from values then convert to numeric
  
  uncleaned_data$character <- as.numeric(gsub(pattern = "\\*|\\*>", replacement = "0",
                                   uncleaned_data$character))
  
  
  # merge character column values into numeric column when numeric is NA
  # and add flag for censored 
  
  uncleaned_data$numeric <- ifelse(!is.na(uncleaned_data$numeric), uncleaned_data$numeric, 0) +
                             ifelse(!is.na(uncleaned_data$character), uncleaned_data$character, 0)
  
  uncleaned_data$censored <- uncleaned_data$numeric == 100
  # remove "Plate " prefix but set plate_number as factor
  uncleaned_data$plate_number <- trimws(gsub("Plate ", "", uncleaned_data$plate_number))
  uncleaned_data$plate_number <- factor(uncleaned_data$plate_number, levels = as.character(1:40))
  uncleaned_data$plate_first20 <- ifelse(uncleaned_data$plate_number %in% paste(1:20), 1, 0)
  # add plate_grouping so we can do small multiples plot
  
  uncleaned_data$plate_group <- uncleaned_data$plate_number
  levels(uncleaned_data$plate_group) <- rep(1:4, each = 10)
  
  # add copan floq flag for setting color
  
  uncleaned_data$ref_flag <- factor(ifelse(uncleaned_data$swab_type == "Copan Floq", 1, 0))
  
  # set swab_type as factor and re-level so that Copan Floq is 
  # reference level
  
  uncleaned_data$swab_type <- factor(uncleaned_data$swab_type)
  uncleaned_data$swab_type <- relevel(uncleaned_data$swab_type, "Copan Floq")
  
  uncleaned_data <- uncleaned_data %>% rename(count = numeric)
  
  uncleaned_data
  
  
}