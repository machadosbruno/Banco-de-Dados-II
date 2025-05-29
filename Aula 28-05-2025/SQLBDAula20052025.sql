create database BDAula28052025_3139786

use BDAula28052025_3139786

create table TBEmployee3139786(
	employee_id					int not null primary key,
	last_name					varchar(40) not null,
	first_name					varchar(40) not null,
	birth_date					date,
	hire_date					date,
	address						varchar(128),
	city						varchar(30),
	country						varchar(30),
	reports_to					int,
	foreign key (reports_to) references TBEmployee3139786 (employee_id)
);

create table TBCustomer3139786(
	customer_id					int  not null primary key,
	contact_name				varchar(30) not null,
	company_name				varchar(40),
	contact_email				varchar(128) not null,
	address						varchar(120),
	city						varchar(30),
	country						varchar(30)
);

create table TBPurchase3139786(
	purchase_id					int	 not null	primary key,
	customer_id					int	 not null,
	employee_id					int	 not null,
	total_price					decimal(10,2) not null,
	purchase_date				datetime,
	shipped_date				datetime,
	ship_address				varchar(60),
	ship_city					varchar(15),
	ship_country				varchar(15),
	foreign key (customer_id) references TBCustomer3139786 (customer_id),
	foreign key (employee_id) references TBEmployee3139786 (employee_id),
);

create table TBCategory3139786(
	category_id					int	 not null	primary key,
	name						varchar(60)	not null,
	description					text,
	parent_category_id			int,
	foreign key (category_id) references TBCategory3139786 (category_id)
);

create table TBProduct3139786(
	product_id					int	not null	primary key,
	product_name				varchar(40) not null,
	category_id					int	not null,
	quantity_per_unit			int,
	unit_price					decimal(10,2),
	units_in_stock				int,
	discontinued				bit,
	foreign key (category_id) references TBCategory3139786 (category_id)
);

create table TBPurchaseItem3139786(
	purchase_id					int	 not null,
	product_id					int	 not null,
	unit_price					decimal(10,2),
	quantity					int,
	primary key(purchase_id, product_id),
	foreign key (purchase_id) references TBPurchase3139786 (purchase_id),
	foreign key (product_id) references TBProduct3139786 (product_id),
);

--Inserindo os dados
insert into TBEmployee3139786 (employee_id, last_name, first_name, birth_date, hire_date, address, city, country, reports_to) values
(1, 'Fonseca', 'Alberto', '1970-03-12', '2005-01-15', 'Rua Principal, 100', 'Lisboa', 'Portugal', null),
(2, 'Medeiros', 'Beatriz', '1985-07-22', '2010-06-01', 'Avenida da Liberdade, 200', 'Porto', 'Portugal', 1),
(3, 'Carvalho', 'Carlos', '1990-01-10', '2012-03-10', 'Praça do Comércio, 30', 'Lisboa', 'Portugal', 1),
(4, 'Esteves', 'Diana', '1988-11-05', '2011-09-20', 'Rua Augusta, 150', 'Faro', 'Portugal', 2),
(5, 'Gomes', 'Eduardo', '1992-06-15', '2014-02-05', 'Largo do Carmo, 45', 'Coimbra', 'Portugal', 2),
(6, 'Henriques', 'Fernanda', '1983-04-25', '2015-07-11', 'Rua Garrett, 500', 'Braga', 'Portugal', 3),
(7, 'Lopes', 'Guilherme', '1995-09-01', '2018-11-15', 'Avenida Brasil, 601', 'Aveiro', 'Portugal', 3),
(8, 'Martins', 'Helena', '1978-12-18', '2008-05-25', 'Campo Grande, 707', 'Lisboa', 'Portugal', 1),
(9, 'Nunes', 'Igor', '1993-02-28', '2017-03-30', 'Rua de Santa Catarina, 808', 'Porto', 'Portugal', 4),
(10, 'Oliveira', 'Joana', '1989-10-08', '2016-01-01', 'Avenida dos Aliados, 909', 'Porto', 'Portugal', 4),
(11, 'Pires', 'Leonardo', '1991-05-14', '2019-08-12', 'Rua da Prata, 121', 'Lisboa', 'Portugal', 5),
(12, 'Quintela', 'Mariana', '1986-08-27', '2013-05-20', 'Avenida Boavista, 222', 'Porto', 'Portugal', 5),
(13, 'Ramos', 'Nuno', '1994-01-03', '2020-02-01', 'Rua do Ouro, 323', 'Lisboa', 'Portugal', 6),
(14, 'Serra', 'Patricia', '1982-09-19', '2009-10-09', 'Praça da República, 424', 'Coimbra', 'Portugal', 6),
(15, 'Tavares', 'Ricardo', '1996-07-07', '2021-01-15', 'Alameda das Linhas de Torres, 525', 'Lisboa', 'Portugal', 7);

