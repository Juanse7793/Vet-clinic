/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
   id INT PRIMARY KEY,
   name           TEXT,
   date_of_birth   DATE,
   escape_attempts INT,
   neutered         BOOLEAN,
   weight_kg       DECIMAL
);

CREATE TABLE owners (
   id INT GENERATED ALWAYS AS IDENTITY,
   full_name TEXT,
   age INT,
   PRIMARY KEY (id)
);
