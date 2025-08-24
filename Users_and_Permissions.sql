-- Criação de usuário
CREATE USER 'usuario1'@'localhost' IDENTIFIED BY '1234';

-- Criação de usuário com host específico
CREATE USER 'nome_usuario'@'Neste campo vai o host' IDENTIFIED BY 'senha';

-- Permissão em banco de dados
GRANT ALL PRIVILEGES ON estudo_de_caso.* TO 'usuario1'@'localhost';

-- Permissão em tabela específica
GRANT SELECT, INSERT, UPDATE ON estudo_de_caso.alunos TO 'usuario2'@'localhost';

-- Aplicar alterações
FLUSH PRIVILEGES;

-- Ver todos os usuarios
SELECT user, host 
FROM mysql.user;

-- Ver permissoes de um usuarios especifico
SHOW GRANTS FOR 'usuario2'@'localhost';

-- Ver todas as permissoes de todos os usuarios
SELECT CONCAT("SHOW GRANTS FOR '", user, "'@'", host, "';") 
FROM mysql.user;


