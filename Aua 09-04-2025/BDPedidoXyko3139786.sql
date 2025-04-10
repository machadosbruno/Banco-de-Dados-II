/*
IFSP - Brt
Disciplina: BRTBAN2
Data: Abril-2025
Projeto BDPedidoIFSP
Prof. Xyko Almeida
*/

--Exercicio 1
/*
Usar o “SQL Server 2014” e a “linguagem SQL” para fazer os exercícios propostos usando
o BDPedidoXyko.
O aluno precisa restaurar o “Backup do PDPedidoXyko” da área de trabalho
(cópia no Moodle-IFSP-Brt) para o seu computador (servidor) para a realização
dos exercícios propostos.
*/
--Restauração do Backup realizada

--selecionando para uso o BDPedidoXyko
use BDPedidoXyko

--Exercicio 2
/*
Fazer uma consulta (select)
Fazer uma consulta que mostra (retorna):
Todos os dados dos clientes que não fizeram pedido.
Nota: caso sua consulta não retorne dados, favor cadastrar e mostrar os cadastros (inserts)
de dois clientes para que possam ser mostrados na consulta (select).
*/
select
	*
from
	TBCliente as c
where
	not exists (
		select
			1
		from
			TBPedido as p
		where c.CliCodigo = p.CliCodigo
	)

--Teste de san tomé
select * from TBCliente
select * from TBPedido

select 
	c.CliCodigo,
	c.CliNome,
	p.PedCodigo
from
	TBCliente as c
join
	TBPedido as p
	on (c.CliCodigo = p.CliCodigo)


--Exercicio 3
/*Fazer uma consulta (select).
Fazer uma consulta que mostra (retorna):
Código compra, data compra, data Entrega da compra;
Código e Nome do Fornecedor da Compra;
Calcular o “Total da Compra” (de cada compra).
Calcular os “Dias de Atraso” (entre data compra e data da entrega;
Contar “quantos produtos” tem na compra.*/select	c.IDcompra									[Código compra],	c.CmpData									[Data da Compra],	c.ForDataEntrega							[Data entrega da Compra],	f.IDFornecedor								[Código do Fornecedor da Compra],	f.ForNome									[Nome do Fornecedor],	sum(ic.ICQtde * ic.ICValor)					[Total da Compra],	DATEDIFF(dd, c.CmpData, c.ForDataEntrega)	[Dias de atraso],	COUNT(ic.CmpCodigo)							[Quantidade de Produtos]from	TBFornecedor as fjoin	TBCompra as c	on (f.IDFornecedor = c.ForCodigo)join	TBItensCompra as ic	on (c.IDcompra = ic.CmpCodigo)group by c.IDcompra, c.CmpData, c.ForDataEntrega, f.IDFornecedor, f.ForNome--Teste de san toméselect * from TBItensCompraselect * from TBCompraselect * from TBProduto--Exercicio 4)
/*
Fazer uma visão (view).
Fazer uma view para o exercício 3)
Mostrar a execução da visão
*/
create view vCompraFornecedorAtraso
as
	select		c.IDcompra									[Código compra],		c.CmpData									[Data da Compra],		c.ForDataEntrega							[Data entrega da Compra],		f.IDFornecedor								[Código do Fornecedor da Compra],		f.ForNome									[Nome do Fornecedor],		sum(ic.ICQtde * ic.ICValor)					[Total da Compra],		DATEDIFF(dd, c.CmpData, c.ForDataEntrega)	[Dias de atraso],		COUNT(ic.CmpCodigo)							[Quantidade de Produtos]	from		TBFornecedor as f	join		TBCompra as c		on (f.IDFornecedor = c.ForCodigo)	join		TBItensCompra as ic		on (c.IDcompra = ic.CmpCodigo)	group by c.IDcompra, c.CmpData, c.ForDataEntrega, f.IDFornecedor, f.ForNomeselect * from vCompraFornecedorAtraso--Exercicio 5
/*
Fazer uma stored procedure - sp.
Recebe como parâmetro o “código de uma compra” e retorna:
Código compra, data compra, data Entrega da compra;
Código e Nome do Fornecedor da Compra;
Calcular o “Total da Compra” (de cada compra);
Calcular os “Dias de Atraso” (entre data compra e data da entrega)
Contar “quantos produtos” tem na compra.
Mostrar a execução da sp para duas (2) compras.
*/
create procedure spCompraFornecedorAtraso
	@CodCompra int
