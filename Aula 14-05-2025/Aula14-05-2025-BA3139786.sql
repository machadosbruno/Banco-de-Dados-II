/*
IFSP - BRT
Data: 14-05-2025
Curso: Cando de Dados 2 (ADS)
Prof.: Xyko Almeida
Aluno: Bruno Soares Machado
Matricual: BA3139786
Banco de dados: BDPetShopIFSP
*/

--1) Criar o BDPetShopIFSP e fazer o cadastro de 12 (doze) registros por tabela;

--criando o banco de dados
create database BDPetShopIFSP

--selecionando o banco de dados para uso
use BDPetShopIFSP

--criando as tabelad o banco0

create table TBEstado (
	IDUF					varchar(2)	not null primary key,
	NomeEstado				varchar(50) not null,
);

create table TBCidade (
	IDCidade				int not null primary key,
	NomeCidade				varchar(50) not null,
	CodUF					varchar(2) not null,
	foreign key	(CodUF) references TBEstado (IDUF)
);

create table TBFornecedor (
	IDFornecedor			int	not null primary key,
	RazaoSocial				varchar(50) not null,
	NomePetshop				varchar(50) not null,
	CNPJ					varchar(18) not null,
	Endereco				varchar(50) not null,
	CEP						int not null,
	Telefone				int not null,
	CodCidade				int not null,
	foreign key (CodCidade) references TBCidade (IDCidade)
);

create table TBTipo (
	IDTipo					int not null primary key,
	NomeTipo				varchar(50) not null,
);

create table TBFuncao (
	IDFuncao				int not null primary key,
	DescricaoFuncao			varchar(50) not null,
);

create table TBProduto (
	IDProduto				int not null primary key,
	CodigoBarra				int not null,
	Nomeproduto				varchar(50) not null,
	MarcaProduto			varchar(50) not null,
	ValorCompra				decimal(10,2) not null,
	ValorVenda				decimal(10,2) not null,
	QuantidadeCompra		int not null,
	QuantidadeEstoque		int not null,
	CodTipo					int not null,
	CodFornecedor			int not null,
	CodFuncao				int not null,
	foreign key (CodTipo) references TBTipo (IDTipo),
	foreign key (CodFornecedor) references TBFornecedor (IDFornecedor),
	foreign key (CodFuncao) references TBFuncao (IDFuncao),
);

create table TBCliente (
	IDCliente				int not null primary key,
	NomeCliente				varchar(50) not null,
	CPF						varchar(18) not null,
	Endereco				varchar(50) not null,
	CEP						int not null,
	Telefone				int not null,
	CodCidade				int not null,
	Email					varchar(50) not null,
	foreign key (CodCidade) references TBCidade (IDCidade)
);

create table TBAnimal (
	IDAnimal				int not null primary key,
	NomeAnimal				varchar(50) not null,
	Especie					varchar(50) not null,
	Raca					varchar(50) not null,
	Sexo					varchar(1) not null,
	CodCliente				int not null,
	foreign key (CodCliente) references TBCliente (IDCliente)
);

create table TBServico (
	IDServico				int not null primary key,
	Descricao				varchar(100) not null,
	ValorEstimadoServico	decimal(10,2) not null,
	TempoGasto				time not null,
	Observacao				varchar(100) not null
);

create table TBClienteServico (
	CodCliente				int not null,
	CodServico				int not null,
	Data					datetime,
	primary key (CodCliente, CodServico),
	foreign key (CodCliente) references TBCliente (IDCliente),
	foreign key (CodServico) references TBServico (IDServico),
);

create table TBAnimalServico (
	CodAnimal				int not null,
	CodServico				int not null,
	Data					datetime not null,
	Observacao				varchar(50) not null,
	QtdeServico				int not null,
	ValorServico			decimal(10,2),
	primary key (CodAnimal, CodServico),
	foreign key (CodAnimal) references TBAnimal (IDAnimal),
	foreign key (CodServico) references TBServico (IDservico),
);

create table TBFuncionario (
	IDFuncionario			int not null primary key,
	NomeFuncionario			varchar(50) not null,
	CPF						varchar(18) not null,
	Endereco				varchar(50) not null,
	CEP						int not null,
	Telefone				int not null,
	Email					varchar(50) not null,
	CodCidade				int not null,
	foreign key (CodCidade) references TBCidade (IDCidade),
);

create table TBFuncionarioServico (
	CodFuncionario			int not null,
	CodServico				int not null,
	Data					datetime,
	TempoGasto				time,
	primary key (CodFuncionario, CodServico),
	foreign key (CodFuncionario) references TBFuncionario (IDFuncionario),
	foreign key (CodServico) references TBServico (IDServico)
);

