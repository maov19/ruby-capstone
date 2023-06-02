--Create database
CREATE DATABASE my_catalog;

-- Create item table
CREATE TABLE item (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  genre_id INT,
  author_id INT,
  label_id INT,
  publish_date DATE,
  archived BOOLEAN,
  FOREIGN KEY (genre_id) REFERENCES genre(id),
  FOREIGN KEY (author_id) REFERENCES author(id),
  FOREIGN KEY (label_id) REFERENCES label(id)
);

-- Create label table
CREATE TABLE label (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title VARCHAR(100),
  color VARCHAR(100),
  items INT[]
);

-- Create book table (specialized form of item)
CREATE TABLE book (
  item_id INT PRIMARY KEY,
  publisher VARCHAR(100),
  cover_state VARCHAR(100),
  FOREIGN KEY (item_id) REFERENCES item(id)
);

-- Create genres table
CREATE TABLE genres (
  id INT Generated ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100),
);

-- Create music albums table
CREATE TABLE music_albums (
  id INT Generated ALWAYS AS IDENTITY PRIMARY KEY,
  publish_date DATE NOT NULL DEFAULT DATE,
  on_spotify BOOLEAN,
  archived BOOLEAN,
  genre_id INT,
  CONSTRAINT fk_genre FOREIGN KEY (genre_id) REFERENCES genres(id)
);

-- Create author table
CREATE TABLE AUTHOR(
    id INT GENERATED ALWAYS AS IDENTITY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,

    PRIMARY KEY (id)
);

-- Create games table
CREATE TABLE GAME(
    id int NOT NULL,
    multiplayer BOOLEAN NOT NULL,
    last_played_at DATE NOT NULL,

    FOREIGN KEY (id) REFERENCES ITEM(id) ON DELETE CASCADE ON UPDATE CASCADE
);