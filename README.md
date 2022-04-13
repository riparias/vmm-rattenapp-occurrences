[![funding](https://img.shields.io/static/v1?label=published+through&message=LIFE+RIPARIAS&labelColor=00a58d&color=ffffff)](https://www.riparias.be/)

## Rationale

This repository contains the functionality to standardize the data of the rat-catchers team of the [Flanders Environment Agency (VMM)](https://en.vmm.be/) to a [Darwin Core Archive](https://ipt.gbif.org/manual/en/ipt/2.5/dwca-guide) that can be harvested by [GBIF IPT](http://www.gbif.org/).

## Workflow

[source data](data/raw) → Darwin Core [mapping script](src/dwc_mapping.Rmd) → generated [Darwin Core files](data/processed)

The core mapping is done via a [SQL file](sql/) integrated in the [mapping script](src/dwc_mapping.Rmd).

## Published dataset

* [Dataset on the IPT](#) - TBD
* [Dataset on GBIF](#) - TBD

## Repo structure

The repository structure is based on [Cookiecutter Data Science](http://drivendata.github.io/cookiecutter-data-science/) and the [Checklist recipe](https://github.com/trias-project/checklist-recipe). Files and directories indicated with `GENERATED` should not be edited manually.

```
├── README.md              : Description of this repository
├── LICENSE                : Repository license
├── vmm-rattenapp-occurrences.Rproj : RStudio project file
├── .gitignore             : Files and directories to be ignored by git
│
├── src
│   └── dwc_mapping.Rmd    : Darwin Core mapping script
|
├── sql                    : Darwin Core transformations
│   └── dwc_occurrence.sql
│   
└── data
    ├── raw                : Source data, input for mapping script
    ├── external           : External data used during the mapping
    └── processed          : Darwin Core output of mapping script GENERATED
```

## Installation

1. Clone this repository to your computer
2. Open the RStudio project file
3. Open the `dwc_mapping.Rmd` [R Markdown file](https://rmarkdown.rstudio.com/) in RStudio
4. Install any required packages
5. Click `Run > Run All` to generate the processed data

## License

[MIT License](LICENSE) for the code and documentation in this repository. The included data is released under another license.