create table TBCompra (
	IDCompra				int not null primary key,
	DataCompra				datetime not null,
	CodCliente				int not null,
	CodFuncionario			int not null,
	foreign key (CodCliente) references TBCliente (IDCliente),
	foreign key (CodFuncionario) references TBFuncionario (IDFuncionario),
);

create table TBProdutosCompra (
	CodCompra				int not null,
	CodProduto				int not null,
	Quantidade				int not null,
	ValorCompra				decimal(10,2) not null,
	primary key (CodCompra, CodProduto),
	foreign key (CodCompra) references TBCompra (IDCompra),
	foreign key (CodProduto) references TBProduto (IDProduto)
);

--Inserindo os registros
insert into TBEstado values
('SP', 'São Paulo'),
('RJ', 'Rio de Janeiro'),
('MG', 'Minas Gerais'),
('BA', 'Bahia'),
('RS', 'Rio Grande do Sul'),
('PR', 'Paraná'),
('SC', 'Santa Catarina'),
('PE', 'Pernambuco'),
('CE', 'Ceará'),
('AM', 'Amazonas'),
('GO', 'Goiás'),
('ES', 'Espírito Santo');

insert into TBCidade values
(1, 'São Paulo Capital', 'SP'),
(2, 'Rio de Janeiro Capital', 'RJ'),
(3, 'Belo Horizonte', 'MG'),
(4, 'Salvador', 'BA'),
(5, 'Porto Alegre', 'RS'),
(6, 'Curitiba', 'PR'),
(7, 'Florianópolis', 'SC'),
(8, 'Recife', 'PE'),
(9, 'Fortaleza', 'CE'),
(10, 'Manaus', 'AM'),
(11, 'Goiânia', 'GO'),
(12, 'Vitória', 'ES');

insert into TBFornecedor values
(1, 'PetShop Alegria Animal Ltda', 'Alegria Animal Centro', '11.111.111/0001-11', 'Rua Principal, 100', 1010010, 11911111101, 1),
(2, 'Mundo Pet Comercio Eireli', 'Mundo Pet Zona Sul', '22.222.222/0001-22', 'Avenida Beira Mar, 200', 2020020, 21922222202, 2),
(3, 'Bicho Chique Servicos Pet ME', 'Bicho Chique Savassi', '33.333.333/0001-33', 'Praça da Liberdade, 30', 3030030, 31933333303, 3),
(4, 'Amor de Patas PetShop S.A.', 'Amor de Patas Pelourinho', '44.444.444/0001-44', 'Largo do Cruzeiro, 40', 4040040, 71944444404, 4),
(5, 'Cuidado Animal Total Ltda', 'Cuidado Animal Moinhos', '55.555.555/0001-55', 'Rua dos Andradas, 500', 5050050, 51955555505, 5),
(6, 'Pet Mania Comercio de Produtos Animais', 'Pet Mania Batel', '66.666.666/0001-66', 'Avenida Batel, 60', 6060060, 41966666606, 6),
(7, 'Paraiso dos Pets Eireli', 'Paraiso dos Pets BeiraMar', '77.777.777/0001-77', 'Avenida Beira Mar Norte, 70', 7070070, 48977777707, 7),
(8, 'Pet Feliz Sempre ME', 'Pet Feliz Boa Viagem', '88.888.888/0001-88', 'Rua da Praia, 80', 8080080, 81988888808, 8),
(9, 'Garras & Cia PetShop Ltda', 'Garras & Cia Aldeota', '99.999.999/0001-99', 'Avenida Santos Dumont, 90', 9090090, 85999999909, 9),
(10, 'Floresta Pet Comercio', 'Floresta Pet Adrianópolis', '10.101.010/0001-10', 'Rua da Floresta, 10', 1010100, 92910101010, 10),
(11, 'Meu Melhor Amigo Pet Ltda', 'Meu Melhor Amigo Bueno', '12.121.212/0001-12', 'Avenida T-63, 12', 1212012, 62912121212, 11),
(12, 'PetShop Central Vix ME', 'PetShop Central Praia do Canto', '13.131.313/0001-13', 'Rua Aleixo Neto, 13', 1313013, 27913131313, 12);

