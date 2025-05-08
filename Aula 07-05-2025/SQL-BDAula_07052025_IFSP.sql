--IFSP-BRT
--BRTBAN2 - Prof. Xyko
--Data 07-05-2025
--Projeto do BDAula_07052025

--1) Fazer o cadastro de 10 registros por tabela

--selecionando o banco de dados
use BDAula_07052025_IFSP

--inserindo os dados na tabela TBStatus
insert into TBStatus (IDEstatus, Descricao) values
(14, 'Logística'),
(15, 'Marketing Digital'),
(16, 'Recursos Humanos'),
(17, 'Financeiro'),
(18, 'Desenvolvimento'),
(19, 'Qualidade'),
(20, 'Suporte Técnico N1'),
(21, 'Suporte Técnico N2'),
(22, 'Vendas Externas'),
(23, 'Vendas Internas');

--inserindo os dados na Tabela TBProdutos
insert into TBprodutos values
(3001, 'Smartphone Modelo X', 50, 1200.00),
(3002, 'Tablet Modelo Y', 30, 850.00),
(3003, 'Smartwatch Modelo Z', 75, 450.50),
(3004, 'Fone Bluetooth Pro', 150, 199.90),
(3005, 'Carregador Rápido USB-C', 200, 89.00),
(3006, 'Capa Protetora Smartphone X', 100, 45.00),
(3007, 'Película de Vidro Tablet Y', 90, 30.00),
(3008, 'Hub USB 7 Portas', 60, 120.75),
(3009, 'Mochila Notebook Executiva', 40, 250.00),
(3010, 'HD Externo 2TB', 25, 380.00);

--inserindo os dados na tabela TBPessoas
insert into TBPessoas values
(9101, 'Laura Mendes Silva', '101.102.103-04', 1),
(9102, 'Pedro Alves Costa', '201.202.203-05', 1),
(9103, 'Mariana Ferreira Lima', '301.302.303-06', 1),
(9104, 'Lucas Barbosa Santos', '401.402.403-07', 3),
(9105, 'Sofia Oliveira Rocha', '501.502.503-08', 3),
(9106, 'Gabriel Pereira Almeida', '601.602.603-09', 3),
(9107, 'Beatriz Ribeiro Martins', '701.702.703-10', 2),
(9108, 'Thiago Cardoso Gomes', '801.802.803-11', 2),
(9109, 'Clara Azevedo Souza', '901.902.903-12', 14), 
(9110, 'Rafael Nunes Castro', '011.012.013-13', 15);

--inserindo os dados na tabela TBClientes
insert into TBclientes values
(9101, 5500.00, 2800.00),
(9102, 7800.50, 4000.00),
(9103, 12000.00, 7500.00),
(9104, 4000.00, 2000.00),
(9105, 6250.75, 3100.00),
(9106, 9100.00, 5000.00),
(9107, 3500.00, 1500.00),
(9108, 15000.00, 8000.00),
(9109, 8800.20, 4500.00),
(9110, 7100.00, 3800.00);

--inserindo os dados na tabela TBEstagiarios
insert into TBestagiarios values
(9101, 1350.00),
(9102, 1450.70),
(9103, 1200.00),
(9104, 1250.00),
(9105, 1300.50),
(9106, 1100.00),
(9107, 1150.00),
(9108, 1500.00),
(9109, 1400.25),
(9110, 1375.00);

select * from TBfuncionarios
--inserindo dados na tabela TBFuncionarios
INSERT INTO TBFuncionarios (FunCodigo, FunSalario, SupCodigo) VALUES
(9104, 7500.00, NULL),
(9105, 5200.00, 9104),
(9106, 4800.00, 9104),
(9109, 3500.00, 9105),
(9107, 3300.00, 9105),
(9108, 6000.00, NULL),
(9101, 4100.00, 9108),
(9102, 3900.00, 9108),
(9103, 2800.00, 9106),
(9110, 2750.00, 9106);

--inserindo os dados na tabela TBPedidos
insert into TBpedidos values
(201, '2024-01-10', 350.70, 1, 9101, 9105),
(202, '2024-01-12', 125.00, 3, 9102, 9106),
(203, '2024-01-15', 875.90, 4, 9103, 9105),
(204, '2024-01-18', 99.50, 2, 9110, 9106),
(205, '2024-01-20', 240.00, 4, 9102, 9107),
(206, '2024-01-22', 560.25, 3, 9103, 9106),
(207, '2024-01-25', 180.00, 2, 9104, 9106),
(208, '2024-01-28', 75.80, 1, 9105, 9107),
(209, '2024-01-30', 1200.00, 2, 9106, 9109),
(210, '2024-02-01', 450.60, 4, 9107, 9110);


