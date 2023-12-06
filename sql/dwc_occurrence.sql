/*
Created by Damiano Oldoni (INBO)
*/

SELECT
-- RECORD-LEVEL
  'Event'                               AS type,
  'en'                                  AS language,
  'http://creativecommons.org/publicdomain/zero/1.0/' AS license,
  'VMM'                                 AS rightsHolder,
  'http://www.inbo.be/en/norms-for-data-use' AS accessRights,
  'https://doi.org/10.15468/wquzva'     AS datasetID,
  'VMM'                                 AS institutionCode,
  'VMM - Rat control occurrences in Flanders, Belgium' AS datasetName,
  'HumanObservation'                    AS basisOfRecord,
  CASE
    WHEN o."Vangst Aantal" IS NULL AND o."Registratie Verwijderd Omschrijving" = 'Verwijderd' THEN 'eradicated'
    WHEN o."Vangst Aantal" IS NULL THEN 'casual observation'
    ELSE 'rat trap'
  END                                   AS samplingProtocol,

-- OCCURRENCE
  o."Registratie ID" || ':' || o."species_name_hash" AS occurrenceID,
  'Team ' || o."Team Naam"              AS recordedBy,
  CASE
    WHEN o."Vangst Aantal" IS NULL AND o."Sporen Waarnemingen Naam" = '11 waterschildpadden' THEN 11
    WHEN o."Vangst Aantal" IS NULL AND o."Sporen Waarnemingen Naam" = '100  canadese ganzen' THEN 100
    WHEN o."Vangst Aantal" IS NULL AND o."Sporen Waarnemingen Naam" = 'Eendensterfte circa 25 st' THEN 25
    WHEN o."Vangst Aantal" IS NOT NULL THEN CAST(o."Vangst Aantal" AS INT)
    ELSE NULL
  END                                   AS individualCount,
  CASE
    WHEN o."Sporen Waarnemingen Naam" = 'Eendensterfte circa 25 st' THEN 'found dead'
    WHEN o."Sporen Waarnemingen Naam" = 'Dode bever' THEN 'found dead'
    WHEN o."Sporen Waarnemingen Naam" = 'Pootafdrukken wasbeer' THEN 'found as tracks'
    WHEN o."Sporen Waarnemingen Naam" = 'Nijlganzen nest' THEN 'found as nest'
    WHEN o."Sporen Waarnemingen Naam" = 'Nest aziatische hoornaar' THEN 'found as nest'
    ELSE NULL
  END                                   AS occurrenceRemarks,
-- EVENT
  o."Registratie ID"                    AS eventID,
  date(o.Dag)                           AS eventDate,
-- LOCATION
  o."Locatie ID"                        AS locationID,
  'Europe'                              AS continent,
  CASE
    WHEN o.Land_Regio = 'Nederland'     THEN 'NL'
    WHEN o.Land_Regio = 'Frankrijk'     THEN 'FR'
    WHEN o.Land_Regio = 'Vlaanderen'    THEN 'BE'
     -- observations have no Land_Regio field and are assumed to be taken in Belgium
    WHEN o.Land_Regio IS NULL           THEN 'BE'
    ELSE NULL
  END                                   AS countryCode,
  CASE
    WHEN o."VHA Gewestelijke Waterloop Omschrijving" = 'Onbekend' THEN NULL
    ELSE o."VHA Gewestelijke Waterloop Omschrijving"
  END                                   AS waterBody,
  CASE
    WHEN o."Provincie Omschrijving" = 'Antwerpen' THEN 'Antwerp'
    WHEN o."Provincie Omschrijving" = 'Limburg' THEN 'Limburg'
    WHEN o."Provincie Omschrijving" = 'Onbekend' THEN NULL
    WHEN o."Provincie Omschrijving" = 'Oost-Vlaanderen' THEN 'East Flanders'
    WHEN o."Provincie Omschrijving" = 'Vlaams-Brabant' THEN 'Flemish Brabant'
    WHEN o."Provincie Omschrijving" = 'West-Vlaanderen' THEN 'West Flanders'
  END                                   AS stateProvince,
  CASE
    WHEN o."Gemeente Naam" = 'Onbekend' THEN NULL
    ELSE  o."Gemeente Naam"
  END                                   AS municipality,
  CASE
    WHEN o."VHA Categorie Omschrijving" = 'Baangracht' THEN NULL
    WHEN o."VHA Categorie Omschrijving" = 'Bevaarbaar' THEN 'BEV - waterway navigable'
    WHEN o."VHA Categorie Omschrijving" = 'Grachten algemeen belang' THEN NULL
    WHEN o."VHA Categorie Omschrijving" = 'Niet geklasseerd' THEN NULL
    WHEN o."VHA Categorie Omschrijving" = 'Onbekend' THEN NULL
    WHEN o."VHA Categorie Omschrijving" = 'Onbevaarbaar cat. 1' THEN 'CAT1 - waterway not navigable cat. 1'
    WHEN o."VHA Categorie Omschrijving" = 'Onbevaarbaar cat. 2' THEN 'CAT2 - waterway not navigable cat. 2'
    WHEN o."VHA Categorie Omschrijving" = 'Onbevaarbaar cat. 3' THEN 'CAT3 - waterway not navigable cat. 3'
    WHEN o."VHA Categorie Omschrijving" = 'Polder of wateringgracht' THEN NULL
    ELSE NULL
  END                                   AS locationRemarks,
  printf('%.5f', ROUND(o."Locatie GPS Breedte", 5)) AS decimalLatitude,
  printf('%.5f', ROUND(o."Locatie GPS Lengte", 5)) AS decimalLongitude,
  'WGS84'                               AS geodeticDatum,
  30                                    AS coordinateUncertaintyInMeters,