insert into TBFornecedor values
(1, 'Distribuidora Patas Felizes Ltda', 'Patas Felizes Distribuidora', '14.141.414/0001-14', 'Rua dos Fornecedores, 1', 1414014, 1191414, 1),
(2, 'Atacado Animal Total S.A.', 'Animal Total Atacado', '15.151.515/0001-15', 'Avenida Logística, 2', 1515015, 21915151, 2),
(3, 'Produtos Pet Premium Eireli', 'Pet Premium Distribuidor', '16.161.616/0001-16', 'Rodovia BR-040, Km 3', 1616016, 31916161, 3),
(4, 'Importados Pet Bahia Ltda', 'Pet Bahia Imports', '17.171.717/0001-17', 'Porto Seco de Salvador, Lote 4', 1717017, 71917171, 4),
(5, 'Sul Pet Distribuição ME', 'Sul Pet Dist.', '18.181.818/0001-18', 'Distrito Industrial, 5', 1818018, 51918181, 5),
(6, 'Paraná Pet Suprimentos Ltda', 'PR Pet Suprimentos', '19.191.919/0001-19', 'Rua da Indústria, 6', 1919019, 41919191, 6),
(7, 'Catarina Pet Atacadista Eireli', 'Catarina Pet Atacado', '20.202.020/0001-20', 'Via Expressa Sul, 7', 2020020, 48920202, 7),
(8, 'Nordeste Pet Fornecedor ME', 'Nordeste Pet Fornece', '21.212.121/0001-21', 'Polo Industrial, 8', 2121021, 81921212, 8),
(9, 'Ceará Pet Distribuidora Ltda', 'CE Pet Distribuidora', '23.232.323/0001-23', 'Avenida das Fábricas, 9', 2323023, 85923232, 9),
(10, 'Amazon Pet Suprimentos S.A.', 'Amazon Pet', '24.242.424/0001-24', 'Zona Franca, Lote 10', 2424024, 92924242, 10),
(11, 'Centro Oeste Pet Distribuidor Eireli', 'CO Pet Distribuidor', '25.252.525/0001-25', 'Distrito Agroindustrial, 11', 2525025, 62925252, 11),
(12, 'Espírito Santo Pet Atacado ME', 'ES Pet Atacado', '26.262.626/0001-26', 'Rodovia do Sol, Km 12', 2626026, 27926262, 12);


insert into TBTipo values
(1, 'Ração Seca Cães'),
(2, 'Ração Úmida Cães'),
(3, 'Ração Seca Gatos'),
(4, 'Ração Úmida Gatos'),
(5, 'Petisco Canino'),
(6, 'Petisco Felino'),
(7, 'Brinquedo Interativo'),
(8, 'Acessório Passeio'),
(9, 'Higiene e Beleza'),
(10, 'Farmácia Pet'),
(11, 'Cama e Conforto'),
(12, 'Caixa de Transporte');

insert into TBFuncao values
(1, 'Vendedor(a)'),
(2, 'Operador(a) de Caixa'),
(3, 'Banhista'),
(4, 'Tosador(a)'),
(5, 'Recepcionista PetShop'),
(6, 'Auxiliar Veterinário(a)'),
(7, 'Médico(a) Veterinário(a)'),
(8, 'Gerente de Loja'),
(9, 'Estoquista'),
(10, 'Auxiliar de Limpeza'),
(11, 'Motorista Entregador'),
(12, 'Atendente Geral');

insert into TBProduto values
(1, 78900001, 'Ração Premium Cães Adultos Carne 15kg', 'DogShow', 70.50, 119.90, 50, 30, 12, 1, 1),
(2, 78900002, 'Sachê Gourmet Gatos Salmão 85g', 'CatDelight', 2.10, 4.50, 200, 150, 4, 2, 3),
(3, 78900003, 'Biscoito Canino Integral Médio Porte 500g', 'CrocDog', 10.00, 18.90, 100, 70, 5, 3, 7),
(4, 78900004, 'Arranhador Torre Gatos Sisal', 'MiauHouse', 45.00, 89.90, 30, 15, 7, 4, 2),
(5, 78900005, 'Coleira Peitoral Cães Tam M Azul', 'PasseioSeguro', 22.00, 39.90, 60, 40, 8, 5, 4),
(6, 78900006, 'Shampoo Neutro Pelos Sensíveis 500ml', 'PetClean', 15.80, 29.90, 80, 55, 9, 6, 7),
(7, 78900007, 'Antipulgas Cães 10-20kg', 'ZeroPulga', 30.00, 55.00, 40, 25, 10, 7, 1),
(8, 78900008, 'Cama Redonda Aconchegante Tam G Cinza', 'SoninhoPet', 60.00, 110.00, 20, 10, 11, 8, 2),
(9, 78900009, 'Caixa Transporte Aéreo N.3', 'VooPet', 90.00, 179.90, 15, 8, 12, 9, 12),
(10, 7890010, 'Ração Super Premium Gatos Castrados Frango 3kg', 'NutriCat', 55.00, 95.50, 70, 45, 3, 10, 10),
(11, 7890011, 'Osso Nó Bovino Defumado Grande', 'RoerFeliz', 8.00, 15.00, 120, 90, 5, 11, 5),
(12, 7890012, 'Bolinha de Borracha Maciça com Apito', 'PlayDog', 5.50, 12.00, 150, 100, 7, 12, 6);

