-- Drop tables in the correct order to handle dependencies
DROP TABLE IF EXISTS Establishment_Games CASCADE;
DROP TABLE IF EXISTS Schedule CASCADE;
DROP TABLE IF EXISTS Establishment CASCADE;
DROP TABLE IF EXISTS Account CASCADE;
DROP TABLE IF EXISTS manager_information CASCADE;

-- Drop types (order doesn't matter for independent types)
DROP TYPE IF EXISTS game_type;
DROP TYPE IF EXISTS day_of_week;
DROP TYPE IF EXISTS price;
DROP TYPE IF EXISTS role;

-- Drop the sequence if it exists
DROP SEQUENCE IF EXISTS establishment_seq;
DROP SEQUENCE IF EXISTS manager_information_seq;

-- Create types
CREATE TYPE game_type AS ENUM (
    'POOL', 'DARTS', 'BABYFOOT', 'PINGPONG', 'ARCADE',
    'PINBALL', 'KARAOKE', 'CARDS', 'BOARDGAME', 'PETANQUE'
);

CREATE TYPE day_of_week AS ENUM (
    'MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY',
    'FRIDAY', 'SATURDAY', 'SUNDAY'
);

CREATE TYPE price AS ENUM (
    'LOW', 'MEDIUM', 'HIGH'
);

CREATE TYPE role AS ENUM (
    'USER', 'ADMIN', 'MANAGER'
);

-- Create tables
CREATE TABLE manager_information
(
    id           BIGINT PRIMARY KEY, -- ID unique du manager
    surname      VARCHAR(255) NOT NULL,             -- Nom de famille du manager
    firstname    VARCHAR(255) NOT NULL,             -- Prénom du manager
    phone_number VARCHAR(20),                       -- Numéro de téléphone du manager
    siren_number VARCHAR(14)                        -- Numéro SIREN du manager
);

CREATE TABLE Account
(
    id                     BIGINT PRIMARY KEY,
    username               VARCHAR(255) NOT NULL UNIQUE,
    emailAddress           VARCHAR(255) NOT NULL UNIQUE,
    createdAt              DATE         NOT NULL,
    password               VARCHAR(255) NOT NULL,
    role                   role         NOT NULL,
    manager_information_id BIGINT,    -- Clé étrangère vers manager_information
    CONSTRAINT fk_manager_information -- Clé étrangère
        FOREIGN KEY (manager_information_id)
            REFERENCES manager_information (id)
            ON DELETE CASCADE
);

CREATE TABLE Establishment
(
    id                 BIGINT PRIMARY KEY,
    name               VARCHAR(255) NOT NULL,
    address            VARCHAR(255) NOT NULL,
    site               VARCHAR(255) NOT NULL,
    description        TEXT         NOT NULL,
    proximityTransport BOOLEAN DEFAULT FALSE,
    accessPRM          BOOLEAN DEFAULT FALSE,
    price              price,
    emailAddress       VARCHAR(255) NOT NULL,
    phoneNumber        VARCHAR(255) NOT NULL,
    longitude          DECIMAL      NOT NULL,
    latitude           DECIMAL      NOT NULL,
    isDisplayed        BOOLEAN DEFAULT FALSE,
    CONSTRAINT check_longitude CHECK (longitude >= -180 AND longitude <= 180),
    CONSTRAINT check_latitude CHECK (latitude >= -90 AND latitude <= 90)
);

CREATE TABLE Establishment_Games
(
    idEstablishment BIGINT,
    game            game_type,
    numberOfGame    INTEGER,
    PRIMARY KEY (idEstablishment, game),
    FOREIGN KEY (idEstablishment) REFERENCES Establishment (id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Schedule
(
    idEstablishment BIGINT,
    dayOfWeek       day_of_week NOT NULL,
    openingTime     TIME        NOT NULL,
    closingTime     TIME        NOT NULL,
    isClosed        BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (idEstablishment) REFERENCES Establishment (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (idEstablishment, dayOfWeek)
);

-- Create indexes
CREATE INDEX idx_establishment_games_establishment ON Establishment_Games (idEstablishment);
CREATE INDEX idx_schedule_establishment ON Schedule (idEstablishment);

-- Create sequences
CREATE SEQUENCE establishment_seq;
CREATE SEQUENCE manager_information_seq;
CREATE SEQUENCE account_seq;