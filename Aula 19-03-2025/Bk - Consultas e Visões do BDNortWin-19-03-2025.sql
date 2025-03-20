/*
IFSP-BRT
-------------------------
Banco de Dados 
----------------------
Trabalho escolar:
Entregar o Código SQL no Moodle-IFSP-BRT 
---------------------------------------------
Consultas complexas (extrair dados de várias tabelas) e
visões (view = exibição)
-----------------------------------
Data: 19/03/2025 )Março-2025)
-----------------------
BDNortWindIFSP (BD Pedido)
Tem, que restaurar o BK do BDNortWindIFSP

*/
-----------------------------
/*
Exercicio 1). Mostre os dados da transportadora (ID e nome),
contar quantos pedidos cada transportadora entregou, e qual o
valor total dpo Frete pago nos transportes. Também a média 
destes fretes por pedido.
*/
--------------------------------
-- abrir o BD trabalho
USE BDNortWindIFSP
------------------------------
-- resolução

SELECT
	t.IDTransportadora					[Código da tranportadora],
	t.NomeDaEmpresa						[Nome],
	COUNT(p.IDPedido)					[Quantidade de pedidos],
	SUM(p.frete)						[Valor total dos fretes],
	(SUM(p.Frete) / COUNT(p.IDPedido))	[Media fretes por pedido]
FROM
	TBTransportadora as t
JOIN
	TBPedido as p
	ON (T.IDTransportadora = P.CodigoTransportadora)
GROUP BY t.IDTransportadora, t.NomeDaEmpresa
ORDER BY 1
---------------------------------------------------------
-- criando uma visão (view = exibição) para Ex.1
CREATE VIEW vFretesEMediaPorTransportadora
AS
	SELECT
		t.IDTransportadora					[Código da tranportadora],
		t.NomeDaEmpresa						[Nome],
		COUNT(p.IDPedido)					[Quantidade de pedidos],
		SUM(p.frete)						[Valor total dos fretes],
		(SUM(p.Frete) / COUNT(p.IDPedido))	[Media fretes por pedido]
	FROM
		TBTransportadora as t
	JOIN
		TBPedido as p
		ON (T.IDTransportadora = P.CodigoTransportadora)
	GROUP BY t.IDTransportadora, t.NomeDaEmpresa

--------------------------------------------------------- 
-- executar a visão

SELECT * FROM vFretesEMediaPorTransportadora ORDER BY 1

---------------------------------------------------

/*
Exercício 2) Fazer uma consulta que mostra o Faturamento dos 
Pedidos. Mostrar quantos Produtos tem no Pedido.
Mostrar: codigo do Cliente e código do Vendedor.
Do Pedido mostrar: ID, data pedido data entrega
*/
-- resolução 
SELECT
	SUM(dp.Quantidade * dp.PrecoUnitario)				[Faturamento Pedido],
	SUM(dp.Quantidade)									[Quantidade Produtos no Pedido],
	p.CodigoCliente										[Código do Cliente],
	p.CodigoFuncionario									[Código do Vendedor],
	p.IDPedido											[Código do Pedido],
	p.DataPedido										[Data Pedido],
	p.DataEntrega										[Data Entrega]
FROM
	TBDetalhesPedido as dp
JOIN
	TBPedido as p
	ON (dp.CodPedido = p.IDPedido)

GROUP BY P.IDPedido, p.CodigoCliente, p.CodigoFuncionario, p.DataPedido, p.DataEntrega
ORDER BY 5

--------------------------------------------------------
-- creando uma view (exibição)

CREATE VIEW vFaturamentoPedidoEQtdProdutos
AS
	SELECT
		SUM(dp.Quantidade * dp.PrecoUnitario)				[Faturamento Pedido],
		SUM(dp.Quantidade)									[Quantidade Produtos no Pedido],
		p.CodigoCliente										[Código do Cliente],
		p.CodigoFuncionario									[Código do Vendedor],
		p.IDPedido											[Código do Pedido],
		p.DataPedido										[Data Pedido],
		p.DataEntrega										[Data Entrega]
	FROM
		TBDetalhesPedido as dp
	JOIN
		TBPedido as p
		ON (dp.CodPedido = p.IDPedido)

	GROUP BY P.IDPedido, p.CodigoCliente, p.CodigoFuncionario, p.DataPedido, p.DataEntrega
;
-----------------------------------------------------------------
-- executar a visão

select * from vFaturamentoPedidoEQtdProdutos ORDER BY 5


---------------------------------------------
/*
Exercício 3) Fazer uma consulta que mostra os Clientes com dados
de seus Pedidos. Mostrar do Cliente: Código e Nome.
Calcular do cliente: Quantidade de Pedido, Faturamento Total e 
Média dos Pedidos.
*/

--------------------------------------------------------------
-- resolução 