insert into TBCliente values
(1, 'João Silva', '111.111.111-11', 'Rua das Flores, 10', 1010101, 11911110, 1, 'joao.silva@email.com'),
(2, 'Maria Oliveira', '222.222.222-22', 'Avenida Copacabana, 20', 2020202, 21922220, 2, 'maria.oliveira@email.com'),
(3, 'Carlos Pereira', '333.333.333-33', 'Praça Sete, 30', 3030303, 31933330, 3, 'carlos.pereira@email.com'),
(4, 'Ana Costa', '444.444.444-44', 'Rua Chile, 40', 4040404, 71944440, 4, 'ana.costa@email.com'),
(5, 'Paulo Santos', '555.555.555-55', 'Rua da Praia, 50', 5050505, 51955550, 5, 'paulo.santos@email.com'),
(6, 'Sofia Almeida', '666.666.666-66', 'Alameda Dr. Muricy, 60', 6060606, 41966660, 6, 'sofia.almeida@email.com'),
(7, 'Lucas Ferreira', '777.777.777-77', 'Avenida Hercílio Luz, 70', 7070707, 48977770, 7, 'lucas.ferreira@email.com'),
(8, 'Beatriz Rodrigues', '888.888.888-88', 'Rua da Moeda, 80', 8080808, 81988880, 8, 'beatriz.rodrigues@email.com'),
(9, 'Gabriel Lima', '999.999.999-99', 'Avenida Dom Luís, 90', 9090909, 85999990, 9, 'gabriel.lima@email.com'),
(10, 'Larissa Gomes', '101.010.101-01', 'Rua Pará, 100', 1010010, 92910100, 10, 'larissa.gomes@email.com'),
(11, 'Matheus Azevedo', '121.212.121-21', 'Avenida 85, 110', 1111111, 62912120, 11, 'matheus.azevedo@email.com'),
(12, 'Isabela Martins', '131.313.131-31', 'Rua Sete de Setembro, 120', 1212121, 27913130, 12, 'isabela.martins@email.com');

insert into TBFuncionario values
(1, 'Fernanda Souza', '141.414.141-41', 'Rua Augusta, 1', 1001001, 11914140, 'fernanda.souza@petshop.com', 1),
(2, 'Ricardo Alves', '151.515.151-51', 'Avenida Atlântica, 2', 2002002, 21915150, 'ricardo.alves@petshop.com', 2),
(3, 'Camila Barbosa', '161.616.161-61', 'Rua da Bahia, 3', 3003003, 31916160, 'camila.barbosa@petshop.com', 3),
(4, 'Bruno Carvalho', '171.717.171-71', 'Ladeira da Barra, 4', 4004004, 71917170, 'bruno.carvalho@petshop.com', 4),
(5, 'Amanda Dias', '181.818.181-81', 'Avenida Ipiranga, 5', 5005005, 51918180, 'amanda.dias@petshop.com', 5),
(6, 'Diego Rocha', '191.919.191-91', 'Rua XV de Novembro, 6', 6006006, 41919190, 'diego.rocha@petshop.com', 6),
(7, 'Juliana Mendes', '202.020.202-02', 'Rua Felipe Schmidt, 7', 7007007, 48920200, 'juliana.mendes@petshop.com', 7),
(8, 'Leonardo Pinto', '212.121.212-12', 'Pátio de São Pedro, 8', 8008008, 81921210, 'leonardo.pinto@petshop.com', 8),
(9, 'Vanessa Nunes', '232.323.232-32', 'Rua Monsenhor Tabosa, 9', 9009009, 85923230, 'vanessa.nunes@petshop.com', 9),
(10, 'Rafael Moreira', '242.424.242-42', 'Avenida Djalma Batista, 10', 1000100, 92924240, 'rafael.moreira@petshop.com', 10),
(11, 'Gabriela Costa', '252.525.252-52', 'Avenida Mutirão, 11', 1101101, 62925250, 'gabriela.costa@petshop.com', 11),
(12, 'Thiago Fernandes', '262.626.262-62', 'Praia da Costa, 12', 1201201, 27926260, 'thiago.fernandes@petshop.com', 12);

