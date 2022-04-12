/*
Created by Damiano Oldoni (INBO)
*/

/* RECORD-LEVEL */

SELECT
  'Event'                               AS type,
  '"http://creativecommons.org/publicdomain/zero/1.0/"' AS license,
  'VMM'                                 AS rightsHolder,
  'http://www.inbo.be/en/norms-for-data-use' AS accessRights,
  NULL                                  AS datasetID,
  'VMM'                                 AS institutionCode,
  'The rattenapp data (PROVISIONAL)'    AS datasetName,
  'HumanObservation'                    AS basisOfRecord,
  *
FROM (

SELECT
  o.'Registratie ID'                    AS eventID,
  date(o.Dag)                           AS eventDate,
  o.Jaar                                AS year,
  o.'Locatie ID'                        AS locationID,
  'Europe'                              AS continent,
  'Belgium'                             AS country,
  'BE'                                  AS countryCode,
  CASE
    WHEN o.'VHA Gewestelijke Waterloop Omschrijving' = 'Onbekend' THEN NULL
    ELSE o.'VHA Gewestelijke Waterloop Omschrijving'
  END                                   AS waterBody,
  CASE
    WHEN o.`Provincie Omschrijving` = 'Limburg' THEN 'Limburg'
    WHEN o.`Provincie Omschrijving` = 'West-Vlaanderen' THEN 'West Flanders'
    WHEN o.`Provincie Omschrijving` = 'Oost-Vlaanderen' THEN 'East Flanders'
    WHEN o.`Provincie Omschrijving` = 'Antwerpen' THEN 'Antwerp'
    WHEN o.`Provincie Omschrijving` = 'Vlaams-Brabant' THEN 'Flemish Brabant'
    WHEN o.`Provincie Omschrijving` = 'Onbekend' THEN NULL
  END                                   AS stateProvince,
  CASE
    WHEN o.'Gemeente Naam' = 'Onbekend' THEN NULL
    ELSE  o.'Gemeente Naam'
  END                                   AS municipality,
  CASE
    WHEN o.'VHA Categorie Omschrijving' = 'CAT1 - Onbevaarbaar cat. 1'
      THEN 'CAT1 - not navigable cat. 1'
    WHEN o.'VHA Categorie Omschrijving' = 'CAT2 - Onbevaarbaar cat. 2'
      THEN 'CAT2 - not navigable cat. 2'
    WHEN o.'VHA Categorie Omschrijving' = 'CAT3 - Onbevaarbaar cat. 3'
      THEN 'CAT3 - not navigable cat. 3'
    WHEN o.'VHA Categorie Omschrijving' = 'CAT - Andere'
      THEN 'CAT - other'
    WHEN o.'VHA Categorie Omschrijving' = 'ONB - Onbekend'
      THEN 'ONB - unknown'
    WHEN o.'VHA Categorie Omschrijving' = 'BEV - Bevaarbaar'
      THEN 'BEV - navigable'
  END                                   AS locationRemarks,
  ROUND(o.'Locatie GPS Breedte',5)      AS decimalLatitude,
  ROUND(o.'Locatie GPS Lengte',5)       AS decimalLongitude,
  'WGS84'                               AS geodeticDatum,
  30                                    AS coordinateUncertaintyInMeters,
  CASE
    WHEN o.'Sporen Waarnemingen Naam' = 'Blauwalg' THEN 'Cyanobacteria'
    WHEN o.'Sporen Waarnemingen Naam' = 'Japanse duizendknoop' THEN 'Fallopia japonica'
    WHEN o.'Sporen Waarnemingen Naam' = 'Reuzenberenklauw' THEN 'Heracleum mantegazzianum'
    WHEN o.'Sporen Waarnemingen Naam' = 'Parelvederkruid' THEN 'Myriophyllum aquaticum'
    WHEN o.'Sporen Waarnemingen Naam' = 'Waterteunisbloem' THEN 'Ludwigia grandiflora'
    WHEN o.'Sporen Waarnemingen Naam' = 'Reuzenbalsemien' THEN 'Impatiens glandulifera'
    WHEN o.'Sporen Waarnemingen Naam' = 'Grote waternavel' THEN 'Hydrocotyle ranunculoides'
    WHEN o.'Sporen Waarnemingen Naam' = 'Muskusrat' THEN 'Ondatra zibethicus'
    WHEN o.'Sporen Waarnemingen Naam' = 'Beverrat' THEN 'Myocastor coypus'
    WHEN o.'Sporen Waarnemingen Naam' = 'Bruine rat' THEN 'Rattus norvegicus'
    WHEN o.'Sporen Waarnemingen Naam' = 'Bruine ratten. geen spore' THEN 'Rattus norvegicus'
    WHEN o.'Sporen Waarnemingen Naam' = 'Bever' THEN 'Cephaloziella tahora'
    WHEN o.'Sporen Waarnemingen Naam' = 'Woelrat' THEN 'Arvicola terrestris'
    WHEN o.'Sporen Waarnemingen Naam' = 'Woelratten' THEN 'Arvicola terrestris'
    WHEN o.'Sporen Waarnemingen Naam' = 'W9elrat' THEN 'Arvicola terrestris'
    WHEN o.'Sporen Waarnemingen Naam' = 'Woelrar' THEN 'Arvicola terrestris'
    WHEN o.'Sporen Waarnemingen Naam' = 'Vos' THEN 'Vulpes'
    WHEN o.'Sporen Waarnemingen Naam' = 'Ree' THEN 'Capreolus capreolus'
    WHEN o.'Sporen Waarnemingen Naam' = 'Haas' THEN 'Lepus europaeus'
    WHEN o.'Sporen Waarnemingen Naam' = 'Roerdomp' THEN 'Botaurus stellaris'
    WHEN o.'Sporen Waarnemingen Naam' = 'Konijn' THEN 'Oryctolagus cuniculus'
    WHEN o.'Sporen Waarnemingen Naam' = 'Konijnen' THEN 'Oryctolagus cuniculus'
    WHEN o.'Sporen Waarnemingen Naam' = 'Konijn.' THEN 'Oryctolagus cuniculus'
    WHEN o.'Sporen Waarnemingen Naam' = 'Eekhoorn' THEN 'Sciurus vulgaris'
    WHEN o.'Sporen Waarnemingen Naam' = 'Galsbandparkiet' THEN 'Psittacula krameri'
    WHEN o.'Sporen Waarnemingen Naam' = 'Galsbandparkieten exoot' THEN 'Psittacula krameri'
    WHEN o.'Sporen Waarnemingen Naam' = '11 waterschildpadden' THEN  'Emydidae'
    WHEN o.'Sporen Waarnemingen Naam' = 'waterschildpad' THEN 'Emydidae'
    -- Castor fiber unchanged
    WHEN o.'Sporen Waarnemingen Naam' = 'Castor fiber' THEN 'Castor fiber'
    WHEN o.'Sporen Waarnemingen Naam' = 'Wolhandkrab' THEN 'Eriocheir sinensis'
    WHEN o.'Sporen Waarnemingen Naam' = 'Nijlgans' THEN 'Alopochen aegyptiacus'
    WHEN o.'Sporen Waarnemingen Naam' = 'Nijlganzen nest' THEN 'Alopochen aegyptiacus'
    WHEN o.'Sporen Waarnemingen Naam' = 'Pootafdrukken wasbeer' THEN 'Procyon lotor'
    WHEN o.'Sporen Waarnemingen Naam' = 'Geelbuikschildpad' THEN 'Trachemys scripta scripta'
    WHEN o.'Sporen Waarnemingen Naam' = 'Geelwangwaterschildpadden' THEN 'Trachemys scripta troosti'
    WHEN o.'Sporen Waarnemingen Naam' = 'Geelwangschildpad' THEN 'Trachemys scripta troosti'
    WHEN o.'Sporen Waarnemingen Naam' = 'Rosse fluiteend' THEN 'Dendrocygna bicolor'
    WHEN o.'Sporen Waarnemingen Naam' = 'Bunzing' THEN 'Mustela putorius'
    WHEN o.'Sporen Waarnemingen Naam' = '100  canadese ganzen' THEN 'Branta canadensis'
    WHEN o.'Sporen Waarnemingen Naam' = 'Wezeltje' THEN 'Mustela nivalis'
    WHEN o.'Sporen Waarnemingen Naam' = 'Otter' THEN 'Lutra'
    WHEN o.'Sporen Waarnemingen Naam' = 'Hazelworm' THEN 'Anguis fragilis'
    WHEN o.'Sporen Waarnemingen Naam' = 'Egel' THEN 'Erinaceus europaeus'
    WHEN o.'Sporen Waarnemingen Naam' = 'Koe gered uit dyle' THEN 'Bovidae'
    WHEN o.'Sporen Waarnemingen Naam' = 'Eendensterfte circa 25 st' THEN 'Anatidae'
    WHEN o.'Sporen Waarnemingen Naam' = 'Prooi van otter (karper)' THEN 'Cyprinus carpio'
    WHEN o.'Sporen Waarnemingen Naam' = 'Oeverzwaluwen' THEN 'Riparia riparia'
    ELSE NULL
  END                                   AS scientificName,
  o.'Registratie ID' || ':' || o.'species_name_hash' AS occurrenceID,
  o.'Team Naam'                         AS recordedBy,
  CASE
    WHEN o.'Sporen Waarnemingen Naam' = '11 waterschildpadden' THEN 11
    WHEN o.'Sporen Waarnemingen Naam' = '100  canadese ganzen' THEN 100
    ELSE NULL
  END                                   AS individualCount,
  CASE
    WHEN o.'Sporen Waarnemingen Naam' = 'Bruine ratten. geen spore' THEN 'many'
    WHEN o.'Sporen Waarnemingen Naam' = 'Woelratten' THEN 'many'
    WHEN o.'Sporen Waarnemingen Naam' = 'Konijnen' THEN 'many'
    WHEN o.'Sporen Waarnemingen Naam' = 'Galsbandparkieten exoot' THEN 'many'
    WHEN o.'Sporen Waarnemingen Naam' = '11 waterschildpadden' THEN 11
    WHEN o.'Sporen Waarnemingen Naam' = 'Nijlganzen nest' THEN 'many'
    WHEN o.'Sporen Waarnemingen Naam' = 'Geelwangwaterschildpadden' THEN 'many'
    WHEN o.'Sporen Waarnemingen Naam' = '100  canadese ganzen' THEN 100
    WHEN o.'Sporen Waarnemingen Naam' = 'Eendensterfte circa 25 st' THEN '~25'
    WHEN o.'Sporen Waarnemingen Naam' = 'Oeverzwaluwen' THEN 'many'
    ELSE NULL
  END                                   AS organismQuantityValue,
  'individuals'                         AS organismQuantityType,
  CASE
    WHEN o.'Sporen Waarnemingen Naam' = 'Koe gered uit dyle' THEN 'cultivated'
    ELSE NULL
  END                                   AS establishmentMeans,
  CASE
    WHEN o.'Sporen Waarnemingen Naam' = 'Blauwalg' THEN 'Bacteria'
    WHEN o.'Sporen Waarnemingen Naam' = 'Japanse duizendknoop' OR
      o.'Sporen Waarnemingen Naam' = 'Reuzenberenklauw' OR
      o.'Sporen Waarnemingen Naam' = 'Parelvederkruid' OR
      o.'Sporen Waarnemingen Naam' = 'Waterteunisbloem' OR
      o.'Sporen Waarnemingen Naam' = 'Reuzenbalsemien' OR
      o.'Sporen Waarnemingen Naam' = 'Grote waternavel' THEN 'Plantae'
    ELSE 'Animalia'
  END                                   AS kingdom,
  CASE
    WHEN o.'Registratie Verwijderd Omschrijving' = 'Verwijderd' THEN 'eradicated'
    WHEN o.'Sporen Waarnemingen Naam' = 'Eendensterfte circa 25 st' THEN 'found dead'
    WHEN o.'Sporen Waarnemingen Naam' = 'Pootafdrukken wasbeer' THEN 'footprints'
    WHEN o.'Sporen Waarnemingen Naam' = 'Nijlganzen nest' THEN 'nest'
  ELSE NULL
  END                                   AS occurrenceRemarks
FROM observations AS o
  LEFT JOIN life_mica_obs as l
  ON l.registration_id = o.'Registratie ID'
WHERE
  -- remove observations published in LIFE MICA dataset
  l.registration_id  IS NULL AND
  -- remove errors
  o.'Sporen Waarnemingen Naam' != 'Lierke' AND
  o.'Sporen Waarnemingen Naam' != ',' AND
  -- remove too generic taxa or observations not related to any taxon
  o.'Sporen Waarnemingen Naam' != 'Vissterfte' AND
  o.'Sporen Waarnemingen Naam' != 'Massale vissterfte' AND
  o.'Sporen Waarnemingen Naam' != 'Katvisjes,  zonnebaars' AND
  o.'Sporen Waarnemingen Naam' != '1 nederlandse schijnfuik' AND
  o.'Sporen Waarnemingen Naam' != 'Vergeten fuik' AND
  o.'Sporen Waarnemingen Naam' != 'Geen sporen - melding br' AND
  o.'Sporen Waarnemingen Naam' != '1 zak vuilnis' AND
  o.'Sporen Waarnemingen Naam' != '2 nederlandse coniberen' AND
  o.'Sporen Waarnemingen Naam' != '2 stoplossen op het droge' AND
  o.'Sporen Waarnemingen Naam' != 'Wordt' AND
  o.'Sporen Waarnemingen Naam' != 'Melding bruine rat - geen'
)