insert into TBCustomer3139786 (customer_id, contact_name, company_name, contact_email, address, city, country) values
(1, 'Ana Silva', 'Silva & Filhos Lda', 'ana.silva@silvafilhos.pt', 'Rua das Flores, 10', 'Lisboa', 'Portugal'),
(2, 'Bruno Costa', 'Costa Construções SA', 'bruno.costa@costacorp.pt', 'Avenida Central, 20', 'Porto', 'Portugal'),
(3, 'Carla Santos', 'Santos Comércio Geral', 'carla.s@santoscomercio.pt', 'Praça Nova, 30', 'Coimbra', 'Portugal'),
(4, 'David Pereira', 'Pereira Tech Solutions', 'david.p@pereiratech.com', 'Parque das Nações, Lote 40', 'Lisboa', 'Portugal'),
(5, 'Elena Ferreira', 'Ferreira Importações', 'elena.f@ferreiraimport.pt', 'Zona Industrial da Maia, Rua A', 'Maia', 'Portugal'),
(6, 'Fábio Gonçalves', 'Gonçalves Alimentar', 'fabio.g@goncalvesalimentar.pt', 'Mercado Municipal, Loja 60', 'Faro', 'Portugal'),
(7, 'Gabriela Rodrigues', 'Rodrigues Design', 'g.rodrigues@rodriguesdesign.pt', 'Rua Miguel Bombarda, 70', 'Porto', 'Portugal'),
(8, 'Hugo Almeida', 'Almeida Consultores', 'hugo.a@almeidaconsult.com', 'Edifício Office Park, Piso 8', 'Lisboa', 'Portugal'),
(9, 'Inês Marques', 'Marques Advocacia', 'ines.m@marquesadv.pt', 'Avenida da República, 90', 'Lisboa', 'Portugal'),
(10, 'João Azevedo', 'Azevedo Automóveis', 'joao.az@azevedoauto.pt', 'Estrada Nacional 1, Km 100', 'Leiria', 'Portugal'),
(11, 'Laura Moreira', 'Moreira Viagens', 'laura.m@moreiraviagens.pt', 'Aeroporto de Lisboa, Loja 11', 'Lisboa', 'Portugal'),
(12, 'Marco Vieira', 'Vieira Contabilidade', 'marco.v@vieiracont.pt', 'Rua Sá da Bandeira, 120', 'Porto', 'Portugal'),
(13, 'Sofia Pinto', 'Pinto Gráfica', 'sofia.p@pintografica.pt', 'Parque Industrial de Setúbal, Lote 13', 'Setúbal', 'Portugal'),
(14, 'Tiago Lopes', 'Lopes Restauração', 'tiago.l@lopesrest.pt', 'Docas de Alcântara, Armazém 14', 'Lisboa', 'Portugal'),
(15, 'Vera Nunes', 'Nunes Ourivesaria', 'vera.n@nunesjoias.pt', 'Rua Áurea, 150', 'Lisboa', 'Portugal');

insert into TBCategory3139786 (category_id, name, description, parent_category_id) values
(1, 'Eletrônicos', 'Dispositivos e acessórios eletrônicos de consumo.', null),
(2, 'Computadores e Acessórios', 'Notebooks, desktops, monitores, teclados, mouses.', 1),
(3, 'Smartphones e Tablets', 'Celulares inteligentes e tablets de várias marcas.', 1),
(4, 'Livros e Mídia', 'Livros impressos, e-books, filmes e música.', null),
(5, 'Literatura Estrangeira', 'Obras traduzidas de autores internacionais.', 4),
(6, 'Música Clássica', 'CDs e Vinis de música erudita.', 4),
(7, 'Moda e Vestuário', 'Roupas, calçados e acessórios de moda.', null),
(8, 'Roupas Masculinas', 'Camisas, calças, casacos para homens.', 7),
(9, 'Calçados Femininos', 'Sapatos, sandálias, botas para mulheres.', 7),
(10, 'Casa e Jardim', 'Artigos para decoração, cozinha e jardinagem.', null),
(11, 'Utensílios de Cozinha', 'Panelas, talheres, eletroportáteis para cozinha.', 10),
(12, 'Ferramentas', 'Ferramentas manuais e elétricas para casa e jardim.', 10),
(13, 'Esportes e Lazer', 'Equipamentos esportivos, jogos e artigos de lazer.', null),
(14, 'Equipamentos de Fitness', 'Artigos para ginástica e musculação em casa.', 13),
(15, 'Brinquedos Educativos', 'Jogos e brinquedos que auxiliam no aprendizado.', 13);

