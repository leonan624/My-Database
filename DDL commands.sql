-- criando banco de dados
create database EStudo_de_caso;

-- acessando o banco
use EStudo_de_caso;

-- Cada tabela é criada com sua chave primária e atributos.
-- As chaves estrangeiras são adicionadas no final para garantir que
-- as tabelas referenciadas existam.

-- Tabela AUTOR
CREATE TABLE AUTOR
(
    idAutor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    sexo CHAR(1) NOT NULL,
    nacionalidade VARCHAR(100) NOT NULL,
    nascimento DATE NOT NULL
);

-- Tabela EDITORA
CREATE TABLE EDITORA
(
    idEditora INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    UF CHAR(2) NOT NULL,
    fundacao YEAR NOT NULL
);

-- Tabela ALUNOS
CREATE TABLE ALUNOS
(
    idAlunos INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    matricula VARCHAR(20) NOT NULL, -- Matrícula pode ter letras e ser mais longa
    curso VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE -- O e-mail deve ser único para cada aluno
);

-- Tabela LIVROS
-- Removemos a chave estrangeira para EMPRESTIMOS, pois a relação é 1:N com EMPRESTIMOS
-- A chave estrangeira para EDITORA será adicionada no final.
CREATE TABLE LIVROS
(
    idLivros INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL, -- Nome do livro (título)
    paginas INT NOT NULL,
    preco DECIMAL(10, 2) NOT NULL, -- Usamos DECIMAL para preços
    ano_publicacao INT NOT NULL,
    idEDITORA INT NOT NULL
);

-- Tabela EMPRESTIMOS
-- A chave primária é a combinação de livro e aluno para um empréstimo específico,
-- ou simplesmente uma chave única para cada empréstimo.
CREATE TABLE EMPRESTIMOS
(
    idEmprestimo INT PRIMARY KEY AUTO_INCREMENT,
    data_do_emprestimo DATE NOT NULL,
    data_da_devolucao_prevista DATE NOT NULL,
    data_da_devolucao_real DATE, -- A data de devolução real pode ser nula
    idLIVROS INT NOT NULL,
    idALUNOS INT NOT NULL
);

-- Tabela associativa Rautor (para o relacionamento N:N entre AUTOR e LIVROS)
CREATE TABLE Rautor
(
    idAUTOR INT NOT NULL,
    idLIVROS INT NOT NULL,
    PRIMARY KEY (idAUTOR, idLIVROS) -- Chave primária composta
);

-- Adição das chaves estrangeiras (FOREIGN KEY)

-- As chaves estrangeiras são adicionadas após a criação de todas as tabelas,
-- garantindo que as tabelas de referência já existem.

-- Tabela LIVROS: Chave estrangeira para EDITORA
ALTER TABLE LIVROS
ADD FOREIGN KEY (idEDITORA) REFERENCES EDITORA(idEditora);

-- Tabela EMPRESTIMOS: Chave estrangeira para LIVROS
ALTER TABLE EMPRESTIMOS
ADD FOREIGN KEY (idLIVROS) REFERENCES LIVROS(idLivros);

-- Tabela EMPRESTIMOS: Chave estrangeira para ALUNOS
ALTER TABLE EMPRESTIMOS
ADD FOREIGN KEY (idALUNOS) REFERENCES ALUNOS(idAlunos);

-- Tabela Rautor: Chave estrangeira para AUTOR
ALTER TABLE Rautor
ADD FOREIGN KEY (idAUTOR) REFERENCES AUTOR(idAutor);

-- Tabela Rautor: Chave estrangeira para LIVROS
ALTER TABLE Rautor
ADD FOREIGN KEY (idLIVROS) REFERENCES LIVROS(idLivros);

-- insert na tabela autor
INSERT INTO AUTOR (nome, sexo, nascimento, nacionalidade) VALUES
('William Shakespeare', 'M', '1564-04-23', 'Inglês'),
('George Orwell', 'M', '1903-06-25', 'Inglês'),
('J.K. Rowling', 'F', '1965-07-31', 'Britânica'),
('Gabriel García Márquez', 'M', '1927-03-06', 'Colombiano'),
('Machado de Assis', 'M', '1839-06-21', 'Brasileiro'),
('Jane Austen', 'F', '1775-12-16', 'Britânica'),
('Ernest Hemingway', 'M', '1899-07-21', 'Americano'),
('Franz Kafka', 'M', '1883-07-03', 'Tcheco'),
('Leo Tolstoy', 'M', '1828-09-09', 'Russo'),
('J.R.R. Tolkien', 'M', '1892-01-03', 'Britânico');