insert into TBCompra values
(1, '2023-11-01 09:00:00', 1, 1),
(2, '2023-11-02 10:15:00', 2, 2),
(3, '2023-11-03 11:30:00', 3, 3),
(4, '2023-11-04 12:45:00', 4, 4),
(5, '2023-11-05 14:00:00', 5, 5),
(6, '2023-11-06 15:15:00', 6, 6),
(7, '2023-11-07 16:30:00', 7, 7),
(8, '2023-11-08 09:45:00', 8, 8),
(9, '2023-11-09 11:00:00', 9, 9),
(10, '2023-11-10 12:15:00', 10, 10),
(11, '2023-11-11 13:30:00', 11, 11),
(12, '2023-11-12 14:45:00', 12, 12);

insert into TBProdutosCompra values
(1, 1, 1, 119.90),
(2, 2, 5, 4.50),
(3, 3, 2, 18.90),
(4, 4, 1, 89.90),
(5, 5, 1, 39.90),
(6, 6, 5, 29.90),
(7, 7, 1, 55.00),
(8, 8, 7, 110.00),
(9, 9, 8, 179.90),
(10, 10, 9, 95.50),
(11, 11, 3, 15.00),
(12, 12, 4, 12.00);

insert into TBAnimal values
(1, 'Rex', 'Cachorro', 'Labrador', 'M', 1),
(2, 'Mimi', 'Gato', 'Siamês', 'F', 2),
(3, 'Thor', 'Cachorro', 'Pastor Alemão', 'M', 3),
(4, 'Luna', 'Gato', 'Persa', 'F', 4),
(5, 'Buddy', 'Cachorro', 'Golden Retriever', 'M', 5),
(6, 'Nina', 'Gato', 'Angorá', 'F', 6),
(7, 'Max', 'Cachorro', 'Poodle', 'M', 7),
(8, 'Bella', 'Gato', 'SRD (Sem Raça Definida)', 'F', 8),
(9, 'Charlie', 'Cachorro', 'Bulldog Francês', 'M', 9),
(10, 'Lucy', 'Gato', 'Maine Coon', 'F', 10),
(11, 'Rocky', 'Cachorro', 'Beagle', 'M', 11),
(12, 'Cleo', 'Gato', 'Sphynx', 'F', 12);

insert into TBServico values
(1, 'Banho Simples Cão Pequeno Porte', 50.00, '00:45:00', 'Inclui limpeza de ouvidos.'),
(2, 'Tosa Higiênica Cão Médio Porte', 40.00, '00:30:00', 'Aparar pelos das patas, barriga e região íntima.'),
(3, 'Consulta Veterinária Rotina', 120.00, '00:40:00', 'Check-up geral e orientação.'),
(4, 'Vacinação V10 Importada', 90.00, '00:15:00', 'Aplicação de vacina polivalente.'),
(5, 'Banho e Tosa Completa Gato Pelo Longo', 150.00, '01:30:00', 'Requer paciência, animal pode ser arisco.'),
(6, 'Hospedagem Diária Pet Pequeno', 70.00, '23:59:59', 'Alimentação não inclusa.'),
(7, 'Adestramento Básico - Aula Avulsa', 100.00, '01:00:00', 'Foco em comandos de obediência.'),
(8, 'Corte de Unhas (Cão ou Gato)', 25.00, '00:10:00', 'Serviço rápido.'),
(9, 'Hidratação de Pelos Profunda', 60.00, '00:30:00', 'Para pelos ressecados ou danificados.'),
(10, 'Consulta Comportamentalista', 200.00, '01:00:00', 'Análise e plano para problemas de comportamento.'),
(11, 'Microchipagem Animal', 80.00, '00:20:00', 'Inclui registro básico.'),
(12, 'Limpeza de Tártaro (Profilaxia Oral)', 350.00, '01:15:00', 'Requer avaliação prévia e, por vezes, sedação leve.');

insert into TBAnimalServico values
(1, 1, '2023-11-01 09:30:00', 'Animal cooperativo', 1001, 50.00),
(2, 2, '2023-11-01 08:00:00', 'Gato um pouco agitado.', 1002, 150.00),
(3, 3, '2023-11-02 10:45:00', 'Tosa padrão da raça.', 1003, 40.00),
(4, 4, '2023-11-02 11:00:00', 'Unhas estavam grandes.', 1004, 25.00),
(5, 5, '2023-11-03 12:00:00', 'Cliente trouxe histórico.', 1005, 120.00),
(6, 6, '2023-11-03 14:00:00', 'Reforço anual.', 1006, 90.00),
(7, 7, '2023-11-04 13:15:00', 'Pelo ficou macio.', 1007, 60.00),
(8, 8, '2023-11-04 15:00:00', 'Microchip aplicado.', 1008, 80.00),
(9, 9, '2023-11-05 14:30:00', 'Banho e secagem completa.', 1009, 50.00),
(10, 10, '2023-11-05 16:00:00', 'Realizado com sedação.', 1010, 350.00),
(11, 11, '2023-11-06 15:45:00', 'Proprietário participou.', 1011, 100.00),
(12, 12, '2023-11-06 17:00:00', 'Animal adaptou-se bem.', 1012, 70.00);