insert into TBProduct3139786 (product_id, product_name, category_id, quantity_per_unit, unit_price, units_in_stock, discontinued) values
(1, 'Notebook UltraSlim X15', 2, 1, 1200.00, 30, 0),
(2, 'Smartphone Galaxy Pro', 3, 1, 850.00, 75, 0),
(3, 'Teclado Mecânico Gamer RGB', 2, 1, 95.00, 150, 0),
(4, 'Box "As Crônicas de Nárnia"', 5, 7, 120.50, 50, 0),
(5, 'CD Beethoven - Sinfonias Completas', 6, 5, 80.00, 25, 1),
(6, 'Camisa Polo Azul Marinho G', 8, 1, 45.90, 200, 0),
(7, 'Sandália de Salto Alto Preta 37', 9, 1, 79.99, 80, 0),
(8, 'Conjunto de Panelas Antiaderente', 11, 1, 250.00, 40, 0),
(9, 'Furadeira de Impacto 500W', 12, 1, 180.75, 60, 0),
(10, 'Bicicleta Ergométrica Residencial', 14, 1, 650.00, 15, 0),
(11, 'Quebra-Cabeça Mapa Mundi 1000 Peças', 15, 1, 55.00, 100, 0),
(12, 'Monitor LED 27" Curvo', 2, 1, 450.00, 22, 0),
(13, 'Tablet Educacional Infantil', 3, 1, 199.90, 65, 0),
(14, 'Livro "Orgulho e Preconceito"', 5, 1, 29.90, 110, 0),
(15, 'Jaqueta de Couro Sintético P', 8, 1, 150.00, 35, 0);

insert into TBPurchase3139786 (purchase_id, customer_id, employee_id, total_price, purchase_date, shipped_date, ship_address, ship_city, ship_country) values
(1, 1, 2, 1200.00, '20230110 09:30:00.000', '20230111 14:00:00.000', 'Rua das Flores, 10', 'Lisboa', 'Portugal'),
(2, 2, 3, 850.00, '20230115 11:00:00.000', '20230116 16:30:00.000', 'Avenida Central, 20', 'Porto', 'Portugal'),
(3, 3, 4, 95.00, '20230201 15:00:00.000', '20230202 10:00:00.000', 'Praça Nova, 30', 'Coimbra', 'Portugal'),
(4, 4, 5, 120.50, '20230210 10:15:00.000', '20230212 09:00:00.000', 'Parque das Nações, Lote 40', 'Lisboa', 'Portugal'),
(5, 5, 6, 80.00, '20230305 14:45:00.000', null, 'Zona Industrial da Maia, Rua A', 'Maia', 'Portugal'),
(6, 6, 7, 45.90, '20230320 17:00:00.000', '20230321 11:00:00.000', 'Mercado Municipal, Loja 60', 'Faro', 'Portugal'),
(7, 7, 8, 79.99, '20230402 09:00:00.000', '20230402 18:00:00.000', 'Rua Miguel Bombarda, 70', 'Porto', 'Portugal'),
(8, 8, 9, 250.00, '20230418 13:30:00.000', '20230420 15:00:00.000', 'Edifício Office Park, Piso 8', 'Lisboa', 'Portugal'),
(9, 9, 10, 180.75, '20230501 10:00:00.000', '20230503 12:30:00.000', 'Avenida da República, 90', 'Lisboa', 'Portugal'),
(10, 10, 11, 650.00, '20230515 16:20:00.000', null, 'Estrada Nacional 1, Km 100', 'Leiria', 'Portugal'),
(11, 11, 12, 55.00, '20230607 11:50:00.000', '20230608 17:00:00.000', 'Aeroporto de Lisboa, Loja 11', 'Lisboa', 'Portugal'),
(12, 12, 13, 450.00, '20230622 10:05:00.000', '20230623 14:15:00.000', 'Rua Sá da Bandeira, 120', 'Porto', 'Portugal'),
(13, 13, 14, 199.90, '20230703 09:30:00.000', '20230705 10:45:00.000', 'Parque Industrial de Setúbal, Lote 13', 'Setúbal', 'Portugal'),
(14, 14, 15, 29.90, '20230719 14:10:00.000', '20230720 09:00:00.000', 'Docas de Alcântara, Armazém 14', 'Lisboa', 'Portugal'),
(15, 15, 2, 300.00, '20230801 12:00:00.000', '20230802 15:30:00.000', 'Rua Áurea, 150', 'Lisboa', 'Portugal');

