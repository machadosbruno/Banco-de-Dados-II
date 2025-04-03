--Criando o banco de dados
create database BDAula_02042025_3139786;

--Selecionando o banco de dados para execução das Querys
use BDAula_02042025_3139786;

--Criar o projeto do banco
--Exemplo 1
--Criando tabela TBDisciplina3139786
create table TBDisciplina3139786(
	IDDisciplina						int				not null primary key,
	NomeDisciplina						varchar(50)		not null,
	CargaHorario						int				not null,
	BimestreOfertado					int				not null,
	CodCurso							int				not null,
	DataCriacao							date			not null
);

--Criando tabela TBDocente3139786
create table TBDocente3139786(
	IDDocente							int				not null primary key,
	NomeDocente							varchar(50)		not null,
	Sexo								varchar(1)		not null,
	DataNascimento						date			not null,
	ValorHoraAula						decimal(10,2)	not null,
	CodFormacao							int				not null,
	CodCidade							int				not null,
	CodDepartamento						int				not null
);

--criando a Tabela TBDocenteDisciplina3139786
create table TBDocenteDisciplina3139786(
	CodDocente							int				not null,
	CodDisciplina						int				not null,
	DataAtribuicao						date			not null,
	primary key	(CodDocente, CodDisciplina),
	foreign key	(CodDocente) references TBDocente3139786 (IDDocente),
	foreign key	(CodDisciplina) references TBDisciplina3139786 (IDDisciplina),
);


--Exemplo 2

--Criando a tabela TBProduto3139786
create table TBProduto3139786(
	IDProduto							int				not null primary key,
	NomeProduto							varchar(50)		not null,
	Quantidade							int				not null,
	Preco								decimal(10,2)	not null,
	DataCompra							date			not null,
	DataValidade						date			not null,
	CodFornecedor						int				not null
);

--criando a tabela TBPedido3139786
create table TBPedido3139786(
	IDPedido							int				not null primary key,
	DataPedido							date			not null,
	DataEntrega							date			not null,
	CodCliente							int				not null,
	CodVendedor							int				not null,
	Observacao							varchar(300)	not null
);

--criando a tabela TBPedidoProduto3139786
create table TBPedidoProduto3139786(
	CodPedido							int				not null,
	CodProduto							int				not null,
	Quantidade							int				not null,
	PrecoVenda							decimal(10,2)	not null,
	primary key	(CodPedido, CodProduto),
	foreign key	(CodPedido) references TBPedido3139786 (IDPedido),
	foreign key (CodProduto) references TBProduto3139786 (IDProduto)
);

--Exercicio 2
--Criar os inserts

-- Inserts para TBDisciplina3139786
INSERT INTO TBDisciplina3139786 (IDDisciplina, NomeDisciplina, CargaHorario, BimestreOfertado, CodCurso, DataCriacao) VALUES
(1, 'Matemática I', 60, 1, 101, '2024-01-15'),
(2, 'Física Geral I', 60, 1, 102, '2024-01-15'),
(3, 'Química Básica', 45, 1, 103, '2024-01-20'),
(4, 'Introdução à Computação', 75, 1, 104, '2024-01-22'),
(5, 'Língua Portuguesa', 60, 1, 101, '2024-01-25'),
(6, 'Matemática II', 60, 2, 101, '2024-03-10'),
(7, 'Física Geral II', 60, 2, 102, '2024-03-12'),
(8, 'Química Orgânica', 45, 2, 103, '2024-03-15'),
(9, 'Algoritmos e Lógica de Programação', 75, 2, 104, '2024-03-18'),
(10, 'Literatura Brasileira', 60, 2, 101, '2024-03-20'),
(11, 'Cálculo I', 60, 3, 101, '2024-05-05'),
(12, 'Eletromagnetismo', 60, 3, 102, '2024-05-07'),
(13, 'Físico-Química', 45, 3, 103, '2024-05-10'),
(14, 'Estrutura de Dados', 75, 3, 104, '2024-05-12'),
(15, 'Redação Técnica', 60, 3, 101, '2024-05-15');

