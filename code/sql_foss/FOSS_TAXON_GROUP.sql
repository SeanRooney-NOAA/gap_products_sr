-- SQL Command to Create Materilized View GAP_PRODUCTS.FOSS_TAXON_GROUP
-- This reference table will allow for easier searching and sorting of species in FOSS
--
-- Contributors: Ned Laman (ned.laman@noaa.gov), 
--               Zack Oyafuso (zack.oyafuso@noaa.gov), 
--               Emily Markowitz (emily.markowitz@noaa.gov)
--

CREATE MATERIALIZED VIEW GAP_PRODUCTS.FOSS_TAXON_GROUP AS
SELECT  
REPLACE(REPLACE(RANK_ID, '_TAXON', ''), 'SPECIES_NAME', 'SPECIES') AS RANK_ID, 
CLASSIFICATION, 
SPECIES_CODE 
FROM (SELECT * FROM GAP_PRODUCTS.TAXON_GROUPS WHERE SPECIES_CODE = GROUP_CODE) tt
UNPIVOT
(CLASSIFICATION FOR RANK_ID IN 
(SPECIES_NAME, 
GENUS_TAXON, 
SUBFAMILY_TAXON, 
FAMILY_TAXON, 
-- SUPERFAMILY_TAXON, 
-- SUBORDER_TAXON, 
ORDER_TAXON, 
-- SUPERORDER_TAXON, 
-- SUBCLASS_TAXON, 
CLASS_TAXON, 
-- SUPERCLASS_TAXON, 
-- SUBPHYLUM_TAXON, 
PHYLUM_TAXON, 
KINGDOM_TAXON)) 
WHERE CLASSIFICATION IS NOT NULL
ORDER BY SPECIES_CODE, ID_RANK, CLASSIFICATION

