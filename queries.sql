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


-- Write queries to answer the following:
-- Who was the last animal seen by William Tatcher?
SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'William Tatcher' ORDER BY visits.date_of_visit DESC LIMIT 1;
-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.name) FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Stephanie Mendez';
-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, specializations.species_id FROM vets FULL JOIN specializations ON vets.id = specializations.vet_id;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';
-- What animal has the most visits to vets?
SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id GROUP BY animals.name ORDER BY COUNT(animals.name) DESC LIMIT 1;
-- Who was Maisy Smith's first visit?
SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id WHERE vets.name = 'Maisy Smith' ORDER BY date_of_visit ASC LIMIT 1;
-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, vets.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON visits.vet_id = vets.id ORDER BY visits.date_of_visit DESC LIMIT 1;
-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM visits JOIN vets ON visits.vet_id = vets.id JOIN animals ON visits.animal_id = animals.id WHERE vets.id NOT IN (SELECT vets.id FROM vets JOIN specializations ON vets.id = specializations.vet_id WHERE specializations.species_id = animals.species_id);
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(*) FROM visits JOIN vets ON vets.id = visits.vet_id JOIN animals ON animals.id = visits.animal_id JOIN species ON species.id = animals.species_id WHERE vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY count DESC LIMIT 1;



SELECT COUNT(*) FROM visits where animal_id = 4;
-- Find a way to decrease the execution time of the first query. Look for hints in the previous lessons.
CREATE INDEX id on visits(animals_id);

SELECT * FROM visits where vet_id = 2;
CREATE INDEX id_vet on visits(vet_id);
