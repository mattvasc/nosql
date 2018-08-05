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
SELECT `state` FROM `names` WHERE `name` = 'Anna' GROUP BY `state`,`genre`,`name` ORDER BY `occurrences` DESC;
-- [Mateus] Estou em dúvida, será que não é: 
SET LOCAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SELECT * FROM (
SELECT `state`, SUM(occurrences) AS popularidade FROM `names` WHERE `name` = 'Anne' group by `state`, `genre` ORDER BY popularidade DESC) AS temp HAVING popularidade = MAX(popularidade);
-- [FIM Mateus]
-- Quais foram os N nomes mais populares no estado X?
SELECT SUM(occurrences) as popularidade, name FROM `names` WHERE `state` = 'NY' GROUP BY `name` ORDER BY popularidade DESC;

-- Queries da Carla. ------------------------------------------------------------------------------------
--Em que ano o nome X foi mais popular?
SELECT `year` FROM (SELECT `year`, MAX(occurrences) as popularidade FROM `names` WHERE `name` = 'Mary' GROUP BY `year`) AS temp--Qual seria a porcentagem de registros masculinos no Estado X e ano Y?


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
SELECT * FROM names WHERE YEAR =2000 AND genre='F' AND (occurrences) IN 
( SELECT MAX(occurrences)
  FROM names WHERE  year = 2000 AND genre = 'F'
)
UNION
SELECT * FROM names WHERE YEAR =2000 AND genre='M' AND (occurrences) IN 
( SELECT MAX(occurrences)
  FROM names WHERE  year = 2000 AND genre = 'M'
);

-- Faça um Ranking de maior desbalanço de gênero de crianças de masculino e feminino, mostrando o ano, estado e a medida de desbalanço.
SELECT `state`, `year`, 
SUM(CASE WHEN `genre`='M' THEN occurrences ELSE 0 END) AS `meninos`, 
SUM(CASE WHEN `genre`='F' THEN occurrences ELSE 0 END) AS `meninas`,
ABS(SUM(CASE WHEN `genre`='M' THEN occurrences ELSE 0 END) - SUM(CASE WHEN `genre`='F' THEN occurrences ELSE 0 END))/(SUM(CASE WHEN `genre`='M' THEN occurrences ELSE 0 END) + SUM(CASE WHEN `genre`='F' THEN occurrences ELSE 0 END)) AS `desigualdade`
FROM `names` 
-- WHERE year = 1910 AND state = 'AK'
GROUP BY `state`, `year` ORDER BY desigualdade DESC ;
