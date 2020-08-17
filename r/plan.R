plan <- drake_plan(
  
  
  uncleaned_data = tidy_excel(file_in("raw_data/Nasal Swab Elution Testing Data Collection.xlsx")),
  
  cleaned_data = clean_data(uncleaned_data)
  
  
  
  
)