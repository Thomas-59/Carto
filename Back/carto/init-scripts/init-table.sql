CREATE TYPE game_type AS ENUM (
    'POOL',
    'DARTS',
    'BABYFOOT',
    'BOWLING',
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

CREATE TABLE Establishment (
                               id BIGINT PRIMARY KEY,
                               name VARCHAR(255) NOT NULL,
                               cityName VARCHAR(255) NOT NULL,
                               longitude DECIMAL NOT NULL,
                               latitude DECIMAL NOT NULL,
                               description TEXT,
                               CONSTRAINT check_longitude CHECK (longitude >= -180 AND longitude <= 180),
                               CONSTRAINT check_latitude CHECK (latitude >= -90 AND latitude <= 90)
);

CREATE INDEX idx_establishment_city ON Establishment(cityName);

CREATE TABLE Establishment_Games (
                                     idEstablishment BIGINT,
                                     game game_type,
                                     numberOfGame INTEGER,
                                     PRIMARY KEY (idEstablishment, game),
                                     FOREIGN KEY (idEstablishment) REFERENCES Establishment(id)
                                         ON DELETE CASCADE
                                         ON UPDATE CASCADE
);

CREATE TABLE Schedule (
                          id BIGINT PRIMARY KEY,
                          idEstablishment BIGINT NOT NULL,
                          dayOfWeek day_of_week NOT NULL,
                          openingTime TIME NOT NULL,
                          closingTime TIME NOT NULL,
                          isClosed BOOLEAN DEFAULT false,
                          FOREIGN KEY (idEstablishment) REFERENCES Establishment(id)
                              ON DELETE CASCADE
                              ON UPDATE CASCADE,
                          UNIQUE (idEstablishment, dayOfWeek)
);

CREATE INDEX idx_establishment_games_establishment ON Establishment_Games(idEstablishment);
CREATE INDEX idx_schedule_establishment ON Schedule(idEstablishment);
CREATE SEQUENCE establishment_seq;