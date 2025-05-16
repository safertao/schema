CREATE TABLE patient (
	name VARCHAR(100), 
	age INTEGER, 
	gender VARCHAR(10), 
	id INTEGER NOT NULL, 
	created_at DATETIME, 
	updated_at DATETIME, birth_date DATE, contact TEXT, notes TEXT, has_arrhythmia BOOLEAN DEFAULT 0, user_id INTEGER, 
	PRIMARY KEY (id)
)
CREATE TABLE users (
	username VARCHAR(100) NOT NULL, 
	email VARCHAR(100) NOT NULL, 
	password_hash VARCHAR(255) NOT NULL, 
	full_name VARCHAR(255), 
	role VARCHAR(20) NOT NULL, 
	is_active BOOLEAN NOT NULL, 
	last_login DATETIME, 
	type VARCHAR(20), 
	id INTEGER NOT NULL, 
	created_at DATETIME, 
	updated_at DATETIME, avatar_url TEXT, birth_date DATE, gender VARCHAR(20), 
	PRIMARY KEY (id), 
	UNIQUE (username), 
	UNIQUE (email)
)
CREATE TABLE ecg_record (
	patient_id INTEGER, 
	record_name VARCHAR(50) NOT NULL, 
	record_path VARCHAR(255), 
	record_data BLOB, 
	ecg_metadata TEXT, 
	id INTEGER NOT NULL, 
	created_at DATETIME, 
	updated_at DATETIME, user_id INTEGER REFERENCES users(id), 
	PRIMARY KEY (id), 
	FOREIGN KEY(patient_id) REFERENCES patient (id)
)
CREATE TABLE doctors (
	id INTEGER NOT NULL, 
	specialty VARCHAR(100), 
	license_number VARCHAR(50), 
	PRIMARY KEY (id), 
	FOREIGN KEY(id) REFERENCES users (id)
)
CREATE TABLE admins (
	id INTEGER NOT NULL, 
	access_level INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(id) REFERENCES users (id)
)
CREATE TABLE prediction_result (
	ecg_record_id INTEGER NOT NULL, 
	class_id INTEGER NOT NULL, 
	class_name VARCHAR(50) NOT NULL, 
	class_description VARCHAR(255), 
	is_arrhythmia BOOLEAN, 
	probabilities TEXT, 
	inference_time FLOAT, 
	id INTEGER NOT NULL, 
	created_at DATETIME, 
	updated_at DATETIME, 
	PRIMARY KEY (id), 
	FOREIGN KEY(ecg_record_id) REFERENCES ecg_record (id)
)
CREATE TABLE medical_history (
	patient_id INTEGER NOT NULL, 
	record_date DATETIME, 
	diagnosis VARCHAR(255), 
	description TEXT, 
	treatment TEXT, 
	doctor_id INTEGER, 
	id INTEGER NOT NULL, 
	created_at DATETIME, 
	updated_at DATETIME, 
	PRIMARY KEY (id), 
	FOREIGN KEY(patient_id) REFERENCES patient (id), 
	FOREIGN KEY(doctor_id) REFERENCES doctors (id)
)
CREATE TABLE notification (
	recipient_id INTEGER NOT NULL, 
	title VARCHAR(100) NOT NULL, 
	content TEXT NOT NULL, 
	is_read BOOLEAN, 
	type VARCHAR(20), 
	id INTEGER NOT NULL, 
	created_at DATETIME, 
	updated_at DATETIME, 
	prediction_id INTEGER, 
	severity VARCHAR(20), 
	PRIMARY KEY (id), 
	FOREIGN KEY(recipient_id) REFERENCES users (id), 
	FOREIGN KEY(prediction_id) REFERENCES prediction_result (id)
)
CREATE TABLE doctor_patient (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                doctor_id INTEGER NOT NULL,
                patient_id INTEGER NOT NULL,
                assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (doctor_id) REFERENCES users(id),
                FOREIGN KEY (patient_id) REFERENCES patient(id))
CREATE TABLE sqlite_sequence(name,seq)