-- TAXON
  CASE
    -- Bacteria
    WHEN o."Sporen Waarnemingen Naam" = 'Blauwalg' THEN 'Cyanobacteria'
    -- Plantae
    WHEN o."Sporen Waarnemingen Naam" = 'Japanse duizendknoop' THEN 'Fallopia japonica'
    WHEN o."Sporen Waarnemingen Naam" = 'Reuzenberenklauw' THEN 'Heracleum mantegazzianum'
    WHEN o."Sporen Waarnemingen Naam" = 'Parelvederkruid' THEN 'Myriophyllum aquaticum'
    WHEN o."Sporen Waarnemingen Naam" = 'Waterteunisbloem' THEN 'Ludwigia grandiflora'
    WHEN o."Sporen Waarnemingen Naam" = 'Reuzenbalsemien' THEN 'Impatiens glandulifera'
    WHEN o."Sporen Waarnemingen Naam" = 'Grote waternavel' THEN 'Hydrocotyle ranunculoides'
    WHEN o."Sporen Waarnemingen Naam" = 'Waterwaaier' THEN 'Cabomba caroliniana'
    WHEN o."Sporen Waarnemingen Naam" = 'Waterpest' THEN 'Elodea'
    WHEN o."Sporen Waarnemingen Naam" = 'Kaapse waterlelie' THEN 'Aponogeton distachyos'
    WHEN o."Sporen Waarnemingen Naam" = 'Afghaanse duizendknoop' THEN 'Koenigia polystachya'
    WHEN o."Sporen Waarnemingen Naam" = 'Watercrassula' THEN 'Crassula helmsii'
    WHEN o."Sporen Waarnemingen Naam" = 'Moerashyacint' THEN 'Pontederia cordata'
    -- Animalia
    WHEN o."Sporen Waarnemingen Naam" = 'Muskusrat' THEN 'Ondatra zibethicus'
    WHEN o."Sporen Waarnemingen Naam" = 'Muskusr. > 400gr' THEN 'Ondatra zibethicus'
    WHEN o."Sporen Waarnemingen Naam" = 'Muskusr. < 400gr' THEN 'Ondatra zibethicus'
    WHEN o."Sporen Waarnemingen Naam" = 'Beverrat' THEN 'Myocastor coypus'
    WHEN o."Sporen Waarnemingen Naam" = 'Bruine rat' THEN 'Rattus norvegicus'
    WHEN o."Sporen Waarnemingen Naam" = 'Bruine ratten. geen spore' THEN 'Rattus norvegicus'
    WHEN o."Sporen Waarnemingen Naam" = 'Bever' THEN 'Castor fiber'
    WHEN o."Sporen Waarnemingen Naam" = 'Dode bever' THEN 'Castor fiber'
    WHEN o."Sporen Waarnemingen Naam" = 'Woelrat' THEN 'Arvicola terrestris'
    WHEN o."Sporen Waarnemingen Naam" = 'Woelratten' THEN 'Arvicola terrestris'
    WHEN o."Sporen Waarnemingen Naam" = 'W9elrat' THEN 'Arvicola terrestris'
    WHEN o."Sporen Waarnemingen Naam" = 'Woelrar' THEN 'Arvicola terrestris'
    WHEN o."Sporen Waarnemingen Naam" = 'Vos' THEN 'Vulpes'
    WHEN o."Sporen Waarnemingen Naam" = 'Ree' THEN 'Capreolus capreolus'
    WHEN o."Sporen Waarnemingen Naam" = 'Haas' THEN 'Lepus europaeus'
    WHEN o."Sporen Waarnemingen Naam" = 'Roerdomp' THEN 'Botaurus stellaris'
    WHEN o."Sporen Waarnemingen Naam" = 'Konijn' THEN 'Oryctolagus cuniculus'
    WHEN o."Sporen Waarnemingen Naam" = 'Konijnen' THEN 'Oryctolagus cuniculus'
    WHEN o."Sporen Waarnemingen Naam" = 'Konijn.' THEN 'Oryctolagus cuniculus'
    WHEN o."Sporen Waarnemingen Naam" = 'Eekhoorn' THEN 'Sciurus vulgaris'
    WHEN o."Sporen Waarnemingen Naam" = 'Galsbandparkiet' THEN 'Psittacula krameri'
    WHEN o."Sporen Waarnemingen Naam" = 'Galsbandparkieten' THEN 'Psittacula krameri'
    WHEN o."Sporen Waarnemingen Naam" = 'Galsbandparkieten exoot' THEN 'Psittacula krameri'
    WHEN o."Sporen Waarnemingen Naam" = 'Halsbandparkiet' THEN 'Psittacula krameri'
    WHEN o."Sporen Waarnemingen Naam" = '11 waterschildpadden' THEN 'Emydidae'
    WHEN o."Sporen Waarnemingen Naam" = 'waterschildpad' THEN 'Emydidae'
    WHEN o."Sporen Waarnemingen Naam" = 'Castor fiber' THEN 'Castor fiber' -- Castor fiber unchanged
    WHEN o."Sporen Waarnemingen Naam" = 'Wolhandkrab' THEN 'Eriocheir sinensis'
    WHEN o."Sporen Waarnemingen Naam" = 'Nijlgans' THEN 'Alopochen aegyptiacus'
    WHEN o."Sporen Waarnemingen Naam" = 'Nijlganzen' THEN 'Alopochen aegyptiacus'
    WHEN o."Sporen Waarnemingen Naam" = 'Nijlganzen nest' THEN 'Alopochen aegyptiacus'
    WHEN o."Sporen Waarnemingen Naam" = 'Pootafdrukken wasbeer' THEN 'Procyon lotor'
    WHEN o."Sporen Waarnemingen Naam" = 'Geelbuikschildpad' THEN 'Trachemys scripta scripta'
    WHEN o."Sporen Waarnemingen Naam" = 'Geelwangwaterschildpadden' THEN 'Trachemys scripta troosti'
    WHEN o."Sporen Waarnemingen Naam" = 'Geelwangschildpad' THEN 'Trachemys scripta troosti'
    WHEN o."Sporen Waarnemingen Naam" = 'Rosse fluiteend' THEN 'Dendrocygna bicolor'
    WHEN o."Sporen Waarnemingen Naam" = 'Bunzing' THEN 'Mustela putorius'
    WHEN o."Sporen Waarnemingen Naam" = '100  canadese ganzen' THEN 'Branta canadensis'
    WHEN o."Sporen Waarnemingen Naam" = 'Wezel' THEN 'Mustela nivalis'
    WHEN o."Sporen Waarnemingen Naam" = 'Wezeltje' THEN 'Mustela nivalis'
    WHEN o."Sporen Waarnemingen Naam" = 'Otter' THEN 'Lutra'
    WHEN o."Sporen Waarnemingen Naam" = 'Hazelworm' THEN 'Anguis fragilis'
    WHEN o."Sporen Waarnemingen Naam" = 'Egel' THEN 'Erinaceus europaeus'
    WHEN o."Sporen Waarnemingen Naam" = 'Eendensterfte circa 25 st' THEN 'Anatidae'
    WHEN o."Sporen Waarnemingen Naam" = 'Prooi van otter (karper)' THEN 'Cyprinus carpio'
    WHEN o."Sporen Waarnemingen Naam" = 'Oeverzwaluwen' THEN 'Riparia riparia'
    WHEN o."Sporen Waarnemingen Naam" = 'Waterhoen' THEN 'Gallinula chloropus'
    WHEN o."Sporen Waarnemingen Naam" = 'Meerkoet' THEN 'Fulica atra'
    WHEN o."Sporen Waarnemingen Naam" = 'Doodaars' THEN 'Tachybaptus ruficollis'
    WHEN o."Sporen Waarnemingen Naam" = 'Eend' THEN 'Anatidae'
    WHEN o."Sporen Waarnemingen Naam" = 'Aalscholver' THEN 'Phalacrocorax carbo'
    WHEN o."Sporen Waarnemingen Naam" = 'Hermelijn' THEN 'Mustela erminea'
    WHEN o."Sporen Waarnemingen Naam" = 'Marterachtige' THEN 'Mustelidae'
    WHEN o."Sporen Waarnemingen Naam" = 'Rivierkreeft' THEN 'Decapoda'
    WHEN o."Sporen Waarnemingen Naam" = 'Boommarter' THEN 'Martes martes'
    WHEN o."Sporen Waarnemingen Naam" = 'Nest aziatische hoornaar' THEN 'Vespa velutina'
    WHEN o."Sporen Waarnemingen Naam" = 'Aziatische hoornaar' THEN 'Vespa velutina'
    ELSE NULL
  END                                   AS scientificName,
  CASE
    WHEN o."Sporen Waarnemingen Naam" = 'Blauwalg' THEN 'Bacteria'
    WHEN o."Sporen Waarnemingen Naam" = 'Japanse duizendknoop' OR
      o."Sporen Waarnemingen Naam" = 'Reuzenberenklauw' OR
      o."Sporen Waarnemingen Naam" = 'Parelvederkruid' OR
      o."Sporen Waarnemingen Naam" = 'Waterteunisbloem' OR
      o."Sporen Waarnemingen Naam" = 'Reuzenbalsemien' OR
      o."Sporen Waarnemingen Naam" = 'Grote waternavel' OR
      o."Sporen Waarnemingen Naam" = 'Waterpest' OR
      o."Sporen Waarnemingen Naam" = 'Waterwaaier' OR
      o."Sporen Waarnemingen Naam" = 'Kaapse waterlelie' OR
      o."Sporen Waarnemingen Naam" = 'Afghaanse duizendknoop' OR
      o."Sporen Waarnemingen Naam" = 'Watercrassula' OR
      o."Sporen Waarnemingen Naam" = 'Moerashyacint' THEN 'Plantae'
    ELSE 'Animalia'
  END                                   AS kingdom
