-- Consultas Simples

-- Liste todos os nomes dos alunos cadastrados.
select nome from alunos
where matricula is not null;

-- Mostre o título e o preço dos livros publicados depois de 1900.
select nome, preco from livros
where ano_publicacao > 1900;

-- Liste os autores brasileiros (nacionalidade = "Brasileiro")
select nome from autor
where nacionalidade = 'Brasileiro';

-- Exiba os nomes e UFs das editoras fundadas antes de 2000 e nomeie uf para estado.
select nome, uf as estado from editora
where fundacao < 2000;

-- Mostre os empréstimos que foram devolvidos com atrasos, seus ids e nome dos livros
select E.idemprestimo, data_da_devolucao_real as data_do_atraso, (select P.nome from livros P
where E.idlivros = P.idlivros) as livro from emprestimos E
group by E.idemprestimo;

-- Consultas com Filtros e Ordenação

-- Liste os 5 livros mais caros, mostrando título e preço em ordem decrescente.
select nome as titulo, preco from livros 
where preco is not null 
order by preco desc limit 5;

-- Exiba os alunos do curso de Sistemas de Informação.
select nome as alunos from alunos
where curso = 'tecnologia';

-- Mostre os livros com mais de 500 páginas, ordenados pelo ano de publicação (do mais recente para o mais antigo).
select nome as titulo, paginas from livros
where paginas > 500
order by ano_publicacao asc;

-- Consultas com Junções (JOINs)

-- Liste os títulos dos livros e os nomes das editoras que os publicaram.
select livros.nome as titulos, editora.nome as editoras from livros
inner join editora on livros.idlivros = editora.ideditora;

-- Mostre o nome dos alunos e os títulos dos livros que eles pegaram emprestado.
SELECT a.nome AS aluno, l.nome AS livro FROM Alunos a
INNER JOIN Emprestimos e ON a.idalunos = e.idalunos
INNER JOIN Livros l ON e.idlivros = l.idlivros;

-- Liste os autores e os livros que eles escreveram.
select a.nome as autor, l.nome as titulo from autor a
inner join livros l on a.idautor = l.idlivros;

-- Exiba os empréstimos mostrando: nome do aluno, título do livro, data de empréstimo e data prevista de devolução.
select a.nome as aluno, l.nome as titulo, e.data_do_emprestimo, e.data_da_devolucao_prevista from emprestimos e
inner join livros l on l.idlivros = e.idlivros
inner join alunos a on a.idalunos = e.idalunos;

-- Consultas com Funções de Agregação

-- Mostre a quantidade total de alunos cadastrados.
select count(*) as Qtda_de_alunos from alunos;

-- Exiba a média de preço dos livros cadastrados.
select avg(preco) as preco from livros;

-- Mostre o total de livros publicados por cada editora.
select ( select count(l.idlivros) from livros l
        where l.ideditora = e.ideditora) as Total_de_livros_por_editora, e.nome as editora
        from editora e;

-- Liste o número de empréstimos realizados por cada aluno.
select ( select count(e.idemprestimo) from emprestimos e 
        where e.idALUNOS = a.idalunos) as Total_de_emprestimo_por_aluno, a.nome as aluno
        from alunos a;
        

-- Consultas Mais Complexas

-- Liste os alunos que nunca fizeram nenhum empréstimo.
select a.nome from alunos a
where a.idalunos not in(select e.idalunos from emprestimos e );

-- Exiba os livros que estão atualmente emprestados (sem data_real_devolucao).
SELECT l.nome AS livro
FROM Emprestimos e
INNER JOIN Livros l ON e.idlivros = l.idlivros
WHERE e.data_da_devolucao_real IS NULL;

-- Mostre os autores que possuem mais de 3 livros publicados.
SELECT a.nome AS autor,
       COUNT(l.idlivros) AS total_livros
FROM Autor a
INNER JOIN rautor r ON a.idautor = r.idautor
INNER JOIN Livros l ON r.idlivros = l.idlivros
GROUP BY a.nome
HAVING COUNT(l.idlivros) > 3;

-- Liste os alunos que pegaram mais de 5 livros emprestados ao longo do tempo.
