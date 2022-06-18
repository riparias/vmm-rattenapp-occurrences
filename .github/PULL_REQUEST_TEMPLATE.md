## Brief description

This is an **automatically generated PR** generated as a step of the GitHub workflow [`schedule-mapping.yaml`](https://github.com/riparias/vmm-rattenapp-occurrences/blob/automatic-update/.github/workflows/schedule-mapping.yaml). The following steps are all automatically performed:

-   Fetch new raw data: not yet implemented!
-   Map raw data to DwC standard and save the output via [`dwc_mapping.Rmd`](https://github.com/riparias/vmm-rattenapp-occurrences/blob/automatic-update/src/dwc_mapping.Rmd) in `./src`.
-   Get an overview of the changes (number of new occurrences, new species, ...) via [`dwc_mapping.Rmd`](https://github.com/riparias/vmm-rattenapp-occurrences/blob/automatic-update/src/dwc_mapping.Rmd), last chapter: **Overview changes**.
-   Test the DwC output file `occurrence.csv` with the tests in [`test_dwc_occurrence.R`](https://github.com/riparias/vmm-rattenapp-occurrences/blob/automatic-update/tests/test_dwc_occurrence.R), e.g. check the uniqueness of `occurrenceID`, check that all occurrences have a `eventID` and `scientificName`, check that `samplingProtocol` and `individualCount` are correctly set, ...

Note to the reviewer: the workflow automation is still in a development phase. Please, check the output thoroughly before merging to `main`. In case, improve the GitHub workflow [`schedule-mapping.yaml`](https://github.com/riparias/vmm-rattenapp-occurrences/blob/automatic-update/.github/workflows/schedule-mapping.yaml) or the mapping, [`dwc_mapping.Rmd`](https://github.com/riparias/vmm-rattenapp-occurrences/blob/automatic-update/src/dwc_mapping.Rmd).

## Commits

<!-- Diff summary - START -->

<!-- Diff summary - END -->

## Commits graph

<!-- Diff commits - START -->

<!-- Diff commits - END -->

## Modified files

<!-- Diff files - START -->

<!-- Diff files - END -->
