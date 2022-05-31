/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth >= '01/01/2016' AND date_of_birth <= '01/01/2019';
SELECT name FROM animals WHERE escape_attempts < 3 AND neutered = true;
SELECT date_of_birth FROM animals WHERE name = 'Pikachu' OR name = 'Agumon';
SELECT name, escape_attempts FROM animals WHERE weight_kg >= 10.50;
SELECT * FROM animals WHERE neutered = true; 
SELECT * From animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

UPDATE animals
SET species = 'digimon' 
WHERE name LIKE '%mon%';

UPDATE animals
SET species = 'pokemon' 
WHERE name NOT LIKE '%mon%';

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT SP1;
COMMIT;

SELECT COUNT(*) FROM animals
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0
SELECT AVG(weight_kg) FROM animals
SELECT NEUTERED, MAX(escape_attempts) FROM animals GROUP BY NEUTERED
SELECT SPECIES, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY SPECIES
SELECT SPECIES, AVG(escape_attempts) FROM animals WHERE DATE_OF_BIRTH BETWEEN 'January 1, 1990' AND 'December 31, 2000' GROUP BY SPECIES 