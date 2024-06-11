DROP TABLE IF EXISTS buy, sell, clients, gameboards, publishers, stores;

CREATE TABLE buy (
  PRIMARY KEY (client_id, store_id , gameboard_id ),
  client_id         INT NOT NULL,
  store_id         INT NOT NULL,
  gameboard_id  INT NOT NULL,
  date_achat        TIMESTAMP
);

CREATE TABLE clients (
  PRIMARY KEY (client_id),
  client_id     SERIAL,
  name           VARCHAR(42),
  email VARCHAR(42) CHECK(regexp_like(email, '[a-zA-Z0-9_]{1,4}?@[a-z0-9]+\.[a-z0-9]{1,3}')) UNIQUE,
  age           INT CHECK(age >= 18)
);

CREATE TABLE publishers (
  PRIMARY KEY (publisher_id),
  publisher_id     SERIAL,
  publisher_name VARCHAR(42),
  location   VARCHAR(42)
);

CREATE TABLE gameboards (
  PRIMARY KEY (gameboard_id ),
  gameboard_id  SERIAL NOT NULL,
  type              VARCHAR(42) CHECK(type in ('RPG', 'PUZZLE', 'DECK BUILDING')),
  age               INT CHECK(age > 0),
  title             VARCHAR(42),
  max_nb_players        INT CHECK(max_nb_players > 0),
  publisher_id        INT NOT NULL
);

CREATE TABLE stores (
  PRIMARY KEY (store_id ),
  store_id  SERIAL NOT NULL,
  website    VARCHAR(42) CHECK(regexp_like(website, '.+\.[a-z0-9]{1,4}'))
);

CREATE TABLE sell (
  PRIMARY KEY (store_id , gameboard_id ),
  store_id         INT NOT NULL,
  gameboard_id  INT NOT NULL,
  price              FLOAT check(price >= 0)
);

ALTER TABLE buy ADD FOREIGN KEY (gameboard_id ) REFERENCES gameboards (gameboard_id );
ALTER TABLE buy ADD FOREIGN KEY (store_id ) REFERENCES stores(store_id );
ALTER TABLE buy ADD FOREIGN KEY (client_id) REFERENCES clients (client_id);

ALTER TABLE gameboards ADD FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id);

ALTER TABLE sell ADD FOREIGN KEY (gameboard_id ) REFERENCES gameboards (gameboard_id );
ALTER TABLE sell ADD FOREIGN KEY (store_id ) REFERENCES stores(store_id );