--inserindo os dados na tabela TBProdutosVendidos
insert into TBProdutosVedidos values
(201, 3001, 1, 1200.00),
(201, 3005, 2, 89.00),
(202, 3002, 1, 850.00),
(203, 3003, 1, 450.50),
(203, 3004, 1, 199.90),
(204, 3008, 1, 120.75),
(205, 3006, 2, 45.00),
(206, 3010, 1, 380.00),
(207, 3007, 3, 30.00),
(208, 3009, 1, 250.00);

/*
2)Fazer uma consulta e visão (View); mostrar e execução da visão.
Consultar os pedidos mostrando:
Número,data e o nome do funcionário, cliente e estagiário.
Calcular o Total Pedido. Contar quantos itens (produtos) tem cada pedido.
*/

select
	p.PedidoID						[Número do pedido],
	p.data							[Data],
	s.PesNome						[Nome do Funcionário],
	(select 
		s.PesNome
	 from
		TBclientes as c
	 join
		TBPessoas as s
	 on (c.CliCodigo = s.PesCodigo)
	 where (c.CliCodigo = p.ClienteID)
	)								[Nome do Cliente],
	(select 
		s.PesNome
	 from
		TBestagiarios as e
	 join
		TBPessoas as s
	 on (e.EstCodigo = s.PesCodigo)
	 where (e.EstCodigo = p.FuncionarioID)
	)								[Nome do Estagiário],
	sum(pv.quantidade * preco)		[Total do Pedido],
	COUNT(pv.ProdutoID)				[Quantidade de Itens]
from
	TBProdutosVedidos as pv
join
	TBpedidos as p
	on (pv.PedidoID = p.PedidoID)
join
	TBfuncionarios as f
	on (f.FunCodigo = p.FuncionarioID)
join
	TBPessoas as s
	on (f.FunCodigo = s.PesCodigo)
group by p.PedidoID, p.data, s.PesNome, p.ClienteID, p.FuncionarioID

--criando a view
create view vPedidoValorTotalEQtdItens as
	select
		p.PedidoID						[Número do pedido],
		p.data							[Data],
		s.PesNome						[Nome do Funcionário],
		(select 
			s.PesNome
		 from
			TBclientes as c
		 join
			TBPessoas as s
		 on (c.CliCodigo = s.PesCodigo)
		 where (c.CliCodigo = p.ClienteID)
		)								[Nome do Cliente],
		(select 
			s.PesNome
		 from
			TBestagiarios as e
		 join
			TBPessoas as s
		 on (e.EstCodigo = s.PesCodigo)
		 where (e.EstCodigo = p.FuncionarioID)
		)								[Nome do Estagiário],
		sum(pv.quantidade * preco)		[Total do Pedido],
		COUNT(pv.ProdutoID)				[Quantidade de Itens]
	from
		TBProdutosVedidos as pv
	join
		TBpedidos as p
		on (pv.PedidoID = p.PedidoID)
	join
		TBfuncionarios as f
		on (f.FunCodigo = p.FuncionarioID)
	join
		TBPessoas as s
		on (f.FunCodigo = s.PesCodigo)
	group by p.PedidoID, p.data, s.PesNome, p.ClienteID, p.FuncionarioID

--executando a View:
select * from vPedidoValorTotalEQtdItens


--3) Fazer uma stored procedure (sp), que “usa transação”, que recebe como parâmetro ocódigodeum Pedido e retorna:
/*
Código e Nome do Cliente;
Todos os campos de TBPedidos;
Calcular o Total do Pedido;
Mostrar quantidade de produtos por Pedido;
*/

--criando a Procedure
create procedure sp1
(@codPedido int)
as begin
	begin transaction t1

	select
		s.PesCodigo						[Código do Cliente],
		s.PesNome						[Nome do Funcionário],
		p.PedidoID						[Número do pedido],
		p.data							[Data do pedido],
		p.valor							[Valor do pedido],
		p.status						[Status do pedido],
		p.ClienteID						[Código do Cliente (TBPedido)],
		p.FuncionarioID					[Código do Funcionário],
		sum(pv.quantidade * preco)		[Total do Pedido],
		COUNT(pv.ProdutoID)				[Quantidade de Itens]
	from
		TBProdutosVedidos as pv
	join
		TBpedidos as p
		on (pv.PedidoID = p.PedidoID)
	join
		TBclientes as c
		on (c.CliCodigo = p.FuncionarioID)
	join
		TBPessoas as s
		on (c.CliCodigo = s.PesCodigo)
	where (p.PedidoID = @codPedido) 
	group by s.PesCodigo, s.PesNome, p.PedidoID, p.data, p.valor, p.status, p.ClienteID, p.FuncionarioID
	if @@ERROR = 0
		begin
			commit transaction t1
		end
	else
		begin
			rollback transaction t1
		end
