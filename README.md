<!-- badges: start -->
[![funding](https://img.shields.io/static/v1?label=published+through&message=LIFE+RIPARIAS&labelColor=00a58d&color=ffffff)](https://www.riparias.be/)
[![fetch-data](https://github.com/riparias/vmm-rattenapp-occurrences/actions/workflows/fetch-data.yaml/badge.svg)](https://github.com/riparias/vmm-rattenapp-occurrences/actions/workflows/fetch-data.yaml)
[![mapping and testing](https://github.com/riparias/vmm-rattenapp-occurrences/actions/workflows/mapping_and_testing.yaml/badge.svg)](https://github.com/riparias/vmm-rattenapp-occurrences/actions/workflows/mapping_and_testing.yaml)
<!-- badges: end -->

## Rationale

This repository contains the functionality to standardize the rattenapp data of the [Flanders Environment Agency (VMM)](https://en.vmm.be/) to a [Darwin Core Archive](https://www.gbif.org/darwin-core) that can be harvested by [GBIF](https://www.gbif.org/).

## Workflow

[source data](data/raw) → Darwin Core [mapping script](src/dwc_mapping.Rmd) using [SQL](sql) → generated [Darwin Core files](data/processed)

## Published dataset

* [Dataset on the IPT](https://ipt.inbo.be/resource?r=vmm-rattenapp-occurrences)
* [Dataset on GBIF](https://doi.org/10.15468/wquzva)

## Repo structure

The repository structure is based on [Cookiecutter Data Science](http://drivendata.github.io/cookiecutter-data-science/) and the [Checklist recipe](https://github.com/trias-project/checklist-recipe). Files and directories indicated with `GENERATED` should not be edited manually.

```
├── README.md              : Description of this repository
├── LICENSE                : Repository license
├── vmm-rattenapp-occurrences.Rproj : RStudio project file
├── .gitignore             : Files and directories to be ignored by git
│
├── .github                
│   ├── PULL_REQUEST_TEMPLATE.md : Pull request template
│   └── workflows
│   │   ├── fetch-data.yaml    : GitHub action to fetch raw data
│   │   └── mapping_and_testing.yaml : GitHub action to map data to DwC and perform some tests on the Dwc output
|
├── src
│   ├── fetch_data.Rmd     : Fetchin data script
│   ├── dwc_mapping.Rmd    : Darwin Core mapping script
│   ├── run_fetch_data.R   : R script to run code in fetch_data.Rmd in an automatic way within a GitHub action
│   ├── run_dwc_mapping.R  : R script to run code in dcw_mapping.Rmd in an automatic way within a GitHub action
│   └── install_packages.R : R script to install all needed packages
|
├── sql                    : Darwin Core transformations
│   └── dwc_occurrence.sql
│   
└── data
│   ├── raw                : Source data to fetch
│   ├── external           : External data used during the mapping
│   ├── interim            : All fetched data, input for mapping script
│   └── processed          : Darwin Core output of mapping script GENERATED
```

## Installation

1. Clone this repository to your computer
2. Open the RStudio project file
3. Run `install_packages.R` to install any required packages
4. Open `fetch_data.Rmd` [R Markdown file](https://rmarkdown.rstudio.com/) in RStudio to fetch data manually
5. Open the `dwc_mapping.Rmd` [R Markdown file](https://rmarkdown.rstudio.com/) in RStudio to map data to DwC manually
6. Click `Run > Run All` to generate the processed data

## License

[MIT License](LICENSE) for the code and documentation in this repository. The included data is released under another license.