SELECT
	c.IDCliente												[Código do Cliente],
	c.NomeEmpresa											[Nome do Cliente],
	COUNT(p.IDPedido)										[Quantidade de Pedidos],
	SUM(dp.Quantidade * dp.PrecoUnitario)					[Faturamento total],
	SUM(dp.Quantidade * dp.PrecoUnitario) / COUNT(p.IDPedido) [Média dos pedidos]
FROM
	TBCliente as c
JOIN
	TBPedido as p
	ON (c.IDCliente = p.CodigoCliente)
JOIN
	TBDetalhesPedido as dp
	ON (p.IDPedido = dp.CodPedido)
GROUP BY c.IDCliente, c.NomeEmpresa
ORDER BY 1

	
------------------------------------------
-- criar a visão

CREATE VIEW vPedidosPorCliente
AS
	SELECT
		c.IDCliente												[Código do Cliente],
		c.NomeEmpresa											[Nome do Cliente],
		COUNT(p.IDPedido)										[Quantidade de Pedidos],
		SUM(dp.Quantidade * dp.PrecoUnitario)					[Faturamento total],
		SUM(dp.Quantidade * dp.PrecoUnitario) / COUNT(p.IDPedido) [Média dos pedidos]
	FROM
		TBCliente as c
	JOIN
		TBPedido as p
		ON (c.IDCliente = p.CodigoCliente)
	JOIN
		TBDetalhesPedido as dp
		ON (p.IDPedido = dp.CodPedido)
	GROUP BY c.IDCliente, c.NomeEmpresa
;

---------------------------------------------------------
--Executar visão

SELECT * FROM vPedidosPorCliente ORDER BY 1

----------------------------------------------
/*
Exercício 4) Fazer uma consulta que mostra os Funcionarios com 
dados de seus Pedidos. Mostrar do Funcionario: Código e Nome.
Calcular do Funcionário: Quantidade de Pedido, Faturamento 
Total e Média dos Pedidos.
*/
-- resolução 

SELECT
	f.IDFuncionario											[Código do Funcionario],
	f.Nome													[Nome do Funcionario],
	COUNT(p.IDPedido)										[Quantidade de Pedidos],
	SUM(dp.Quantidade * dp.PrecoUnitario)					[Faturamento total],
	SUM(dp.Quantidade * dp.PrecoUnitario) / COUNT(p.IDPedido) [Média dos pedidos]
FROM
	TBFuncionario as f
JOIN
	TBPedido as p
	ON (f.IDFuncionario = p.CodigoFuncionario)
JOIN
	TBDetalhesPedido as dp
	ON (p.IDPedido = dp.CodPedido)
GROUP BY f.IDFuncionario, f.Nome
ORDER BY 1


----------------------------------------------------
/*
IFSP-BRT 

*/
----------------------------------------------------------------------------
/* Questão 5) Mostrar quais os clientes não fizeram Pedidos
De cliente mostrar: Id, Nome, Telefone, Nome Contato
*/

SELECT
	c.IDCliente												[ID Cliente],
	c.NomeEmpresa											[Nome Cliente],
	c.Telefone,
	c.NomeContato											[Nome Contato]
FROM
	TBCliente as c
LEFT JOIN
	TBPedido as p
	ON (c.IDCliente = p.CodigoCliente)
WHERE p.IDPedido is NULL
GROUP BY 	c.IDCliente, c.NomeEmpresa,	c.Telefone, c.NomeContato
ORDER BY 1

-------------------------------------------------
/*
  Questão 6) Fazer uma visão (view) da questão 5)
  -- mostrar a execuação da visão 
  
*/

CREATE VIEW vClientesSemPedido
AS
	SELECT
		c.IDCliente												[ID Cliente],
		c.NomeEmpresa											[Nome Cliente],
		c.Telefone,
		c.NomeContato											[Nome Contato]
	FROM
		TBCliente as c
	LEFT JOIN
		TBPedido as p
		ON (c.IDCliente = p.CodigoCliente)
	WHERE p.IDPedido is NULL
	GROUP BY 	c.IDCliente, c.NomeEmpresa,	c.Telefone, c.NomeContato

----------------------------------------------
-- mostrar a execução da visão

SELECT * FROM vClientesSemPedido ORDER BY 1

--------------------------------------------
/*
   Questão 6.1)
   Fazer uma consulta e depois uma visão que mostra quais
   os produtos ainda não foram vendidos. Lembrar que uma venda
   se configura com produto vendido (Tabela Detalhes Produto)
   Do Produto mostrar: ID, nome, fornecedor, precounitario
   e estoque.
   Do Fornecedor mostrar: Nome e Telefone
*/

SELECT
	p.IDProduto													[Código do produto],
	p.NomeProduto												[Nome],
	p.CodigoFornecedor											[Código do Fornecedor],
	p.PrecoUnitario												[Preco Unitário],
	f.NomeEmpresa												[Nome Fornecedor],
	f.Telefone													[Telefone Fornecedor]