select * from autor;

-- insert na tabela alunos
INSERT INTO ALUNOS (nome, matricula, curso, email) VALUES
('Erik de Andrade', '107656', 'Administração', 'Erik2K@gmail.com'),
('Luiz oliveira da Silva', '234678', 'Pedagogia', 'Lulliver123@hotmail.com'),
('Adalberto de souza Morais', '107787', 'Administração', 'ADA2987@gmail.com'),
('Julia dos Santos Vasconcelos', '330990', 'Direito', 'JSV2025@gmail.com'),
('Ana Paiva Nogueira', '102882', 'Administração', 'anapaivano13@hotmail.com'),
('Maria Medeiros', '246767', 'Sociologia', 'MM2233med@gmail.com'),
('Jessica Saraiva da Silva', '223453', 'Tecnologia', 'JessicaS&S@gmail.com'),
('Manoel Neto de Souza', '109992', 'Administração', 'Manoel2025@gmail.com'),
('Tulio Oliveira', '234560', 'Pedagogia', 'TulioOliveiraW@gmail.com'),
('Niara Olinda Flor', '223444', 'Tecnologia', 'OlindaFlor3@gmail.com');

select * from alunos;

-- insert na tabela editora
INSERT INTO EDITORA (nome, UF, fundacao) VALUES
('Companhia das Letras', 'SP', '1986'),
('Rocco', 'RJ', '1976'),
('Record', 'RJ', '1942'),
('Ateliê Editorial', 'SP', '1999'),
('Martin Claret', 'SP', '1978'),
('Bertrand Brasil', 'RJ', '1941'),
('L&PM Editores', 'RS', '1974'),
('Cosac Naify', 'SP', '1997'),
('HarperCollins Brasil', 'SP', '2015');

select * from editora;

-- insert na tabela emprestimos
-- tera que associar os id das chaves estrangeiras
INSERT INTO EMPRESTIMOS (data_do_emprestimo, data_da_devolucao_prevista, data_da_devolucao_real, idLIVROS, idALUNOS) VALUES
('2025-08-02', '2025-08-29', '2025-08-30', 1, 1),
('2025-08-02', '2025-08-29', '2025-08-31', 2, 6),
('2025-08-04', '2025-09-01', '2025-09-01', 6, 2),
('2025-07-29', '2025-08-27', '2025-08-28', 7, 7),
('2025-08-03', '2025-08-30', '2025-08-31', 8, 3),
('2025-08-05', '2025-09-02', '2025-09-02', 8, 8),
('2025-07-28', '2025-08-26', '2025-08-26', 10, 4),
('2025-07-30', '2025-08-27', '2025-08-28', 3, 9),
('2025-08-01', '2025-08-30', '2025-08-31', 6, 5),
('2025-08-03', '2025-08-31', '2025-09-01',1,10);

select * from emprestimos;

-- insert na tabela livros
INSERT INTO LIVROS (nome, paginas, preco, ano_publicacao, idEDITORA) VALUES
('Hamlet', 145, 24.00, 1600, 1),
('1984', 352, 34.90, 1949, 2),
('Harry Potter e a Pedra Filosofal', 256, 34.99, 1997, 2),
('Cem Anos de Solidão', 448, 62.21, 1967, 9),
('Dom Casmurro', 232, 21.00, 1899, 1),
('Orgulho e Preconceito', 420, 37.90, 1813, 5),
('O Velho e o Mar', 126, 43.71, 1952, 6),
('A Metamorfose', 96, 28.59, 1915, 4),
('Guerra e Paz', 976, 105.31, 1867, 7),
('O Senhor dos Anéis', 1280, 104.90, 1955, 8);

select * from livros;

INSERT INTO rautor (idautor, idlivros) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);

select * from rautor;