-- Inserts para TBDocente3139786
INSERT INTO TBDocente3139786 (IDDocente, NomeDocente, Sexo, DataNascimento, ValorHoraAula, CodFormacao, CodCidade, CodDepartamento) VALUES
(1, 'Ana Silva', 'F', '1980-05-10', 55.00, 201, 301, 401),
(2, 'Carlos Oliveira', 'M', '1975-08-22', 60.00, 202, 302, 402),
(3, 'Mariana Souza', 'F', '1982-11-03', 58.00, 203, 301, 401),
(4, 'Ricardo Pereira', 'M', '1978-02-15', 62.00, 204, 303, 403),
(5, 'Patrícia Santos', 'F', '1985-04-28', 56.00, 201, 302, 402),
(6, 'Fernando Lima', 'M', '1979-07-12', 61.00, 202, 301, 401),
(7, 'Camila Rodrigues', 'F', '1983-09-05', 57.00, 203, 303, 403),
(8, 'Gustavo Martins', 'M', '1976-12-18', 63.00, 204, 302, 402),
(9, 'Isabela Costa', 'F', '1986-03-01', 59.00, 201, 301, 401),
(10, 'Rafael Almeida', 'M', '1981-06-14', 60.50, 202, 303, 403),
(11, 'Juliana Barbosa', 'F', '1977-09-27', 57.50, 203, 302, 402),
(12, 'Lucas Castro', 'M', '1984-01-10', 62.50, 204, 301, 401),
(13, 'Beatriz Ribeiro', 'F', '1987-05-23', 58.50, 201, 303, 403),
(14, 'Daniel Ferreira', 'M', '1980-08-06', 61.50, 202, 302, 402),
(15, 'Sofia Nunes', 'F', '1988-10-19', 59.50, 203, 301, 401);

-- Inserts para TBDocenteDisciplina
INSERT INTO TBDocenteDisciplina3139786 (CodDocente, CodDisciplina, DataAtribuicao) VALUES
(1, 1, '2024-02-01'),
(2, 2, '2024-02-01'),
(3, 3, '2024-02-05'),
(4, 4, '2024-02-05'),
(5, 5, '2024-02-08'),
(6, 6, '2024-04-01'),
(7, 7, '2024-04-01'),
(8, 8, '2024-04-05'),
(9, 9, '2024-04-05'),
(10, 10, '2024-04-08'),
(11, 11, '2024-06-01'),
(12, 12, '2024-06-01'),
(13, 13, '2024-06-05'),
(14, 14, '2024-06-05'),
(15, 15, '2024-06-08');

-- Inserts para TBProduto3139786
INSERT INTO TBProduto3139786 (IDProduto, NomeProduto, Quantidade, Preco, DataCompra, DataValidade, CodFornecedor) VALUES
(1, 'Arroz Agulhinha Tipo 1', 100, 5.50, '2025-03-20', '2026-03-20', 501),
(2, 'Feijão Carioca', 80, 7.20, '2025-03-22', '2026-03-22', 502),
(3, 'Óleo de Soja', 150, 4.80, '2025-03-25', '2026-06-25', 501),
(4, 'Macarrão Espaguete', 120, 3.00, '2025-03-28', '2026-03-28', 503),
(5, 'Açúcar Refinado', 90, 4.00, '2025-03-30', '2026-09-30', 502),
(6, 'Café Torrado e Moído', 70, 12.50, '2025-03-20', '2025-09-20', 504),
(7, 'Leite Integral (Caixa)', 200, 3.80, '2025-03-22', '2025-04-22', 501),
(8, 'Biscoito Água e Sal', 110, 2.50, '2025-03-25', '2025-08-25', 503),
(9, 'Farinha de Trigo', 85, 4.50, '2025-03-28', '2026-03-28', 502),
(10, 'Sal Refinado', 130, 2.00, '2025-03-30', '2027-03-30', 504),
(11, 'Molho de Tomate', 160, 2.80, '2025-03-20', '2026-03-20', 501),
(12, 'Cereal Matinal', 95, 8.00, '2025-03-22', '2025-07-22', 503),
(13, 'Margarina', 105, 6.00, '2025-03-25', '2025-05-25', 502),
(14, 'Suco de Laranja (Caixa)', 140, 4.20, '2025-03-28', '2025-06-28', 504),
(15, 'Queijo Mussarela (KG)', 60, 25.00, '2025-03-30', '2025-04-30', 501);

