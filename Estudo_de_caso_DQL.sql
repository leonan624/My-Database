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
select 

