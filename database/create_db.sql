DROP DATABASE IF EXISTS SpaceChat;
CREATE DATABASE SpaceChat;
\connect SpaceChat;
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
	id_settings int REFERENCES settings(id_settings)
);
CREATE TABLE IF NOT EXISTS room_type(
	id_type serial PRIMARY KEY,
);
CREATE TABLE IF NOT EXISTS rooms(
	id_room serial PRIMARY KEY,
	room_name varchar(40) UNIQUE NOT NULL,
	room_type int REFERENCES room_type(id_type)
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

INSERT INTO users (username, password, id_settings) 
VALUES ('shaman', 'fca44c330f5fc4d4034d83f83da7dd57', 1);
INSERT INTO users_rooms (id_user, id_room) VALUES (1, 1);

CREATE ROLE roman WITH PASSWORD 'qaz147890';
ALTER ROLE roman LOGIN;
ALTER ROLE roman SUPERUSER;