-- Inserts para TBPedido3139786
INSERT INTO TBPedido3139786 (IDPedido, DataPedido, DataEntrega, CodCliente, CodVendedor, Observacao) VALUES
(1, '2025-03-25', '2025-03-28', 601, 701, 'Pedido normal'),
(2, '2025-03-26', '2025-03-29', 602, 702, 'Entrega urgente'),
(3, '2025-03-26', '2025-03-30', 603, 701, 'Cliente novo'),
(4, '2025-03-27', '2025-04-01', 604, 703, 'Pedido grande'),
(5, '2025-03-28', '2025-04-02', 605, 702, 'Pagamento à vista'),
(6, '2025-03-29', '2025-04-03', 601, 701, 'Recompra'),
(7, '2025-03-30', '2025-04-04', 606, 703, 'Solicitou desconto'),
(8, '2025-03-31', '2025-04-05', 602, 702, 'Pedido para evento'),
(9, '2025-04-01', '2025-04-08', 607, 701, 'Observações adicionais'),
(10, '2025-04-02', '2025-04-09', 603, 703, ''),
(11, '2025-04-03', '2025-04-10', 604, 702, 'Entregar no período da manhã'),
(12, '2025-04-04', '2025-04-11', 605, 701, 'Cliente preferencial'),
(13, '2025-04-05', '2025-04-12', 606, 703, 'Verificar estoque'),
(14, '2025-04-06', '2025-04-13', 607, 702, 'Embalagem reforçada'),
(15, '2025-04-07', '2025-04-14', 601, 701, 'Último pedido do mês');

-- Inserts para TBPedidoProduto3139786
INSERT INTO TBPedidoProduto3139786 (CodPedido, CodProduto, Quantidade, PrecoVenda) VALUES
(1, 1, 2, 6.00),
(1, 3, 1, 5.00),
(2, 2, 3, 8.00),
(2, 4, 2, 3.50),
(3, 5, 1, 4.50),
(3, 7, 4, 4.00),
(4, 6, 2, 13.00),
(4, 8, 3, 3.00),
(5, 9, 1, 5.00),
(5, 10, 2, 2.50),
(6, 11, 3, 3.00),
(6, 12, 1, 8.50),
(7, 13, 2, 6.50),
(7, 14, 2, 4.50),
(8, 15, 1, 26.00);

--Exercicio 3
/*
Fazer uma consulta que mostra (retorna):
Código disciplina, nome da disciplina, carga horária da disciplina.
Calcular: a Quantidade de professores na disciplina (uma disciplina pode ter mais deu professor)
*/
select
	d.IDDisciplina					[Código da Disciplina],
	d.NomeDisciplina				[Nome da Disciplina],
	d.CargaHorario					[Carga Horária],
	count(dd.CodDocente)			[Quantidade de Professores]
from
	TBDisciplina3139786 as d
join
	TBDocenteDisciplina3139786 as dd
	on (d.IDDisciplina = dd.CodDisciplina)
group by d.IDDisciplina, d.NomeDisciplina, d.CargaHorario

--Exercício 4
/*
Fazer uma view para o exercício 3)
Mostrar a execução da visão
*/

create view vDisciplinaEQuantidadeProfessores as
	select
		d.IDDisciplina					[Código da Disciplina],
		d.NomeDisciplina				[Nome da Disciplina],
		d.CargaHorario					[Carga Horária],
		count(dd.CodDocente)			[Quantidade de Professores]
	from
		TBDisciplina3139786 as d
	join
		TBDocenteDisciplina3139786 as dd
		on (d.IDDisciplina = dd.CodDisciplina)
	group by d.IDDisciplina, d.NomeDisciplina, d.CargaHorario
;

select * from vDisciplinaEQuantidadeProfessores

--Exercício 5
/*
Fazer uma consulta que mostra (retorna):
Código docente, nome do docente, sexo, código formação e valor da hora aula;
Calcular o campo: quantidade de disciplinas do docente (um docente pude ter mais de uma disciplina).

Responder à pergunta: Quantos docentes tem duas (2) ou mais disciplinas atribuídas.
*/

