CREATE TYPE game_type AS ENUM (
    'POOL',
    'DARTS',
    'BABYFOOT',
    'PINGPONG',
    'ARCADE',
    'PINBALL',
    'KARAOKE',
    'CARDS',
    'BOARDGAME',
    'PETANQUE'
);

CREATE TYPE day_of_week AS ENUM (
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY'
);

CREATE TYPE price AS ENUM(
    'LOW',
    'MEDIUM',
    'HIGH'
);

CREATE TABLE Establishment
(
    id                 BIGINT PRIMARY KEY,
    name               VARCHAR(255) NOT NULL,
    address            VARCHAR(255) NOT NULL,
    site               VARCHAR(255) NOT NULL,
    description        Text         NOT NULL,
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
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Schedule
(
    idEstablishment BIGINT,
    dayOfWeek       day_of_week NOT NULL,
    openingTime     TIME NOT NULL,
    closingTime     TIME NOT NULL,
    isClosed        BOOLEAN DEFAULT false,
    FOREIGN KEY (idEstablishment) REFERENCES Establishment (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    PRIMARY KEY (idEstablishment, dayOfWeek)
);

CREATE INDEX idx_establishment_games_establishment ON Establishment_Games (idEstablishment);
CREATE INDEX idx_schedule_establishment ON Schedule (idEstablishment);
CREATE SEQUENCE establishment_seq;