end

--executando a Procedure
exec sp1 1013;
exec sp1 1014;

--4) Fazer uma consulta e uma visão (view) que retorna:
/*
Código de Pedido e Total do Pedido
Condição de filtro: apenas para Pedidos com valor acima de R$ 500,00
E reponda as perguntas:
	 4.1) Quantos pedidos tem com valor acima de R$ 500,00. Mostre um código SQL que confirmesuaresposta;
	 4,2) Quantos pedidos tem com valor abaixo de R$ 500.00. Mostre um código SQLque confirmesuaresposta;
*/
select
	p.PedidoID						[Código do pedido],
	sum(pv.quantidade * pv.preco)		[Total do Pedido]
from
	TBProdutosVedidos as pv
join
	TBpedidos as p
	on (pv.PedidoID = p.PedidoID)
where
	(
	select
		sum(pv2.quantidade * pv2.preco)		[Total do Pedido]
	from
		TBProdutosVedidos as pv2
	join
		TBpedidos as p2
		on (pv2.PedidoID = p2.PedidoID)
	where (p.PedidoID = p2.PedidoID)
	) > 500.00
group by p.PedidoID


--criando a view
create view vPedidosTotalMaiores500
as
	select
		p.PedidoID						[Código do pedido],
		sum(pv.quantidade * pv.preco)		[Total do Pedido]
	from
		TBProdutosVedidos as pv
	join
		TBpedidos as p
		on (pv.PedidoID = p.PedidoID)
	where
		(
		select
			sum(pv2.quantidade * pv2.preco)		[Total do Pedido]
		from
			TBProdutosVedidos as pv2
		join
			TBpedidos as p2
			on (pv2.PedidoID = p2.PedidoID)
		where (p.PedidoID = p2.PedidoID)
		) > 500.00
	group by p.PedidoID

--executando a View
select * from vPedidosTotalMaiores500


--respondendo as perguntas
declare @maior int
set @maior = (select 
	count (p.PedidoID)
from
	TBpedidos as p
where
	(
	select
		sum(pv2.quantidade * pv2.preco)		[Total do Pedido]
	from
		TBProdutosVedidos as pv2
	join
		TBpedidos as p2
		on (pv2.PedidoID = p2.PedidoID)
	where (p.PedidoID = p2.PedidoID)
	) > 500.00)

print concat('Existem ', @maior, ' pedidos com valor acima de R$500.00!')


declare @menor int
set @menor = (select 
	count (p.PedidoID)
from
	TBpedidos as p
where
	(
	select
		sum(pv2.quantidade * pv2.preco)		[Total do Pedido]
	from
		TBProdutosVedidos as pv2
	join
		TBpedidos as p2
		on (pv2.PedidoID = p2.PedidoID)
	where (p.PedidoID = p2.PedidoID)
	) < 500.00)

print concat('Existem ', @menor, ' pedidos com valor acima de R$500.00!')

/*
5) Agora suponha que acha necessidade de customizar a consulta do exercício 4)
para ficar maisfácilpara os usuários utilizarem. Supor que na consulta precisa
aparecer apenas umcerto pedido por vez e fica a cargo de quem executar o sql a
escolha do número do pedido. Precisa resolver o problema fazendo uso de passagem
de parâmetro ao exercício 4) e fazendo algum ajuste de filtragem de dados.

Responda as questões:
 5.1) O que você fará para resolver o exercício. Justifique sua resposta com argumentos;
	Uma procedure com uma segunda condição na cláusula WHERE que filtra a query por um parâmetro, no qual é
	passado o código do pedido. Essa segunda condição será unida a primeira por um AND.
*/
create procedure sp2
(@codPedido2 int)
as begin
	begin transaction t2
	select
		p.PedidoID						[Código do pedido],
		sum(pv.quantidade * pv.preco)		[Total do Pedido]
	from
		TBProdutosVedidos as pv
	join
		TBpedidos as p
		on (pv.PedidoID = p.PedidoID)
	where
		(
		select
			sum(pv2.quantidade * pv2.preco)		[Total do Pedido]
		from
			TBProdutosVedidos as pv2
		join
			TBpedidos as p2
			on (pv2.PedidoID = p2.PedidoID)
		where (p.PedidoID = p2.PedidoID)
		) > 500.00 and (p.PedidoID = @codPedido2)
	group by p.PedidoID
	if @@ERROR = 0
	begin
		commit transaction t2
	end
	else
	begin
		rollback transaction t2
	end
end

-- 5.2) Mostre que resolve o problema passando dois números de pedidos.
exec sp2 201;
exec sp2 1009;
select * from vPedidosTotalMaiores500