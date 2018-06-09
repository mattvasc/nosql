USE trabalho;


-- Queries do Bruno. ------------------------------------------------------------------------------------

-- Quais estados nasceram mais pessoas com o nome X?
SELECT * FROM `names` WHERE `name` = 'Anna' GROUP BY `state` ORDER BY `occurrences` DESC LIMIT 5; 

-- Quais foram os N nomes mais populares no estado X?
SELECT SUM(occurrences) as popularidade, name FROM `names` WHERE `state` = 'NY' GROUP BY `name` ORDER BY popularidade DESC LIMIT 5;

-- Queries da Carla. ------------------------------------------------------------------------------------
-- 

-- Queries do Mateus ------------------------------------------------------------------------------------

-- Qual o nome feminino e masculino mais comuns do país no ano X?
SELECT `name`, genre, MAX(popularidade) FROM (SELECT  `name`, genre, SUM(occurrences) as popularidade FROM `names` WHERE genre = 'F' GROUP BY `name` ORDER BY popularidade DESC) AS temp
UNION
SELECT `name`, genre, MAX(popularidade) FROM (SELECT  `name`, genre, SUM(occurrences) as popularidade FROM `names` WHERE genre = 'M' GROUP BY `name` ORDER BY popularidade DESC) AS temp;

-- Qual o nome feminino e masculino que foram mais comuns em um número maior de anos?
-- In progress