select 
	do.IDDocente						[Código do Docente],
	do.NomeDocente						[Nome do Docente],
	do.Sexo								[Sexo],
	do.CodFormacao						[Código da Formação],
	do.ValorHoraAula					[Valor da Hora Aula],
	count(dd.CodDisciplina)				[Quantidade de Disciplinas]
from
	TBDocente3139786 as do
join
	TBDocenteDisciplina3139786 as dd
	on (do.IDDocente = dd.CodDocente)
group by do.IDDocente, do.NomeDocente, do.Sexo, do.CodFormacao, do.ValorHoraAula


--Responder à pergunta: Quantos docentes tem duas (2) ou mais disciplinas atribuídas.
declare @QtdProfessoresComMaisDeUmaDisciplina INT;

select @QtdProfessoresComMaisDeUmaDisciplina = COUNT(*)
from (
    select CodDocente, COUNT(CodDisciplina) AS NumeroDeDisciplinas
    from TBDocenteDisciplina3139786
    group by CodDocente
) as ContagemDisciplinasPorProfessor
where NumeroDeDisciplinas >= 2;

print 'Quantidade de docentes que tem duas ou mais disciplinas atribuídas: ' + CAST(@QtdProfessoresComMaisDeUmaDisciplina AS VARCHAR(10));


--Exercicio 6
/*
Fazer uma visão para o exercício 5)
Mostrar a execução da visão
*/
create view vDocenteEQuantidadeDisciplinas as
select 
	do.IDDocente						[Código do Docente],
	do.NomeDocente						[Nome do Docente],
	do.Sexo								[Sexo],
	do.CodFormacao						[Código da Formação],
	do.ValorHoraAula					[Valor da Hora Aula],
	count(dd.CodDisciplina)				[Quantidade de Disciplinas]
from
	TBDocente3139786 as do
join
	TBDocenteDisciplina3139786 as dd
	on (do.IDDocente = dd.CodDocente)
group by do.IDDocente, do.NomeDocente, do.Sexo, do.CodFormacao, do.ValorHoraAula;
;

select * from vDocenteEQuantidadeDisciplinas

--Exercicio 7
/*
Fazer uma consulta que mostra (retorna):
Mostrar todas as disciplinas sem professor associado (disciplinas sem atribuição)
Nota: para testar seu código SQL cadastre ao menos duas (2) disciplinas e não fazer a atribuiçãodedocentes a elas.
*/

INSERT INTO TBDisciplina3139786 (IDDisciplina, NomeDisciplina, CargaHorario, BimestreOfertado, CodCurso, DataCriacao) VALUES
(16, 'História Geral', 60, 1, 105, '2025-04-02'),
(17, 'Geografia Humana', 45, 2, 105, '2025-04-02');

select
	*
from
	TBDisciplina3139786 as di
where not exists (
	select
		1
	from TBDocenteDisciplina3139786 as dd
	where dd.CodDisciplina = di.IDDisciplina
)


--Exercicio 8
/*
Fazer uma consulta que mostra (retorna):
Mostrar todos os professor sem disciplinas (professor sem atribuição)

Nota: para testar seu código SQL cadastre ao menos dois (2) professores e não fazer a atribuiçãodedisciplinas a eles.
*/

INSERT INTO TBDocente3139786 (IDDocente, NomeDocente, Sexo, DataNascimento, ValorHoraAula, CodFormacao, CodCidade, CodDepartamento) VALUES
(16, 'Fernanda Mendes', 'F', '1989-11-20', 57.00, 205, 304, 401),
(17, 'Rodrigo Alves', 'M', '1974-06-15', 65.00, 206, 305, 402);

select
	*
from
	TBDocente3139786 as do
where not exists (
	select
		1
	from TBDocenteDisciplina3139786 as dd
	where dd.CodDocente = do.IDDocente
)

--Exercício 9
/*
Fazer uma consulta que mostra (retorna):
Todos campos do pedido;
Calcular “Tempo atraso em Dias” da entrega dos pedidos;
Calcular “Total do Pedido” .
*/
select
	pe.IDPedido,
	pe.DataPedido,
	pe.DataEntrega,
	pe.CodCliente,
	pe.CodVendedor,
	pe.Observacao,
	DATEDIFF(DD, pe.DataPedido, pe.DataEntrega)			[Tempo Atraso em Dias],
	SUM(pp.PrecoVenda * pp.PrecoVenda)			[Total do Pedido]