insert into TBClienteServico values
(1, 1, '2023-11-01 09:05:00'),
(2, 2, '2023-11-02 10:20:00'),
(3, 3, '2023-11-03 11:35:00'),
(4, 4, '2023-11-04 12:50:00'),
(5, 5, '2023-11-05 14:05:00'),
(6, 6, '2023-11-06 15:20:00'),
(7, 7, '2023-11-07 16:35:00'),
(8, 8, '2023-11-08 09:50:00'),
(9, 9, '2023-11-09 11:05:00'),
(10, 10, '2023-11-10 12:20:00'),
(11, 11, '2023-11-11 13:35:00'),
(12, 12, '2023-11-12 14:50:00');

insert into TBFuncionarioServico values
(1, 3, '2023-11-01 09:10:00', '00:45:00'),
(2, 4, '2023-11-02 10:25:00', '00:30:00'),
(3, 7, '2023-11-03 11:40:00', '00:40:00'),
(4, 6, '2023-11-03 11:50:00', '00:15:00'),
(5, 3, '2023-11-01 08:05:00', '01:30:00'),
(6, 12, '2023-11-06 17:05:00', '00:10:00'),
(7, 8, '2023-11-06 15:50:00', '01:00:00'),
(8, 4, '2023-11-02 11:05:00', '00:10:00'),
(9, 3, '2023-11-04 13:20:00', '00:30:00'),
(10, 7, '2023-11-02 10:30:00', '01:00:00'),
(11, 6, '2023-11-04 15:05:00', '00:20:00'),
(12, 7, '2023-11-05 16:05:00', '01:15:00');


--2) Fazer uma consulta e visão (View).
/*
Consultar as compras dos Clientes, mostrando:
Código e data da Compra;
Código e nome Cliente;
Código e nome do Funcionário;
Calcular o Total Compra;
Contar quantos itens (produtos) tem a Compra
Mostrar a execução da visão
*/
select
	c.IDCompra					[Código da Compra],
	c.DataCompra				[Data da Compra],
	cli.IDCliente				[Código do Cliente],
	cli.NomeCliente				[Nome do Cliente],
	f.IDFuncionario				[Código do Funcionário],
	f.NomeFuncionario			[Nome do Funcionário],
	sum(pc.Quantidade * pc.ValorCompra) [Total da Compra],
	count(pc.CodCompra)			[Quantidade de Itens]
from 
	TBCompra as c
join
	TBCliente as cli
	on (c.CodCliente = cli.IDCliente)
join
	TBFuncionario as f
	on (c.CodFuncionario = f.IDFuncionario)
join
	TBProdutosCompra as pc
	on (c.IDCompra = pc.CodCompra)
group by c.IDCompra, c.DataCompra, cli.IDCliente, cli.NomeCliente, f.IDFuncionario, f.NomeFuncionario

create view vCompra
as
	select
		c.IDCompra					[Código da Compra],
		c.DataCompra				[Data da Compra],
		cli.IDCliente				[Código do Cliente],
		cli.NomeCliente				[Nome do Cliente],
		f.IDFuncionario				[Código do Funcionário],
		f.NomeFuncionario			[Nome do Funcionário],
		sum(pc.Quantidade * pc.ValorCompra) [Total da Compra],
		count(pc.CodCompra)			[Quantidade de Itens]
	from 
		TBCompra as c
	join
		TBCliente as cli
		on (c.CodCliente = cli.IDCliente)
	join
		TBFuncionario as f
		on (c.CodFuncionario = f.IDFuncionario)
	join
		TBProdutosCompra as pc
		on (c.IDCompra = pc.CodCompra)
	group by c.IDCompra, c.DataCompra, cli.IDCliente, cli.NomeCliente, f.IDFuncionario, f.NomeFuncionario

select * from vCompra