as
begin
	select		c.IDcompra									[Código compra],		c.CmpData									[Data da Compra],		c.ForDataEntrega							[Data entrega da Compra],		f.IDFornecedor								[Código do Fornecedor da Compra],		f.ForNome									[Nome do Fornecedor],		sum(ic.ICQtde * ic.ICValor)					[Total da Compra],		DATEDIFF(dd, c.CmpData, c.ForDataEntrega)	[Dias de atraso],		COUNT(ic.CmpCodigo)							[Quantidade de Produtos]	from		TBFornecedor as f	join		TBCompra as c		on (f.IDFornecedor = c.ForCodigo AND c.IDcompra = @CodCompra)	join		TBItensCompra as ic		on (c.IDcompra = ic.CmpCodigo)	group by c.IDcompra, c.CmpData, c.ForDataEntrega, f.IDFornecedor, f.ForNomeend

exec spCompraFornecedorAtraso 1
exec spCompraFornecedorAtraso 8

--Exercicio 6
/*
Fazer uma função (fx).
A partir da sp do exercício 5), fazer uma função (fx). que:
Recebe como parâmetro o “código de uma compra” e retorna os mesmos dados do exercício6)
*/
create function fCompraFornecedorAtraso (@CodCompra INT)
returns table
as
return
    select		c.IDcompra									[Código compra],		c.CmpData									[Data da Compra],		c.ForDataEntrega							[Data entrega da Compra],		f.IDFornecedor								[Código do Fornecedor da Compra],		f.ForNome									[Nome do Fornecedor],		sum(ic.ICQtde * ic.ICValor)					[Total da Compra],		DATEDIFF(dd, c.CmpData, c.ForDataEntrega)	[Dias de atraso],		COUNT(ic.CmpCodigo)							[Quantidade de Produtos]	from		TBFornecedor as f	join		TBCompra as c		on (f.IDFornecedor = c.ForCodigo AND c.IDcompra = @CodCompra)	join		TBItensCompra as ic		on (c.IDcompra = ic.CmpCodigo)	group by c.IDcompra, c.CmpData, c.ForDataEntrega, f.IDFornecedor, f.ForNome

-- Para usar a função:
select * from fCompraFornecedorAtraso(1)
select * from fCompraFornecedorAtraso(5)

--7
/*
Fazer uma consulta (select).
Fazer uma consulta que mostra (retorna):
Código e nome do Cliente. Calcular: “Quantidade de Pedidos” do Cliente;
Calcular: o “Total do Pedido” do Cliente;
Calcular a “Média dos Pedidos” do Cliente. Nota: “nome do Cliente” está na
Tabela TBCliente e “Total do Pedido” deve ser calculadodaTabelaTBItensPedido.
*/
select
	c.CliCodigo												[Código de Cliente],
	c.CliNome												[Nome do Cliente],
	COUNT(p.PedCodigo)										[Quantidade de Pedidos],
	SUM(i.IpeQtde * i.IpeValor)								[Total dos pedido],
	( SUM(i.IpeQtde * i.IpeValor) / COUNT(p.PedCodigo) )	[Média dos pedidos]
from
	TBCliente as c
join
	TBPedido as p
	on (c.CliCodigo = p.CliCodigo)
join
	TBItensPedido as i
	on (i.PedCodigo = p.PedCodigo)
group by c.CliCodigo, c.CliNome

--Exercício 8
/*
Fazer uma consulta (select).
Fazer uma consulta que mostra (retorna):
8.1) Todos os produtos que “não foram comprados”.
Nota: Todos os produtos comprados estão na tabela TBItensCompra.
*/
select
	*
from
	TBProduto as p
where not exists (
	select
		1
	from
		TBItensCompra as ic
	where (p.PrdCodigo = ic.PrdCodigo)
)

---------------------------------------------------
/*
8.2) Todos os produtos que “não foram vendidos”.
Nota: Todos os produtos vendidos estão na tabela TBItensPedido.
*/
select 
	*
from
	TBProduto as p
where not exists (
	select
		1
	from
		TBItensPedido as i
	where (p.PrdCodigo = i.PrdCodigo)
)

--Exercício 9
/*
Fazer uma consulta (select).
9.1) Retorna todos os dados do Produto.
Calcular: “Total de Compras” do Produto;
Contar em quantos “Pedidos de Compra” está o produto;
*/
select
	p.PrdCodigo							[Código de Produto],
	p.PrdDescricao						[Descrição do Produto],
	p.PrdValor							[Valor do Produto],					
	p.PrdQtde							[Valor de Quantidade],
	p.PrdStatus							[Status do Produto],
	p.PrdEstoqueMinimo					[Estoque Mínimo do Produto],
	p.Descontinuado						[Produto Descontinuado?],
	p.ForCodigo,
	SUM(ic.ICQtde * ic.ICValor)			[Total da Compras],
	COUNT(ic.CmpCodigo)					[Pedidos de Compra]
from
	TBProduto as p
