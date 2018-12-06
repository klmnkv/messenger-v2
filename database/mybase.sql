DROP DATABASE IF EXISTS kolomnikov_db;
CREATE DATABASE kolomnikov_db;
\connect kolomnikob_db;
CREATE TABLE IF NOT EXISTS settings(
	id_settings serial PRIMARY KEY,
	bg varchar(7) NOT NULL,
	fg varchar(7) NOT NULL,
	bd int NOT NULL
);

CREATE TABLE IF NOT EXISTS users(
	id_user serial PRIMARY KEY,
	username varchar(32) UNIQUE NOT NULL,
	password varchar(32) NOT NULL,
	status int REFERENCES statuses(id_status),
	id_settings int REFERENCES settings(id_settings)
);

CREATE TABLE IF NOT EXISTS rooms(
	id_room serial PRIMARY KEY,
	room_name varchar(40) UNIQUE NOT NULL
);
CREATE TABLE IF NOT EXISTS users_rooms(
	id_reference serial PRIMARY KEY,
	id_room int REFERENCES rooms(id_room),
	id_user int REFERENCES users(id_user)
);
CREATE TABLE IF NOT EXISTS messages(
	id_message serial PRIMARY KEY,
	id_sender int REFERENCES users(id_user),
	id_room int REFERENCES rooms(id_room),
	dt varchar(60) NOT NULL,
	message text NOT NULL
);

INSERT INTO rooms (room_name) VALUES ('Тестирование', 1);
INSERT INTO users (username, password, id_settings)
VALUES ('Polyakov', '12345', 1);
VALUES ('Nikiforov', '12345', 1);
INSERT INTO users_rooms (id_user, id_room) VALUES (1, 1);

CREATE ROLE kolomnikovdb WITH PASSWORD 'kolomnikov';
ALTER ROLE kolomnikov LOGIN;
ALTER ROLE kolomnikov SUPERUSER;
