/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth >= '01/01/2016' AND date_of_birth <= '01/01/2019';
SELECT name FROM animals WHERE escape_attempts < 3 AND neutered = true;
SELECT date_of_birth FROM animals WHERE name = 'Pikachu' OR name = 'Agumon';
SELECT name, escape_attempts FROM animals WHERE weight_kg >= 10.50;
SELECT * FROM animals WHERE neutered = true; 
SELECT * From animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

ALTER TABLE animals ADD species text NULL;

BEGIN
ALTER TABLE animals RENAME COLUMN species TO unspecified;
ROLLBACK

BEGIN
UPDATE animals
SET species = 'digimon' 
WHERE name LIKE '%mon%';

UPDATE animals
SET species = 'pokemon' 
WHERE name NOT LIKE '%mon%';
COMMIT

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0
SELECT AVG(weight_kg) FROM animals
SELECT NEUTERED, MAX(escape_attempts) FROM animals GROUP BY NEUTERED
SELECT SPECIES, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY SPECIES
SELECT SPECIES, AVG(escape_attempts) FROM animals WHERE DATE_OF_BIRTH BETWEEN 'January 1, 1990' AND 'December 31, 2000' GROUP BY SPECIES 

-- What animals belong to Melody Pond?
SELECT name FROM animals JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Melody Pond';


-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';


-- List all owners and their animals, remember to include those that dont own any animal.
SELECT owners.full_name, animals.name FROM owners FULL JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT species.name, COUNT(species.name) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name FROM animals JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that havent tried to escape.
SELECT animals.name FROM animals JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(owners.full_name) FROM owners FULL JOIN animals ON owners.id = animals.owners_id GROUP BY owners.full_name ORDER BY COUNT(owners.full_name) DESC LIMIT 1;