--3) Fazer uma stored procedure (sp), que “usa transação”, que recebe como parâmetro ocódigo de um Cliente e retorna:
/*
Código, nome, telefone do Cliente;
Calcular (somar) o total de compras do Cliente;
Mostrar quantidade de compras deste cliente (contar);
Calcular a Média de Compras do Cliente.
Mostrar a execução da procedure (sp) para dois (2) clientes.
*/
create procedure spCliente
(@CodCliente int)
as
begin
	begin transaction tSpCliente
	declare @TotalCompras decimal(15,2)
	set @TotalCompras = (
		select
			sum(cp.Quantidade * cp.ValorCompra)
		from
			TBProdutosCompra as cp
		join
			TBCompra as c
			on (cp.CodCompra = c.IDCompra)
		where (c.CodCliente = @CodCliente)
	)
	declare @QtdCompras int
	set @QtdCompras = (
		select
			count(c.CodCliente)
		from
			TBCompra as c
		join
			TBCliente as cli
			on (c.CodCliente = cli.IDCliente)
		where (cli.IDCliente = @CodCliente)
	)
	select 
		c.IDCliente					[Código do Cliente],
		c.NomeCliente				[Nome do Cliente],
		c.Telefone					[Telefone do Cliente],
		(select @TotalCompras)		[Valor total das compras],
		(select @QtdCompras)		[Quantidade de Compras],
		sum(@TotalCompras / @QtdCompras) [Média de Compras]
	from
		TBCliente as c
	where c.IDCliente = @CodCliente
	group by c.IDCliente, c.NomeCliente, c.Telefone
	if @@TRANCOUNT != 0
	begin
		rollback transaction tSpCliente
	end
	else
	begin
		commit transaction tSpCliente
	end
end

exec spCliente 7
exec spCliente 2

--4) Fazer uma consulta e uma visão (view) que retorna:
/*
Código, nome, sexo do animal;
Nome do Cliente;
Calcular Total (R$) serviços realizados no animal;
Contar a quantidade de Serviços realizados no animal.
-- mostrar a execução da visão
*/
select
	a.IDAnimal					[Código do Animal],
	a.NomeAnimal				[Nome do Animal],
	a.Sexo						[Sexo do Animal],
	cli.NomeCliente				[Nome do cliente],
	sum(aser.QtdeServico * aser.ValorServico) [Total em serviços realizados no animal],
	count(aser.CodAnimal)		[Quantidade de Serviços realizados no animal]
from
	TBAnimal as a
join
	TBCliente as cli
	on (a.CodCliente = cli.IDCliente)
join
	TBAnimalServico as aser
	on (a.IDAnimal = aser.CodAnimal)
group by a.IDAnimal, a.NomeAnimal, a.Sexo, cli.NomeCliente

create view vAnimal
as
	select
		a.IDAnimal					[Código do Animal],
		a.NomeAnimal				[Nome do Animal],
		a.Sexo						[Sexo do Animal],
		cli.NomeCliente				[Nome do cliente],
		sum(aser.QtdeServico * aser.ValorServico) [Total em serviços realizados no animal],
		count(aser.CodAnimal)		[Quantidade de Serviços realizados no animal]
	from
		TBAnimal as a
	join
		TBCliente as cli
		on (a.CodCliente = cli.IDCliente)
	join
		TBAnimalServico as aser
		on (a.IDAnimal = aser.CodAnimal)
	group by a.IDAnimal, a.NomeAnimal, a.Sexo, cli.NomeCliente

select * from vAnimal

--5) Fazer uma stored procedure (sp) e uma função (fx)
/*
Recebe como parâmetro o código de um serviço e retorna:

Código, descrição, valor estimado do serviço, da tabela TBServico;
Data e tempo gasto de TBFuncionarioServico;
E nome do Funcionário.
	5.1) Seria possível saber e mostrar quais os funcionários realizaram mais de umserviço?
	-- mostrar a execução da sp e da fx.
*/
create procedure spServico
(@CodServico int)
as
begin
	begin transaction tSpServico
	select
		s.IDServico						[Código do Serviço],
		s.Descricao						[Descrição],
		s.ValorEstimadoServico			[Valor Estimado],
		fs.Data,
		fs.TempoGasto					[Tempo Gasto],
		f.NomeFuncionario				[Nome do funcionario]
	from
		TBServico as s
	join
		TBFuncionarioServico as fs
		on (s.IDServico = fs.CodServico)
	join
		TBFuncionario as f
		on (fs.CodFuncionario = f.IDFuncionario)
	where (s.IDServico = @CodServico)
	if @@TRANCOUNT != 0
	begin
		rollback transaction tSpServico
	end
	else
	begin
		commit transaction tSpServico
	end
end

exec spServico 7
exec spServico 3

create function fServico
(@CodServico int)
returns table
as
return(
	select
		s.IDServico						[Código do Serviço],
		s.Descricao						[Descrição],
		s.ValorEstimadoServico			[Valor Estimado],
		fs.Data,
		fs.TempoGasto					[Tempo Gasto],
		f.NomeFuncionario				[Nome do funcionario]
	from
		TBServico as s
	join
		TBFuncionarioServico as fs
		on (s.IDServico = fs.CodServico)
	join
		TBFuncionario as f
		on (fs.CodFuncionario = f.IDFuncionario)
	where (s.IDServico = @CodServico)
)

