/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (1, 'Agumon', '03/02/2020', 0, true, 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (2, 'Gabumon', '15/11/2018', 2, true, 8.00);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (3, 'Pikachu', '07/01/2021', 1, false, 15.04);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES (4, 'Devimon', '12/03/2017', 5, true, 11.00);

INSERT INTO animals (id, "name", date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES(5, 'Charmander', '2020-02-08', 0, false, 11.0, NULL);
INSERT INTO animals (id, "name", date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES(6, 'Plantmon', '2021-11-15', 2, true, 5.7, NULL);
INSERT INTO animals (id, "name", date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES(7, 'Squirtle', '1993-04-02', 3, false, 12.13, NULL);
INSERT INTO animals (id, "name", date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES(8, 'Angemon', '2005-06-12', 1, true, 45.0, NULL);
INSERT INTO animals (id, "name", date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES(9, 'Boarmon', '2005-06-07', 7, true, 20.4, NULL);
INSERT INTO animals (id, "name", date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES(10, 'Blossom', '1998-10-13', 3, true, 17.0, NULL);
INSERT INTO animals (id, "name", date_of_birth, escape_attempts, neutered, weight_kg, species) VALUES(11, 'Ditto', '2022-05-14', 4, true, 22.0, NULL);


BEGIN;
INSERT INTO owners VALUES
(DEFAULT, 'Sam Smith', 34),
(DEFAULT, 'Jennifer Orwell', 19),
(DEFAULT, 'Bob', 45),
(DEFAULT, 'Melody Pond', 77),
(DEFAULT, 'Dean Winchester', 14),
(DEFAULT, 'Jodie Whittaker', 38);
COMMIT;

BEGIN;
INSERT INTO species VALUES
(DEFAULT, 'Pokemon'),
(DEFAULT, 'Digimon');
COMMIT;

UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE name NOT LIKE '%mon';

UPDATE animals
SET owners_id =
  CASE name
    WHEN 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
    WHEN 'Gabumon' THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
    WHEN 'Pikachu' THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
    WHEN 'Devimon' THEN (SELECT id FROM owners WHERE full_name = 'Bob')
    WHEN 'Plantmon' THEN (SELECT id FROM owners WHERE full_name = 'Bob')
    WHEN 'Charmander' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
    WHEN 'Squirtle' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
    WHEN 'Blossom' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
    WHEN 'Angemon' THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
    WHEN 'Boarmon' THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
  END;

--   Insert the following data for vets:
-- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
INSERT INTO vets VALUES (DEFAULT, 'William Tatcher', 45, '2000-04-23');
-- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
INSERT INTO vets VALUES (DEFAULT, 'Maisy Smith', 26, '2019-01-17');
-- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
INSERT INTO vets VALUES (DEFAULT, 'Stephanie Mendez', 64, '1981-05-04');
-- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.

-- Insert the following data for specializations:
-- Vet William Tatcher is specialized in Pokemon.
INSERT INTO specializations VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon'));
-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
INSERT INTO specializations VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon'));
INSERT INTO specializations VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon'));
-- Vet Jack Harkness is specialized in Digimon.
INSERT INTO specializations VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));


-- Insert the following data for visits:
-- Agumon visited William Tatcher on May 24th, 2020.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-05-24');
-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-07-22');
-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-02');
-- Pikachu visited Maisy Smith on Jan 5th, 2020.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-01-05');
-- Pikachu visited Maisy Smith on Mar 8th, 2020.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-03-08');
-- Pikachu visited Maisy Smith on May 14th, 2020.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-05-14');
-- Devimon visited Stephanie Mendez on May 4th, 2021.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-05-04');
-- Charmander visited Jack Harkness on Feb 24th, 2021.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-24');
-- Plantmon visited Maisy Smith on Dec 21st, 2019.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21');
-- Plantmon visited William Tatcher on Aug 10th, 2020.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-08-10');
-- Plantmon visited Maisy Smith on Apr 7th, 2021.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-04-07');
-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019-09-29');
-- Angemon visited Jack Harkness on Oct 3rd, 2020.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-03');
-- Angemon visited Jack Harkness on Nov 4th, 2020.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-11-04');
-- Boarmon visited Maisy Smith on Jan 24th, 2019.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-01-24');
-- Boarmon visited Maisy Smith on May 15th, 2019.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-05-15');
-- Boarmon visited Maisy Smith on Feb 27th, 2020.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-02-27');
-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-08-03');
-- Blossom visited Stephanie Mendez on May 24th, 2020.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-05-24');
-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits VALUES ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-01-11');