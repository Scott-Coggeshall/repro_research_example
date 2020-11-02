# Example of Reproducible Research Practices

This repo contains the code for an analysis of bacteria colony counts collected by several types of nasal swab. The code implements several best practices for reproducible research and pipeline-style data analysis. These include 

- a self-contained directory structure with local file paths
- version control with `git`
- a project-specific `R` package library with dependency tracking through `renv`
- an Rmarkdown-based dynamic document for reporting analysis results
- a `make`-style analysis pipeline through `drake`

In the following, we go a bit further into each of these features.


## Directory Structure

Having a common and consistent directory structure for analyses is a simple and highly effective way to make analysis code easier to follow for both yourself and others. In this project, we used a basic directory structure that works well for `R` projects, especially ones that use `drake` to manage the execution of the analysis. The basic set up is as follows:

```
.
+-- make.r
+-- report.rmd
+-- r/
|   +-- packages.r
|   +-- plan.r
|   +-- functions.r
+-- raw_data/
+-- renv/
+-- reports/
|   +-- report.html
```

The file `make.r` lives in the root directory and controls execution of the analysis code. The `r` sub-directory contains the `.R` files that needed to be sourced by `make.r`. The `raw_data` sub-directory contains the source data for the analysis. The `renv` sub-directory contains the project-specific library of `R` packages. The `reports` sub-directory contains the write-up of the analysis and results.

In addition to improving organization and comprehension, having a well-defined directory structure also makes code more reproducible by facilitating the use of relative rather than absolute file paths. 

## Version Control with Git/Github



## Project-specific Package Library and Dependency Tracking with `renv`

This analysis uses a project-specific library and manages it through the `R` package `renv`. All `R` packages necessary to run the analysis code are contained within a sub-directory of `renv` that is automatically set as the primary library when `R` is launched from the directory containing the project. In addition, the file `renv.lock` tracks information related to the installed packages such as what version of the package is installed and where the package was installed from. 

## Dynamic Document Reporting with Rmarkdown

The results of the analysis are communicated via an Rmarkdown *dynamic document* that blends text and `R` code to ensure that numbers, figures and tables that appear in the report are accurate and up-to-date. The use of dynamic documents also facilitates timely re-running and reporting of analyses in the event of changes to the underlying data. 

## Make-style Analysis Pipeline with `drake`

This project uses the `drake` `R` package to separate the code for performing the analysis (e.g. cleaning of data, fitting of models, plotting of results) from the code for executing the analysis (e.g. sourcing `R` packages and functions, running the code for data cleaning, model fitting, figure generation).

The code for performing the analysis is contained mostly in the sub-directory `r` as well the Rmarkdown file `report.rmd`. The code for executing the analysis code is contained in the file `make.r`. 