select * from fServico(3)
select * from fServico(7)
--Resposta a questão 5.1
/*
Sim, pois a procedure ou a função vai retornar mais de uma linha,
quando o serviço tem mais de um funcionário relacionado à ele.
*/

--6) Fazer uma consulta e depois uma visão (view) que retorne os dados. Mostrar a execuçãodaview.
/*
ID, Razão Social, e telefone do fornecedor;
Calcular o Total (R$) de Compra dos Produtos do Fornecedor;
Contar quantas Compras tem o Fornecedor;
Calcular o valor Médio das Compras do Fornecedor
*/
select
	f.IDFornecedor						[Código do Fornecedor],
	f.RazaoSocial						[Razão Social],
	f.Telefone,
	sum(pc.Quantidade * pc.ValorCompra)	[Total de Compra dos Produtos],
	COUNT(pc.CodProduto)				[Quantidade de Compras],
	(sum(pc.Quantidade * pc.ValorCompra) / COUNT(pc.CodProduto)) [Média das compra]
from
	TBFornecedor as f
join
	TBProduto as p
	on (f.IDFornecedor = p.CodFornecedor)
join
	TBProdutosCompra as pc
	on (p.IDProduto = pc.CodProduto)
group by f.IDFornecedor, f.RazaoSocial, f.Telefone

create view vFornecedor
as
	select
		f.IDFornecedor						[Código do Fornecedor],
		f.RazaoSocial						[Razão Social],
		f.Telefone,
		sum(pc.Quantidade * pc.ValorCompra)	[Total de Compra dos Produtos],
		COUNT(pc.CodProduto)				[Quantidade de Compras],
		(sum(pc.Quantidade * pc.ValorCompra) / COUNT(pc.CodProduto)) [Média das compra]
	from
		TBFornecedor as f
	join
		TBProduto as p
		on (f.IDFornecedor = p.CodFornecedor)
	join
		TBProdutosCompra as pc
		on (p.IDProduto = pc.CodProduto)
	group by f.IDFornecedor, f.RazaoSocial, f.Telefone

select * from vFornecedor

--7) Fazer uma consulta e uma visão e retorne dados:
/*
Elaborar uma consulta e depois uma visão.
Condição: que use pelo menos três (3) tabelas relacionadas e não seja nenhuma das visões anteriores.
Mostrar o enunciado da consulta.
*/

--Enunciado:
/*
	Consulta e Visão que mostra:
		ID, Nome e Cidade do Cliente;
		Conta quandos Serviços ele solicitou;
		Soma o valor total dos serviços
		Faz a média de valor dos serviços
*/

select
	c.IDCliente							[Código do Cliente],
	c.NomeCliente						[Nome do Cliente],
	cid.NomeCidade						[Nome da Cidade],
	count(cs.CodCliente)				[Quantidade de Servicos],
	sum(s.ValorEstimadoServico)			[Total em Serviços],
	(sum(s.ValorEstimadoServico) / count(cs.CodCliente)) [Média dos serviços]
from
	TBCliente as c
join
	TBClienteServico as cs
	on (c.IDCliente = cs.CodCliente)
join
	TBServico as s
	on (cs.CodServico = s.IDServico)
join
	TBCidade as cid
	on (c.CodCidade = cid.IDCidade)
group by c.IDCliente, c.NomeCliente, cid.NomeCidade

create view vClienteServico
as
	select
		c.IDCliente							[Código do Cliente],
		c.NomeCliente						[Nome do Cliente],
		cid.NomeCidade						[Nome da Cidade],
		count(cs.CodCliente)				[Quantidade de Servicos],
		sum(s.ValorEstimadoServico)			[Total em Serviços],
		(sum(s.ValorEstimadoServico) / count(cs.CodCliente)) [Média dos serviços]
	from
		TBCliente as c
	join
		TBClienteServico as cs
		on (c.IDCliente = cs.CodCliente)
	join
		TBServico as s
		on (cs.CodServico = s.IDServico)
	join
		TBCidade as cid
		on (c.CodCidade = cid.IDCidade)
	group by c.IDCliente, c.NomeCliente, cid.NomeCidade

select * from vClienteServico

--8) Fazer uma stored procedure (sp) que recebe como parâmetro um estado (UF).
/*
E retorna os dados:
UF, Nome do Estado. Contar quantos clientes tem por estado;
Contar quantos fornecedores tem por estado.
*/