FROM
	TBFornecedor as f
JOIN
	TBProduto as p
	ON (f.IDFornecedor = p.CodigoFornecedor) 
LEFT JOIN
	TBDetalhesPedido as dp
	ON (p.IDProduto = dp.CODProduto)
WHERE dp.CODProduto is NULL
ORDER BY 1

------------------------------------  
/*
Questão 7) Fazer a view da questão 6
*/ 

CREATE VIEW vProdutosSemVenda
AS
	SELECT
		p.IDProduto													[Código do produto],
		p.NomeProduto												[Nome],
		p.CodigoFornecedor											[Código do Fornecedor],
		p.PrecoUnitario												[Preco Unitário],
		f.NomeEmpresa												[Nome Fornecedor],
		f.Telefone													[Telefone Fornecedor]
	FROM
		TBFornecedor as f
	JOIN
		TBProduto as p
		ON (f.IDFornecedor = p.CodigoFornecedor) 
	LEFT JOIN
		TBDetalhesPedido as dp
		ON (p.IDProduto = dp.CODProduto)
	WHERE dp.CODProduto is NULL
;

 ------------------------------------------
 -- Executar a visão
 
SELECT * FROM vProdutosSemVenda 

 ------------------------------------------
 
/*
Questão 8)
Mostrar quais os Produtos não foram vendidos
pelos funcionarios (neste caso funcionario 1 e 2).
Do Produto mostrar: ID, nome, preco, Estoque
 */ 
---------------------------------------------------

SELECT DISTINCT
	p.IDProduto													[Código do produto],
	p.NomeProduto												[Nome],
	p.PrecoUnitario												[Preco Unitário],
	P.UnidadesEstoque											[Unidades em Estoque]
FROM	
	TBProduto as p
JOIN
	TBDetalhesPedido as dp
	ON (p.IDProduto = dp.CODProduto)
JOIN
	TBPedido as ped
	ON (ped.IDPedido = dp.CodPedido  AND (ped.CodigoFuncionario != 1 AND ped.CodigoFuncionario != 2))
ORDER BY 1	


  
-------------------------------------------------------------
-- Questão 9) Criando a visão da questão 8)

CREATE VIEW vProdutoSemVendaPorVendedorEspecífico
AS
	SELECT DISTINCT
		p.IDProduto													[Código do produto],
		p.NomeProduto												[Nome],
		p.PrecoUnitario												[Preco Unitário],
		P.UnidadesEstoque											[Unidades em Estoque]
	FROM	
		TBProduto as p
	JOIN
		TBDetalhesPedido as dp
		ON (p.IDProduto = dp.CODProduto)
	JOIN
		TBPedido as ped
		ON (ped.IDPedido = dp.CodPedido  AND (ped.CodigoFuncionario != 1 AND ped.CodigoFuncionario != 2))

------------------------------------------------------------------
-- executar a visão

SELECT * FROM vProdutoSemVendaPorVendedorEspecífico ORDER BY 1

-------------------------------------------------------------
/* Questão 10)
Mostrar os Funionários que não venderam os 
Produtos 37 e 100
*/
-----------------------------------------------------------

SELECT DISTINCT
	f.IDFuncionario
FROM
	TBFuncionario as f
JOIN
	TBPedido as p
	ON (f.IDFuncionario =  p.CodigoFuncionario)
JOIN
	TBDetalhesPedido as dp
	ON (p.IDPedido = dp.CodPedido)
WHERE dp.CODProduto != 37 AND dp.CODProduto != 100
ORDER BY 1


-----------------------------------------
-- Questão 11) CRIANDO A VISÃO

CREATE VIEW vFuncionariosSem37e100
AS
	SELECT DISTINCT
		f.IDFuncionario
	FROM
		TBFuncionario as f
	JOIN
		TBPedido as p
		ON (f.IDFuncionario =  p.CodigoFuncionario)
	JOIN
		TBDetalhesPedido as dp
		ON (p.IDPedido = dp.CodPedido)
	WHERE dp.CODProduto != 37 AND dp.CODProduto != 100
;
----------------------------------------
--Executando a visão

SELECT * FROM vFuncionariosSem37e100 ORDER BY 1

----------------------------------------
/* Questão 12)
Mostrar os funcionários que venderam os produtos 
37 ou 100
*/


SELECT DISTINCT
	f.IDFuncionario
FROM
	TBFuncionario as f
JOIN
	TBPedido as p
	ON (f.IDFuncionario =  p.CodigoFuncionario)
JOIN
	TBDetalhesPedido as dp
	ON (p.IDPedido = dp.CodPedido)
WHERE dp.CODProduto = 37 OR dp.CODProduto = 100
ORDER BY 1

---------------------------------------------------


