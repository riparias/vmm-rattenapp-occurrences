# load libraries
library(testthat)
library(readr)
library(dplyr)

# read proposed new version of the DwC mapping
occs_path <- here::here("data", "processed", "occurrence.csv")
dwc_occurrence <- readr::read_csv(occs_path, guess_max = 10000)

# tests
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
  testthat::expect_equal(names(dwc_occurrence), columns)
})

testthat::test_that("occurrenceID is always present and is unique", {
  testthat::expect_true(all(!is.na(dwc_occurrence$occurrenceID)))
  testthat::expect_equal(length(unique(dwc_occurrence$occurrenceID)),
                         nrow(dwc_occurrence))
})

testthat::test_that("eventID is always present", {
  testthat::expect_true(all(!is.na(dwc_occurrence$eventID)))
})

testthat::test_that("if individualCount is NA, samplingProtocol is not rat trap", {
  testthat::expect_equal(
    dwc_occurrence %>%
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
      dwc_occurrence %>%
        dplyr::filter(individualCount > 0) %>%
        dplyr::distinct(samplingProtocol) %>%
        dplyr::arrange(samplingProtocol) %>%
        dplyr::pull(samplingProtocol),
      c("casual observation", "rat trap")
    )
  })

testthat::test_that("recordedBy is always filled in", {
  testthat::expect_true(all(!is.na(unique(dwc_occurrence$recordedBy))))
})

testthat::test_that("individualCount is never  0", {
  testthat::expect_equal(
    dwc_occurrence %>%
      dplyr::filter(individualCount == 0) %>%
      nrow(),
    0
  )
})

testthat::test_that("occurrenceRemarks values", {
  testthat::expect_equal(
    dwc_occurrence %>%
      dplyr::distinct(occurrenceRemarks) %>%
      arrange(occurrenceRemarks) %>%
      pull(),
    c("found as nest", "found as tracks", "found dead", NA_character_)
  )
})

testthat::test_that("eventID is always filled in", {
  testthat::expect_true(all(!is.na(dwc_occurrence$eventID)))
})

testthat::test_that("eventDate is always filled in", {
  testthat::expect_true(all(!is.na(dwc_occurrence$eventDate)))
})

testthat::test_that("locationID is always filled in", {
  testthat::expect_true(all(!is.na(dwc_occurrence$locationID)))
})

testthat::test_that("decimalLatitude is always filled in", {
  testthat::expect_true(all(!is.na(dwc_occurrence$decimalLatitude)))
})

testthat::test_that("decimalLatitude is within Flemish boundaries", {
  testthat::expect_true(all(dwc_occurrence$decimalLatitude < 51.65))
  testthat::expect_true(all(dwc_occurrence$decimalLatitude > 50.63))
})

testthat::test_that("decimalLongitude is always filled in", {
  testthat::expect_true(all(!is.na(dwc_occurrence$decimalLongitude)))
})

testthat::test_that("decimalLongitude is within Flemish boundaries", {
  testthat::expect_true(all(dwc_occurrence$decimalLongitude < 5.95))
  testthat::expect_true(all(dwc_occurrence$decimalLongitude > 2.450))
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
    "Mustela erminea",
    "Mustelidae",
    "Trachemys scripta troosti",
    "Lutra",
    "Anguis fragilis",
    "Erinaceus europaeus",
    "Anatidae",
    "Cyprinus carpio",
    "Riparia riparia",
    "Gallinula chloropus",
    "Fulica atra",
    "Tachybaptus ruficollis",
    "Phalacrocorax carbo",
    "Decapoda",
    "Martes martes",
    "Vespa velutina",
    "Elodea",
    "Cabomba caroliniana",
    "Aponogeton distachyos",
    "Koenigia polystachya"
  )
  testthat::expect_true(all(!is.na(dwc_occurrence$scientificName)))
  testthat::expect_true(all(dwc_occurrence$scientificName %in% species))
})
