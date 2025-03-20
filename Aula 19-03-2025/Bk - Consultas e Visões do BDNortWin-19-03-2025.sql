/*
IFSP-BRT
-------------------------
Banco de Dados 
----------------------
Trabalho escolar:
Entregar o C�digo SQL no Moodle-IFSP-BRT 
---------------------------------------------
Consultas complexas (extrair dados de v�rias tabelas) e
vis�es (view = exibi��o)
-----------------------------------
Data: 19/03/2025 )Mar�o-2025)
-----------------------
BDNortWindIFSP (BD Pedido)
Tem, que restaurar o BK do BDNortWindIFSP

*/
-----------------------------
/*
Exercicio 1). Mostre os dados da transportadora (ID e nome),
contar quantos pedidos cada transportadora entregou, e qual o
valor total dpo Frete pago nos transportes. Tamb�m a m�dia 
destes fretes por pedido.
*/
--------------------------------
-- abrir o BD trabalho
USE BDNortWindIFSP
------------------------------
-- resolu��o

SELECT
	t.IDTransportadora					[C�digo da tranportadora],
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
-- criando uma vis�o (view = exibi��o) para Ex.1
CREATE VIEW vFretesEMediaPorTransportadora
AS
	SELECT
		t.IDTransportadora					[C�digo da tranportadora],
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
-- executar a vis�o

SELECT * FROM vFretesEMediaPorTransportadora ORDER BY 1

---------------------------------------------------

/*
Exerc�cio 2) Fazer uma consulta que mostra o Faturamento dos 
Pedidos. Mostrar quantos Produtos tem no Pedido.
Mostrar: codigo do Cliente e c�digo do Vendedor.
Do Pedido mostrar: ID, data pedido data entrega
*/
-- resolu��o 
SELECT
	SUM(dp.Quantidade * dp.PrecoUnitario)				[Faturamento Pedido],
	SUM(dp.Quantidade)									[Quantidade Produtos no Pedido],
	p.CodigoCliente										[C�digo do Cliente],
	p.CodigoFuncionario									[C�digo do Vendedor],
	p.IDPedido											[C�digo do Pedido],
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
-- creando uma view (exibi��o)

CREATE VIEW vFaturamentoPedidoEQtdProdutos
AS
	SELECT
		SUM(dp.Quantidade * dp.PrecoUnitario)				[Faturamento Pedido],
		SUM(dp.Quantidade)									[Quantidade Produtos no Pedido],
		p.CodigoCliente										[C�digo do Cliente],
		p.CodigoFuncionario									[C�digo do Vendedor],
		p.IDPedido											[C�digo do Pedido],
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
-- executar a vis�o

select * from vFaturamentoPedidoEQtdProdutos ORDER BY 5


---------------------------------------------
/*
Exerc�cio 3) Fazer uma consulta que mostra os Clientes com dados
de seus Pedidos. Mostrar do Cliente: C�digo e Nome.
Calcular do cliente: Quantidade de Pedido, Faturamento Total e 
M�dia dos Pedidos.
*/

--------------------------------------------------------------
-- resolu��o 

SELECT
	c.IDCliente												[C�digo do Cliente],
	c.NomeEmpresa											[Nome do Cliente],
	COUNT(p.IDPedido)										[Quantidade de Pedidos],
	SUM(dp.Quantidade * dp.PrecoUnitario)					[Faturamento total],
	SUM(dp.Quantidade * dp.PrecoUnitario) / COUNT(p.IDPedido) [M�dia dos pedidos]
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
-- criar a vis�o

CREATE VIEW vPedidosPorCliente
AS
	SELECT
		c.IDCliente												[C�digo do Cliente],
		c.NomeEmpresa											[Nome do Cliente],
		COUNT(p.IDPedido)										[Quantidade de Pedidos],
		SUM(dp.Quantidade * dp.PrecoUnitario)					[Faturamento total],
		SUM(dp.Quantidade * dp.PrecoUnitario) / COUNT(p.IDPedido) [M�dia dos pedidos]
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
--Executar vis�o

SELECT * FROM vPedidosPorCliente ORDER BY 1

----------------------------------------------
/*
Exerc�cio 4) Fazer uma consulta que mostra os Funcionarios com 
dados de seus Pedidos. Mostrar do Funcionario: C�digo e Nome.
Calcular do Funcion�rio: Quantidade de Pedido, Faturamento 
Total e M�dia dos Pedidos.
*/
-- resolu��o 

SELECT
	f.IDFuncionario											[C�digo do Funcionario],
	f.Nome													[Nome do Funcionario],
	COUNT(p.IDPedido)										[Quantidade de Pedidos],
	SUM(dp.Quantidade * dp.PrecoUnitario)					[Faturamento total],
	SUM(dp.Quantidade * dp.PrecoUnitario) / COUNT(p.IDPedido) [M�dia dos pedidos]
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
/* Quest�o 5) Mostrar quais os clientes n�o fizeram Pedidos
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
  Quest�o 6) Fazer uma vis�o (view) da quest�o 5)
  -- mostrar a execua��o da vis�o 
  
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
-- mostrar a execu��o da vis�o

SELECT * FROM vClientesSemPedido ORDER BY 1

--------------------------------------------
/*
   Quest�o 6.1)
   Fazer uma consulta e depois uma vis�o que mostra quais
   os produtos ainda n�o foram vendidos. Lembrar que uma venda
   se configura com produto vendido (Tabela Detalhes Produto)
   Do Produto mostrar: ID, nome, fornecedor, precounitario
   e estoque.
   Do Fornecedor mostrar: Nome e Telefone
*/

SELECT
	p.IDProduto													[C�digo do produto],
	p.NomeProduto												[Nome],
	p.CodigoFornecedor											[C�digo do Fornecedor],
	p.PrecoUnitario												[Preco Unit�rio],
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
Quest�o 7) Fazer a view da quest�o 6
*/ 

CREATE VIEW vProdutosSemVenda
AS
	SELECT
		p.IDProduto													[C�digo do produto],
		p.NomeProduto												[Nome],
		p.CodigoFornecedor											[C�digo do Fornecedor],
		p.PrecoUnitario												[Preco Unit�rio],
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
 -- Executar a vis�o
 
SELECT * FROM vProdutosSemVenda 

 ------------------------------------------
 
/*
Quest�o 8)
Mostrar quais os Produtos n�o foram vendidos
pelos funcionarios (neste caso funcionario 1 e 2).
Do Produto mostrar: ID, nome, preco, Estoque
 */ 
---------------------------------------------------

SELECT DISTINCT
	p.IDProduto													[C�digo do produto],
	p.NomeProduto												[Nome],
	p.PrecoUnitario												[Preco Unit�rio],
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
-- Quest�o 9) Criando a vis�o da quest�o 8)

CREATE VIEW vProdutoSemVendaPorVendedorEspec�fico
AS
	SELECT DISTINCT
		p.IDProduto													[C�digo do produto],
		p.NomeProduto												[Nome],
		p.PrecoUnitario												[Preco Unit�rio],
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
-- executar a vis�o

SELECT * FROM vProdutoSemVendaPorVendedorEspec�fico ORDER BY 1

-------------------------------------------------------------
/* Quest�o 10)
Mostrar os Funion�rios que n�o venderam os 
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
-- Quest�o 11) CRIANDO A VIS�O

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
--Executando a vis�o

SELECT * FROM vFuncionariosSem37e100 ORDER BY 1

----------------------------------------
/* Quest�o 12)
Mostrar os funcion�rios que venderam os produtos 
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


