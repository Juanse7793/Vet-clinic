CREATE TABLE medical_histories (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP,
  patient_id INTEGER,
  status VARCHAR(255),
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
);

CREATE TABLE invoices (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  total_amount DECIMAL(10,2),
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INTEGER,
);

CREATE TABLE treatments (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  type VARCHAR(255),
  name VARCHAR(255),
);

ALTER TABLE medical_histories ADD CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES patients (id);
ALTER TABLE invoice_items ADD CONSTRAINT fk_invoice FOREIGN KEY (invoice_id) REFERENCES invoices (id);
ALTER TABLE invoices ADD CONSTRAINT fk_med_his FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id);
ALTER TABLE treatments ADD CONSTRAINT fk_id FOREIGN KEY (id) REFERENCES medical_histories (id);
ALTER TABLE invoice_items ADD CONSTRAINT fk_treatment FOREIGN KEY (treatment_id) REFERENCES treatments (id);

-- join table for many to many relationship between medical_histories and treatments
CREATE TABLE medical_histories_treatments (
  id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  treatment_id INTEGER,
  medical_history_id INTEGER,
  FOREIGN KEY (treatment_id) REFERENCES treatments(id),
  FOREIGN key (medical_history_id) REFERENCES medical_histories(id)
);

CREATE INDEX id_patient on medical_histories(patient_id);
CREATE INDEX id_invoice on invoice_items(invoice_id);
CREATE INDEX id_medical_history on invoices(medical_history_id);
CREATE INDEX id_treatments on treatments(id);
CREATE INDEX id_treatment_invoice_items on invoice_items(treatment_id);

CREATE INDEX medical_histories_treatments_id on medical_histories_treatments(treatment_id);
CREATE INDEX id_medical_histories_treatments on medical_histories_treatments(medical_history_id);