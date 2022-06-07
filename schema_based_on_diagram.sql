CREATE TABLE medical_histories (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP,
  patient_id INTEGER,
  status VARCHAR(255),
  FOREIGN KEY (patient_id) REFERENCES patients (id)
);