from
	TBPedido3139786 as pe
join
	TBPedidoProduto3139786 as pp
	on (pe.IDPedido = pp.CodPedido)
group by pe.IDPedido, pe.DataPedido, pe.DataEntrega, pe.CodCliente, pe.CodVendedor, pe.Observacao


--Exercicio 10
/*
Fazer a visão para o exercício 9)
*/
create view vPedidoTotalEAtraso as
	select
		pe.IDPedido,
		pe.DataPedido,
		pe.DataEntrega,
		pe.CodCliente,
		pe.CodVendedor,
		pe.Observacao,
		DATEDIFF(DD, pe.DataPedido, pe.DataEntrega)			[Tempo Atraso em Dias],
		SUM(pp.PrecoVenda * pp.PrecoVenda)			[Total do Pedido]
	from
		TBPedido3139786 as pe
	join
		TBPedidoProduto3139786 as pp
		on (pe.IDPedido = pp.CodPedido)
	group by pe.IDPedido, pe.DataPedido, pe.DataEntrega, pe.CodCliente, pe.CodVendedor, pe.Observacao
;
select * from vPedidoTotalEAtraso


--Exercício 11
/*
Fazer uma stored procedure (sp) que:
Recebe o código de um Pedido e retorne:
ID pedido, data pedido, data entrega, quantidade de dias de atraso (calcular), valor do Pedido (calcular).
Mostrar a execução da (sp) para dois (2) pedidos.
*/

create procedure spPedidoTotalEAtraso
	@CodPedido int
as
begin
	select
		pe.IDPedido,
		pe.DataPedido,
		pe.DataEntrega,
		DATEDIFF(DD, pe.DataPedido, pe.DataEntrega)			[Tempo Atraso em Dias],
		SUM(pp.PrecoVenda * pp.PrecoVenda)			[Total do Pedido]
	from
		TBPedido3139786 as pe
	join
		TBPedidoProduto3139786 as pp
		on (pe.IDPedido = pp.CodPedido) AND (PE.IDPedido = @CodPedido)
	group by pe.IDPedido, pe.DataPedido, pe.DataEntrega, pe.CodCliente, pe.CodVendedor, pe.Observacao
end;

exec spPedidoTotalEAtraso 1
exec spPedidoTotalEAtraso 8


--Exercicio 12
/*
Recebe o código de um produto e retorne:
ID Produto, nome produto, preço produto, e calcular total venda do produto.
Mostrar a execução função (fx) para dois (2) produtos.
*/
create function fProdutoETotal (
    @CodPedido int
)
returns table
as
return
    select
		pr.IDProduto						[Código Produto],
		pr.NomeProduto						[Nome do Produto],
		pr.Preco							[Preço do Produto],
		sum(pp.PrecoVenda * pp.Quantidade)	[Total Venda]
	from
		TBProduto3139786 as pr
	join
		TBPedidoProduto3139786 as pp
		on (pr.IDProduto = pp.CodProduto) and (pr.IDProduto = @CodPedido)
	group by pr.IDProduto, pr.NomeProduto, pr.Preco

select * from fProdutoETotal(1)
select * from fProdutoETotal(8)


--Exercício 13
/*
Mostra os produtos que:
Condição: listar apenas os produtos que não estão nos pedidos.

Nota: para testar a consulta, cadastrar dois (2) produtos e não relacionar estes produtos nos pedidos.
*/

INSERT INTO TBProduto3139786 (IDProduto, NomeProduto, Quantidade, Preco, DataCompra, DataValidade, CodFornecedor) VALUES
(16, 'Detergente Líquido', 50, 6.80, '2025-04-02', '2026-04-02', 505),
(17, 'Papel Higiênico (Pacote)', 80, 18.50, '2025-04-02', '2026-04-02', 506);

select
	*
from
	TBProduto3139786 as pr
where not exists (
	select 
		1
	from
		TBPedidoProduto3139786 as pp
	where (pr.IDProduto = pp.CodProduto)
)