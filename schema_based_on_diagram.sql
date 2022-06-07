CREATE TABLE medical_histories (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP,
  patient_id INTEGER,
  status VARCHAR(255),
  FOREIGN KEY (patient_id) REFERENCES patients (id)
);

CREATE TABLE patients (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255),
  date_of_birth DATE,
);

CREATE TABLE invoice_items (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL(10,2),
  quantity INTEGER,
  total_price DECIMAL(10,2),
  invoice_id INTEGER,
  treatment_id INTEGER,
  FOREIGN KEY (invoice_id) REFERENCES invoices (id)
);