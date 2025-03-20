USE BDNortWindIFSP

--EX1
SELECT * FROM TBPedido WHERE CodigoTransportadora = 3

SELECT SUM(Frete) from TBPedido WHERE CodigoTransportadora = 3

-----------------------------------------------------------------

--EX2
SELECT * FROM TBDetalhesPedido WHERE CodPedido = 10895

--EX5
SELECT distinct CodigoCliente FROM TBPedido 

Select * from TBCliente

--EX6
SELECT DISTINCT CODProduto FROM TBDetalhesPedido ORDER BY 1

SELECT DISTINCT * FROM TBProduto ORDER BY 1

--EX7
SELECT
	*


--EX8
SELECT distinct * FROM TBPedido WHERE TBPedido.CodigoFuncionario = 1 ORDER BY 3

SELECT * FROM TBProduto

insert into TBProduto (IDProduto, NomeProduto) VALUES (78, 'PRODUTO TESTE'); 


--EX10
SELECT * FROM TBFuncionario

select * from TBPedido

select distinct p.IDPedido from TBDetalhesPedido as dp 
join
	TBPedido as p
	on (p.IDPedido = dp.CodPedido)
where dp.CODProduto != 100


select distinct p.CodigoFuncionario from TBDetalhesPedido as dp 
join
	TBPedido as p
	on (p.IDPedido = dp.CodPedido)
where dp.CODProduto = 100
order by 1