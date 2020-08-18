plan <- drake_plan(
  
  
  uncleaned_data = tidy_excel(file_in("raw_data/Nasal Swab Elution Testing Data Collection.xlsx")),
  
  cleaned_data = clean_data(uncleaned_data),
  
  stan_model = rstanarm::stan_glmer(count ~ swab_type + (1 | id) + (1 | plate_number), family = 'poisson', data = cleaned_data %>% filter(censored == FALSE)),
  
  stan_model_noplate = rstanarm::stan_glmer(count ~ swab_type + (1 | id), family = "poisson", data = cleaned_data %>% filter(censored == FALSE)),
  
  stan_model_noid = rstanarm::stan_glmer(count ~ swab_type + (1 | plate_number), family = "poisson", data = cleaned_data %>% filter(censored == FALSE)),
  
  stan_model_noranef = rstanarm::stan_glm(count ~ swab_type, family = "poisson", data = cleaned_data %>% filter(censored == FALSE)),
  
  model_samples = rstan::extract(stan_model$stanfit),
  
  report = rmarkdown::render(knitr_in("report.Rmd"), output_file = file_out("reports/report.html"), quiet = T)
  
  
  
  
)