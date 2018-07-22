-- Para criar um container mysql: 
-- # docker pull mysql:5.7
-- # docker run --name mysqlc -e MYSQL_ROOT_PASSWORD=root  -p 3306:3306 -d mysql:5.7

CREATE DATABASE IF NOT EXISTS trabalho;
USE trabalho;
CREATE TABLE IF NOT EXISTS names(
    state CHAR(2),
    genre CHAR(1),
    year INT,
    name VARCHAR(64),
    occurrences  INT,
    PRIMARY KEY (state, name, genre, year)
);

-- Queries do Bruno. ------------------------------------------------------------------------------------

-- Quais estados nasceram mais pessoas com o nome X?
SELECT * FROM `names` WHERE `name` = 'Anna' GROUP BY `state` ORDER BY `occurrences` DESC;

-- Quais foram os N nomes mais populares no estado X?
SELECT SUM(occurrences) as popularidade, name FROM `names` WHERE `state` = 'NY' GROUP BY `name` ORDER BY popularidade DESC;

-- Queries da Carla. ------------------------------------------------------------------------------------
--Em que ano o nome X foi mais popular?
SELECT `year` FROM (SELECT `year`, MAX(occurences) as popularidade FROM `names` WHERE `name` = 'Mary') AS temp

--Qual seria a porcentagem de registros masculinos no Estado X e ano Y?

SELECT CAST(ROUND(temp, 2) AS DECIMAL (5,2)) as porcentagem
FROM (
    (SELECT (
        (SELECT count(name)
            FROM `names`
                WHERE `state` = 'NY' AND `year` = '1910' AND `genre` = 'M'
        )* 100 /
        (SELECT COUNT(name)
            FROM `names`
                WHERE `year` = '1910' AND `genre`= 'M')
        ) as temp
    FROM `names` LIMIT 1
    )
) temporaria

-- Queries do Mateus ------------------------------------------------------------------------------------

-- Qual o nome feminino e masculino mais comuns do país no ano X?
SELECT `name`, genre, MAX(popularidade) FROM (SELECT  `name`, genre, SUM(occurrences) as popularidade FROM `names` WHERE genre = 'F' GROUP BY `name` ORDER BY popularidade DESC) AS temp
UNION
SELECT `name`, genre, MAX(popularidade) FROM (SELECT  `name`, genre, SUM(occurrences) as popularidade FROM `names` WHERE genre = 'M' GROUP BY `name` ORDER BY popularidade DESC) AS temp;

-- Qual o nome feminino e masculino que foram mais comuns em um número maior de anos?
-- In progress