insert into TBPurchaseItem3139786 (purchase_id, product_id, unit_price, quantity) values
(1, 1, 1200.00, 1),
(2, 2, 850.00, 1),
(3, 3, 95.00, 1),
(4, 4, 120.50, 1),
(5, 5, 80.00, 1),
(6, 6, 45.90, 1),
(7, 7, 79.99, 1),
(8, 8, 250.00, 1),
(9, 9, 180.75, 1),
(10, 10, 650.00, 1),
(11, 11, 55.00, 1),
(12, 12, 450.00, 1),
(13, 13, 199.90, 1),
(14, 14, 29.90, 1),
(15, 15, 150.00, 2);

/*
Exercício 2). Criar uma consulta e depois uma visão (view) para:
exibir (mostrar) todos os dados presentes na tabela Product.
Mostrar a execução da visão.
*/

select
	product_id				[ID],
	product_name			[Nome do produto],
	category_id				[ID Categoria],
	quantity_per_unit		[Quantidade por unidade],
	unit_price				[Preço Unidade],
	units_in_stock			[Unidades em Estoque],
	discontinued			[Descontinuado?]
from TBProduct3139786

create view vProdutos
as
	select
		product_id				[ID],
		product_name			[Nome do produto],
		category_id				[ID Categoria],
		quantity_per_unit		[Quantidade por unidade],
		unit_price				[Preço Unidade],
		units_in_stock			[Unidades em Estoque],
		discontinued			[Descontinuado?]
	from TBProduct3139786

select * from vProdutos

/*
Exercício 3). Criar uma consulta e depois uma visão (view).
Exibir (mostrar, retornar) os nomesdosprodutos com um preço unitário maior ou igual a 3,5.
Mostrar a execução da visão.
*/

select
	product_name				[Nome dos Produtos]
from
	TBProduct3139786
where
	unit_price >= 3.5

create view vProdutosPrecoUnitarioMaior3eMeio
as
	select
		product_name				[Nome dos Produtos]
	from
		TBProduct3139786
	where
		unit_price >= 3.5

select * from vProdutosPrecoUnitarioMaior3eMeio

/*
Exercício 4). Criar uma consulta e depois uma visão (view).
Exibir (mostrar/retornar) os dados de todos os Produtos em categorias
com ID 1 (Alimentos) ou 5 (Frutas e legumes) e com preço unitário acimade3,5
*/

select
	product_id				[ID],
	product_name			[Nome do produto],
	category_id				[ID Categoria],
	quantity_per_unit		[Quantidade por unidade],
	unit_price				[Preço Unidade],
	units_in_stock			[Unidades em Estoque],
	discontinued			[Descontinuado?]
from
	TBProduct3139786
where
	(unit_price >= 3.5 and (category_id = 1 or category_id = 5))

create view vProdutosPorCategoria1ou5
as
	select
		product_id				[ID],
		product_name			[Nome do produto],
		category_id				[ID Categoria],
		quantity_per_unit		[Quantidade por unidade],
		unit_price				[Preço Unidade],
		units_in_stock			[Unidades em Estoque],
		discontinued			[Descontinuado?]
	from
		TBProduct3139786
	where
		(unit_price >= 3.5 and (category_id = 1 or category_id = 5))

select * from vProdutosPorCategoria1ou5

/*
Exercício 5). Criar uma consulta e depois uma visão (view).
Que exibe, mostra, retorna: os nomesdosprodutos junto com suas categorias.
Exiba duas colunas: Product_Name e Category_Name.
Use alias para colocar o nome das colunas em português.
*/

select
	p.product_name					[Nome dos Produtos],
	c.name							[Nome das Categorias]
from
	TBProduct3139786 as p
join
	TBCategory3139786 as c
	on (p.category_id = c.category_id)

create view vProdutoECategoria
as
	select
		p.product_name					[Nome dos Produtos],
		c.name							[Nome das Categorias]
	from
		TBProduct3139786 as p
	join
		TBCategory3139786 as c
		on (p.category_id = c.category_id)

select * from vProdutoECategoria

/*
Exercício 6). Fazer uma consulta e uma visão que exibe, mostra, retorna:
para cada compra, o ID da compra, o nome do funcionário, o nome cliente,
Calcular o Total da Compra, e Contar Quantos produtos tem na compra.
Usar alias e traduzir o nome das colunas para o português.
Mostrar a execução da visão.
*/

select
	pur.purchase_id						[ID da Compra],
	emp.first_name						[Nome do funcionário],
	c.contact_name						[Nome do Cliente],
	sum(pri.quantity * pri.unit_price)	[Total da compra],
	count(pri.product_id)				[Quantidade de Produtos]
