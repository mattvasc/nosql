CREATE KEYSPACE IF NOT EXISTS trabalho
WITH REPLICATION = {
 'class' : 'SimpleStrategy',
 'replication_factor' : 1
};

USE trabalho;

CREATE TABLE names(
  state varchar,
  genre varchar,
  year int,
  name varchar,
  occurrences int,
  PRIMARY KEY (state, name, genre, year)
)

COPY names(state, genre, year, name, occurrences) FROM 'ALL_STATES.csv' WITH DELIMITER = ',';

-- Para mostrar os tempos de execucao
tracing on;
/*
QUERY 1 com LIMIT 5
-- ANTES - sem reiniciar o container
17:05:46.141000
17:05:46.168137

-- DEPOIS - conteiner reiniciado
17:15:45.628000
17:15:45.827582

QUERY 2 com LIMIT 5
17:25:21.013000
17:25:21.048273


************************QUERY 1 */
-- CRIANDO TABELA
DROP TABLE IF EXISTS busca1;
CREATE TABLE busca1(
    state TEXT,
    genre TEXT,
    year INT,
    name TEXT,
    occurrences  INT,
		PRIMARY KEY((name), occurrences)
);
-- POVOANDO TABELA
COPY busca1(state,genre,year,name,occurrences) FROM 'sample.csv';
--      query:
SELECT state, occurrences FROM pname3 WHERE name = 'Anne' ORDER BY occurrences DESC LIMIT 1;
/*
17:32:01.369000
17:32:02.069252

************************QUERY 2 */
-- CRIANDO TABELA
DROP TABLE IF EXISTS busca2;
CREATE TABLE busca2(
    state TEXT,
    genre TEXT,
    year INT,
    name TEXT,
    occurrences  INT,
		PRIMARY KEY((state), occurrences)
);
-- POVOANDO TABELA
COPY busca2(state,genre,year,name,occurrences) FROM 'sample.csv';
--      query:
SELECT name FROM busca2 WHERE state = 'NY' ORDER BY occurrences DESC limit 10;
/*
17:38:42.087000
17:39:01.309574
*/

-- Qual o nome mais comuns do país no ano X?    [not 100%, but is something]
-- Cassandra não ordena por coluna agregada!!!! 
DROP TABLE IF EXISTS busca5;
CREATE TABLE busca5(
    state TEXT,
    genre TEXT,
    year INT,
    name TEXT,
    occurrences  INT,
		PRIMARY KEY( name,occurrences)
);
COPY busca5(state,genre,year,name,occurrences) FROM 'sample.csv';
SELECT name, SUM(occurrences) AS popularidade FROM busca5 WHERE year = 2000  GROUP BY name  ALLOW FILTERING;
