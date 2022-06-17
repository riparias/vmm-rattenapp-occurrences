# load needed packages (install if needed)
installed <- rownames(installed.packages())
required <- c(
  "curl", # to read files from URL
  "testthat", # to perform tests
  "readr", # to read csv files
  "magrittr", # to use pipe %>%
  "dplyr" # to work with data.frames
)
if (!all(required %in% installed)) {
  pkgs_to_install <- required[!required %in% installed]
  print(paste("Packages to install:", paste(pkgs_to_install, collapse = ", ")))
  install.packages(pkgs_to_install)
}


# read proposed new version of the DwC mapping
occs_url <- "https://raw.githubusercontent.com/riparias/vmm-rattenapp-occurrences/automatic-update/data/processed/occurrence.csv"
dwc_occurrence_update <- readr::read_csv(occs_url, guess_max = 10000)

testthat::test_that("Right columns in right order", {
  columns <- c(
    "type",
    "language",
    "license",
    "rightsHolder",
    "accessRights",
    "datasetID",
    "institutionCode",
    "datasetName",
    "basisOfRecord",
    "samplingProtocol",
    "occurrenceID",
    "recordedBy",
    "individualCount",
    "occurrenceRemarks",
    "eventID",
    "eventDate",
    "locationID",
    "continent",
    "countryCode",
    "waterBody",
    "stateProvince",
    "municipality",
    "locationRemarks",
    "decimalLatitude",
    "decimalLongitude",
    "geodeticDatum",
    "coordinateUncertaintyInMeters",
    "scientificName",
    "kingdom"
  )
  testthat::expect_equal(names(dwc_occurrence_update), columns)
})

testthat::test_that("occurrenceID is always present and is unique", {
  testthat::expect_true(all(!is.na(dwc_occurrence_update$occurrenceID)))
  testthat::expect_equal(length(unique(dwc_occurrence_update$occurrenceID)),
                         nrow(dwc_occurrence_update))
})

testthat::test_that("eventID is always present", {
  testthat::expect_true(all(!is.na(dwc_occurrence_update$eventID)))
})

testthat::test_that("If individualCount is NA, samplingProtocol is not rat trap", {
  testthat::expect_equal(
    dwc_occurrence_update %>%
      dplyr::filter(is.na(individualCount)) %>%
      dplyr::distinct(samplingProtocol) %>%
      dplyr::arrange(samplingProtocol) %>%
      dplyr::pull(samplingProtocol),
    c("casual observation", "eradicated")
  )
})

testthat::test_that(
  "individualCount is > 0: samplingProtocol = 'casual observation' or 'rat trap'", {
    testthat::expect_equal(
      dwc_occurrence_update %>%
        dplyr::filter(individualCount > 0) %>%
        dplyr::distinct(samplingProtocol) %>%
        dplyr::arrange(samplingProtocol) %>%
        dplyr::pull(samplingProtocol),
      c("casual observation", "rat trap")
    )
  })

testthat::test_that("recordedBy is always filled in", {
  testthat::expect_true(all(!is.na(unique(dwc_occurrence_update$recordedBy))))
})

testthat::test_that("individualCount is never  0", {
  testthat::expect_equal(
    dwc_occurrence_update %>%
      dplyr::filter(individualCount == 0) %>%
      nrow(),
    0
  )
})

testthat::test_that("occurrenceRemarks values", {
  testthat::expect_equal(
    dwc_occurrence_update %>%
      dplyr::distinct(occurrenceRemarks) %>%
      arrange(occurrenceRemarks) %>%
      pull(),
    c("found as nest", "found as tracks", "found dead", NA_character_)
  )
})

testthat::test_that("eventID is always filled in", {
  testthat::expect_true(all(!is.na(dwc_occurrence_update$eventID)))
})

testthat::test_that("eventDate is always filled in", {
  testthat::expect_true(all(!is.na(dwc_occurrence_update$eventDate)))
})

testthat::test_that("locationID is always filled in", {
  testthat::expect_true(all(!is.na(dwc_occurrence_update$locationID)))
})

testthat::test_that("scientificName is never NA and one of the list", {
  species <- c(
    "Hydrocotyle ranunculoides",
    "Impatiens glandulifera",
    "Ludwigia grandiflora",
    "Myriophyllum aquaticum",
    "Heracleum mantegazzianum",
    "Fallopia japonica",
    "Cyanobacteria",
    "Ondatra zibethicus",
    "Myocastor coypus",
    "Rattus norvegicus",
    "Castor fiber",
    "Arvicola terrestris",
    "Vulpes",
    "Capreolus capreolus",
    "Lepus europaeus",
    "Botaurus stellaris",
    "Oryctolagus cuniculus",
    "Sciurus vulgaris",
    "Psittacula krameri",
    "Emydidae",
    "Eriocheir sinensis",
    "Alopochen aegyptiacus",
    "Procyon lotor",
    "Trachemys scripta scripta",
    "Dendrocygna bicolor",
    "Mustela putorius",
    "Branta canadensis",
    "Mustela nivalis",
    "Trachemys scripta troosti",
    "Lutra",
    "Anguis fragilis",
    "Erinaceus europaeus",
    "Anatidae",
    "Cyprinus carpio",
    "Riparia riparia",
    "Gallinula chloropus",
    "Fulica atra",
    "Tachybaptus ruficollis"
  )
  testthat::expect_true(all(!is.na(dwc_occurrence_update$scientificName)))
  testthat::expect_true(all(dwc_occurrence_update$scientificName %in% species))
})