from
	TBPurchase3139786 as pur
join
	TBEmployee3139786 as emp
	on (pur.employee_id = emp.employee_id)
join
	TBCustomer3139786 as c
	on (c.customer_id = pur.customer_id)
join
	TBPurchaseItem3139786 as pri
	on (pur.purchase_id = pri.purchase_id)
group by pur.purchase_id, emp.first_name, c.contact_name

create view vCompra
as
	select
		pur.purchase_id						[ID da Compra],
		emp.first_name						[Nome do funcionário],
		c.contact_name						[Nome do Cliente],
		sum(pri.quantity * pri.unit_price)	[Total da compra],
		count(pri.product_id)				[Quantidade de Produtos]
	from
		TBPurchase3139786 as pur
	join
		TBEmployee3139786 as emp
		on (pur.employee_id = emp.employee_id)
	join
		TBCustomer3139786 as c
		on (c.customer_id = pur.customer_id)
	join
		TBPurchaseItem3139786 as pri
		on (pur.purchase_id = pri.purchase_id)
	group by pur.purchase_id, emp.first_name, c.contact_name

select * from vCompra

/*
Exercício 7). Customizar o exercício 6), de tal forma que seja possível no momento
de fazer uma pesquisa fazer a passagem do parâmetro ID de um pedido (ou compra).
Fazer uma função (fx) e uma procedure(sp) que exibe os mesmos dados do Exercício 6).
A fx e a sp deve receber como parâmetro de entrada o código de um pedido (compra).
Mostrar a execução da sp e da fx para duas(2) compras.
*/

create function fCompra
(@purchase_id int)
returns table
as
return
(	select
			pur.purchase_id						[ID da Compra],
			emp.first_name						[Nome do funcionário],
			c.contact_name						[Nome do Cliente],
			sum(pri.quantity * pri.unit_price)	[Total da compra],
			count(pri.product_id)				[Quantidade de Produtos]
		from
			TBPurchase3139786 as pur
		join
			TBEmployee3139786 as emp
			on (pur.employee_id = emp.employee_id)
		join
			TBCustomer3139786 as c
			on (c.customer_id = pur.customer_id)
		join
			TBPurchaseItem3139786 as pri
			on (pur.purchase_id = pri.purchase_id)
		where
			pur.purchase_id = @purchase_id
		group by pur.purchase_id, emp.first_name, c.contact_name
);

select * from fCompra(1);
select * from fCompra(7);

create procedure spCompra
(@purchase_id int)
as
begin
	begin transaction tCompra
		select
			pur.purchase_id						[ID da Compra],
			emp.first_name						[Nome do funcionário],
			c.contact_name						[Nome do Cliente],
			sum(pri.quantity * pri.unit_price)	[Total da compra],
			count(pri.product_id)				[Quantidade de Produtos]
		from
			TBPurchase3139786 as pur
		join
			TBEmployee3139786 as emp
			on (pur.employee_id = emp.employee_id)
		join
			TBCustomer3139786 as c
			on (c.customer_id = pur.customer_id)
		join
			TBPurchaseItem3139786 as pri
			on (pur.purchase_id = pri.purchase_id)
		where
			pur.purchase_id = @purchase_id
		group by pur.purchase_id, emp.first_name, c.contact_name
	if @@ERROR = 0
	begin
		commit transaction tCompra
	end
	else
	begin
		rollback transaction tCompra
	end
end

exec spCompra 1
exec spCompra 7

/*
Exercício 8). Fazer uma consulta e depois uma visão. Que, para cada compra (pedido),
exiba(mostra, retorna) todas as categorias de produtos comprados nessa compra.
Mostre cada categoria apenas uma vez para cada compra.
Mostrar a execução da visão.
*/

select distinct
	pur.purchase_id,
	prd.category_id
from
	TBPurchase3139786 as pur
join
	TBPurchaseItem3139786 as pri
	on (pur.purchase_id = pri.purchase_id)
right join
	TBProduct3139786 as prd
	on (pri.product_id = prd.product_id)

insert into TBPurchase3139786 (purchase_id, customer_id, employee_id, total_price, purchase_date, shipped_date, ship_address, ship_city, ship_country) values
(16, 1, 2, 1200.00, '20230110 09:30:00.000', '20230111 14:00:00.000', 'Rua das Flores, 10', 'Lisboa', 'Portugal')

insert into TBPurchaseItem3139786 (purchase_id, product_id, unit_price, quantity) values
(16, 1, 1200.00, 1)
