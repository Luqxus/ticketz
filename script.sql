DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Tickets;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
  uid VARCHAR PRIMARY KEY,
  email VARCHAR UNIQUE NOT NULL,
  username VARCHAR NOT NULL,
  password VARCHAR NOT NULL,
  created_at TIMESTAMP NOT NULL
);

CREATE TABLE Events (
  event_id VARCHAR PRIMARY KEY,
  organizer VARCHAR NOT NULL,
  title VARCHAR,
  description VARCHAR,
  ticket_price FLOAT,
  event_date TIMESTAMP,
  end_time TIMESTAMP,
  image_url VARCHAR,
  created_at TIMESTAMP
);

CREATE TABLE Locations (
  location_id VARCHAR PRIMARY KEY,
  event_id VARCHAR UNIQUE NOT NULL,
  venue VARCHAR NOT NULL,
  city VARCHAR NOT NULL,
  province VARCHAR NOT NULL,
  country VARCHAR NOT NULL
);

CREATE TABLE Tickets (
    ticket_id VARCHAR PRIMARY KEY,
    event_id VARCHAR NOT NULL,
    uid VARCHAR NOT NULL
);

-- Add Foreign Key Constraints
ALTER TABLE Tickets
ADD CONSTRAINT fk_event
FOREIGN KEY (event_id) REFERENCES Events(event_id);

ALTER TABLE Tickets
ADD CONSTRAINT fk_user
FOREIGN KEY (uid) REFERENCES Users(uid);

ALTER TABLE Locations
ADD FOREIGN KEY (event_id) REFERENCES Events (event_id);

ALTER TABLE Events
ADD FOREIGN KEY (organizer) REFERENCES Users (uid);