FROM occurrences AS o
  LEFT JOIN life_mica_obs AS l
  ON l.registration_id = o."Registratie ID"
WHERE
  -- Remove observations published in LIFE MICA dataset
  l.registration_id IS NULL AND
  -- Remove errors
  o."Sporen Waarnemingen Naam" != 'Lierke' AND
  o."Sporen Waarnemingen Naam" != ',' AND
  -- Remove bred animals
  o."Sporen Waarnemingen Naam" != 'Koe gered uit dyle' AND
  -- Remove too generic taxa or observations not related to any taxon
  o."Sporen Waarnemingen Naam" != 'Vissterfte' AND
  o."Sporen Waarnemingen Naam" != 'Vis' AND
  o."Sporen Waarnemingen Naam" != 'Massale vissterfte' AND
  o."Sporen Waarnemingen Naam" != 'Katvisjes,  zonnebaars' AND
  o."Sporen Waarnemingen Naam" != '1 nederlandse schijnfuik' AND
  o."Sporen Waarnemingen Naam" != 'Vergeten fuik' AND
  o."Sporen Waarnemingen Naam" != 'Geen sporen - melding br' AND
  o."Sporen Waarnemingen Naam" != '1 zak vuilnis' AND
  o."Sporen Waarnemingen Naam" != 'Vuilzakken' AND
  o."Sporen Waarnemingen Naam" != 'Grote afvalstukken' AND
  o."Sporen Waarnemingen Naam" != '2 nederlandse coniberen' AND
  o."Sporen Waarnemingen Naam" != '2 stoplossen op het droge' AND
  o."Sporen Waarnemingen Naam" != 'Wordt' AND
  o."Sporen Waarnemingen Naam" != 'Melding bruine rat - geen' AND
  o."Sporen Waarnemingen Naam" != '2 dode geiten' AND
  o."Sporen Waarnemingen Naam" != 'Andere' AND
  o."Sporen Waarnemingen Naam" != 'Nest' AND
  o."Sporen Waarnemingen Naam" != 'Muizen'
  o."Team Naam" != 'Controle Oost' AND
  o."Team Naam" != 'Controle West'
ORDER BY
    o."Registratie ID" ASC, -- eventID
    o."species_name_hash" ASC -- species hash (part of occurrenceID)
