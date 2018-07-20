CREATE KEYSPACE IF NOT EXISTS trabalho
WITH REPLICATION = {
 'class' : 'SimpleStrategy',
 'replication_factor' : 1
};

CREATE TABLE names(
  state varchar,
  genre varchar,
  year int,
  name varchar,
  occurrences int,
  PRIMARY KEY (state, name, genre, year)
)

COPY names(state, genre, year, name, occurrences) FROM 'ALL_STATES.csv' WITH DELIMITER ',';