join
	TBItensCompra as ic
	on (p.PrdCodigo = ic.PrdCodigo)
group by p.PrdCodigo, p.PrdDescricao, p.PrdValor, p.PrdQtde, p.PrdStatus, p.PrdEstoqueMinimo, p.Descontinuado, p.ForCodigo

---------------------------------------------------
/*
9.2) Retorna todos os dados do Produto
Calcular o “Total de Vendas” do Produto.
Contar em quantos Pedidos de Venda está o produto.
*/
select
	p.PrdCodigo							[Código de Produto],
	p.PrdDescricao						[Descrição do Produto],
	p.PrdValor							[Valor do Produto],					
	p.PrdQtde							[Valor de Quantidade],
	p.PrdStatus							[Status do Produto],
	p.PrdEstoqueMinimo					[Estoque Mínimo do Produto],
	p.Descontinuado						[Produto Descontinuado?],
	p.ForCodigo,
	SUM(i.IpeQtde * i.IpeValor)			[Total da Vendas],
	COUNT(i.PrdCodigo)					[Pedidos de Compra]
from
	TBProduto as p
join
	TBItensPedido as i
	on (p.PrdCodigo = i.PrdCodigo)
group by p.PrdCodigo, p.PrdDescricao, p.PrdValor, p.PrdQtde, p.PrdStatus, p.PrdEstoqueMinimo, p.Descontinuado, p.ForCodigo

---------------------------------------------------
/*
9.3) Fazer e mostrar a view (visão) dos itens 9.1) e 9.2)
*/
create view vPedidosTotalEQtdCompras
as
	select
		p.PrdCodigo							[Código de Produto],
		p.PrdDescricao						[Descrição do Produto],
		p.PrdValor							[Valor do Produto],					
		p.PrdQtde							[Valor de Quantidade],
		p.PrdStatus							[Status do Produto],
		p.PrdEstoqueMinimo					[Estoque Mínimo do Produto],
		p.Descontinuado						[Produto Descontinuado?],
		p.ForCodigo,
		SUM(ic.ICQtde * ic.ICValor)			[Total da Compras],
		COUNT(ic.CmpCodigo)					[Pedidos de Compra]
	from
		TBProduto as p
	join
		TBItensCompra as ic
		on (p.PrdCodigo = ic.PrdCodigo)
	group by p.PrdCodigo, p.PrdDescricao, p.PrdValor, p.PrdQtde, p.PrdStatus, p.PrdEstoqueMinimo, p.Descontinuado, p.ForCodigo

select * from vPedidosTotalEQtdCompras


create view vPedidosTotalEQtdVendas
as
	select
		p.PrdCodigo							[Código de Produto],
		p.PrdDescricao						[Descrição do Produto],
		p.PrdValor							[Valor do Produto],					
		p.PrdQtde							[Valor de Quantidade],
		p.PrdStatus							[Status do Produto],
		p.PrdEstoqueMinimo					[Estoque Mínimo do Produto],
		p.Descontinuado						[Produto Descontinuado?],
		p.ForCodigo,
		SUM(i.IpeQtde * i.IpeValor)			[Total da Vendas],
		COUNT(i.PrdCodigo)					[Pedidos de Compra]
	from
		TBProduto as p
	join
		TBItensPedido as i
		on (p.PrdCodigo = i.PrdCodigo)
	group by p.PrdCodigo, p.PrdDescricao, p.PrdValor, p.PrdQtde, p.PrdStatus, p.PrdEstoqueMinimo, p.Descontinuado, p.ForCodigo

select * from vPedidosTotalEQtdVendas


--Exercício 10
/*
Fazer uma visão (view).
Fazer uma consulta que mostra (retorna):
Código e nome do Vendedor.
Calcular: “Quantidade de Pedidos” do Vendedor;
Calcular: o “Total do Pedido” do Vendedor;
Calcular a “Média dos Pedidos” do Vendedor.
Nota: “nome do vendedor” está na Tabela TBVendedor e “Total do Pedido” deve
ser calculadodaTabelaTBItensPedido.
*/
select
	v.VedCodigo									[Código do vendedor],
	v.VedNome									[Nome do Vendedor],
	COUNT(p.PedCodigo)							[Quantidade de Pedidos],
	sum(i.IpeQtde * i.IpeValor)					[Total dos Pedidos],
	(sum(i.IpeQtde * i.IpeValor) / COUNT(p.PedCodigo))	[Média dos Pedidos]
from
	TBVendedor as v
join
	TBPedido as p
	on (v.VedCodigo = p.VedCodigo)
join
	TBItensPedido as i
	on (p.PedCodigo = i.PedCodigo)
group by v.VedCodigo, v.VedNome

