/*
Prova para dispensa da disciplina Banco de Dados
Curso: ADS
Banco de Dados BDAgenciaBancaria
Data: 02/10/2024
DBA: Bruno Soares Machado
Matrícula: 3139786
*/

--Criando o Banco de Dadcreate database BDAgenciaBancaria3139786
create database BDAgenciaBancaria3139786
--Definindo para o uso o banco de dados criados
use BDAgenciaBancaria3139786

-----------------------------------------------------------------------------------
--Criar tabela Banco
create table TBBanco3139786(
	IDBanco					int					not null primary key,
	Nome					varchar(50)			not null,
	DataFuncao				date				not null,
	Logradouro				varchar(40)			not null,
	NumeroRua				int					not null,
	Bairro					varchar(30)			not null,
	Cidade					varchar(30)			not null,
	Estado					varchar(2)			not null
);

--Inserindo dados na tabela TBBanco
insert into TBBanco3139786 values
	(1, 'Bancão', '02/09/2024', 'Rua A', 8, 'Bairro A', 'Cidade A',	'SP'),
	(2, 'Banquinho', '03/09/2024', 'Rua B', 3, 'Bairro D', 'Cidade B', 'MG'),
	(3, 'Banqueri', '09/09/2024', 'Rua E', 7, 'Bairro C', 'Cidade C', 'PR'),
	(4, 'Banco Bom', '01/09/2024', 'Rua C', 9, 'Bairro E', 'Cidade D', 'MT'),
	(5, 'Banco 12 irmãos', '07/09/2024', 'Rua D', 5, 'Bairro B', 'Cidade E', 'SC')
;

--Visualizando os dados inseridos na tabela TBBanco
select * from TBBanco3139786


-----------------------------------------------------------------------------------
--Criar tabela Agencia
create table TBAgencia3139786(
	IDAgencia				int					not null,
	CodBanco				int					not null,
	CPFGerente				bigint				not null,
	Logradouro				varchar(40)			not null,
	NumeroRua				int					not null,
	Bairro					varchar(30)			not null,
	Cidade					varchar(30)			not null,
	Estado					varchar(2)			not null			
);


--Inserindo dados na tabela TBBanco
insert into TBAgencia3139786 values
	(1, 1, 12312312312, 'Rua A', 8, 'Bairro A', 'Cidade A',	'SP'),
	(2, 2, 23423423423, 'Rua B', 3, 'Bairro D', 'Cidade B', 'MG'),
	(3, 3, 34534534534, 'Rua E', 7, 'Bairro C', 'Cidade C', 'PR'),
	(4, 4, 45645645645, 'Rua C', 9, 'Bairro E', 'Cidade D', 'MT'),
	(5, 5, 56756756756, 'Rua D', 5, 'Bairro B', 'Cidade E', 'SC')
;

--Visualizando os dados inseridos na tabela TBBanco
select * from TBAgencia3139786


-----------------------------------------------------------------------------------
--Criar tabela Telefone Agencia
create table TBTelefoneAgencia3139786(
	Telefone				bigint				not null,
	CodAgencia				int					not null,
	CodBanco				int					not null,
);

--Inserindo dados na tabela TBAgencia
insert into TBTelefoneAgencia3139786 values
	(12123121212, 1, 1),
	(23234232323, 2, 2),
	(34345343434, 3, 3),
	(45456454545, 4, 4),
	(56567565656, 5, 5)
;

--Visualizando os dados inseridos na tabela TBBanco
select * from TBTelefoneAgencia3139786



-----------------------------------------------------------------------------------
--Criar tabela Banco
create table TBFuncionario3139786(
	CPF						bigint				not null primary key,
	CodAgencia				int					not null,
	CodBanco				int					not null,
	CPFSupervisor			bigint				not null,
	DataInicio				date				not null,
	Nome					varchar(50)			not null,
	Salario					decimal(10,2)		not null
);

--Inserindo dados na tabela TBBanco
insert into TBFuncionario3139786 values
	(12312312312, 1, 1, 56756756756, '2024-09-02', 'Capivari', 3000.00),
	(23423423423, 2, 2, 45645645645, '2024-09-02', 'Firuli', 7500.00),
	(34534534534, 3, 3, 34534534534, '2024-09-02', 'Pirim', 9000.00),
	(45645645645, 4, 4, 23423423423, '2024-09-02', 'Irineu', 8000.00),
	(56756756756, 5, 5, 12312312312, '2024-09-02', 'Shaolim', 6000.00)
;

--Visualizando os dados inseridos na tabela TBBanco
select * from TBFuncionario3139786


-----------------------------------------------------------------------------------
--Criar tabela Telefone Funcionario
create table TBTelefoneFuncionario3139786(
	IDTelefone				bigint				not null,
	CPF						bigint				not null,
	primary key (IDTelefone, CPF),
	foreign key (CPF) references TBFuncionario3139786 (CPF)
);

--Inserindo dados na tabela TBAgencia
insert into TBTelefoneFuncionario3139786 values
	(123121212, 12312312312),
	(234232323, 23423423423),
	(345343434, 34534534534),
	(456454545, 45645645645),
	(567565656, 56756756756)
;

--Visualizando os dados inseridos na tabela TBBanco
select * from TBTelefoneFuncionario3139786


-----------------------------------------------------------------------------------
--Criar tabela Emprestimo
create table TBEmprestimo3139786(
	IDEmprestimo			bigint				not null primary key,
	Valor					decimal(10,2)		not null,
	TaxaJuros				decimal(10,2)		not null,
	ValorRestante			decimal(10,2)		not null,
	DataQuitacao			datetime			not null,
);

--Inserindo dados na tabela TBEmprestimo
insert into TBEmprestimo3139786 values
	(1, 1500.00, 1.0, 300.00, '2024-09-04 08:35:00'),
	(2, 900.00, 1.3, 300.00, '2024-09-05 09:10:00'),
	(3, 3500.00, 3.1, 300.00, '2024-09-05 10:15:00'),
	(4, 2700.00, 3.8, 300.00, '2024-10-01 09:10:00'),
	(5, 2500.00, 2.3, 300.00, '2024-10-02 10:13:00')
;

--Visualizando os dados inseridos na tabela TBBanco
select * from TBEmprestimo3139786


-----------------------------------------------------------------------------------
--Criar tabela Telefone Pagamento
create table TBPagamento3139786(
	IDPagamento				bigint				not null primary key,
	CodEmprestimo			bigint				not null,
	DataPagamento			datetime			not null,
	Valor					decimal(10,2)		not null,
	foreign key (CodEmprestimo) references TBEmprestimo3139786	(IDEmprestimo)
);

--Inserindo dados na tabela TBPagamento
insert into TBPagamento3139786 values
	(1, 1, '2024-09-04 08:35:00', 500.00),
	(2, 2, '2024-09-05 09:10:00', 300.00),
	(3, 3, '2024-09-05 10:15:00', 600.00),
	(4, 4, '2024-10-01 09:10:00', 720.00),
	(5, 5, '2024-10-02 10:13:00', 500.00)
;

--Visualizando os dados inseridos na tabela TBBanco
select * from TBPagamento3139786


-----------------------------------------------------------------------------------
--Criar tabela Cliente
create table TBCliente3139786(
	IDCliente				int					not null primary key,
	Nome					varchar(50)			not null,
	DataNascimento			date				not null,
	Logradouro				varchar(40)			not null,
	NumeroRua				int					not null,
	Bairro					varchar(30)			not null,
	Cidade					varchar(30)			not null,
	Estado					varchar(2)			not null
);

--Inserindo dados na tabela TBCliente
insert into TBCliente3139786 values
	(1, 'Nycolas', '2005-06-06', 'Rua das capivaras', '3', 'Bairro Zoo', 'Cidade A', 'SP'),
	(2, 'Augusto', '1995-08-13', 'Rua das antas', '5', 'Vida Nova', 'Cidade B', 'MG'),
	(3, 'Leticia', '2001-12-28', 'Rua dos leões', '4', 'New City', 'Cidade C', 'PR'),
	(4, 'Livia', '1999-10-17', 'Rua das preás', '9', 'Bairro da Paz', 'Cidade D', 'MT'),
	(5, 'Kauã', '2003-02-03', 'Rua das tartarugas', '10', 'Maria do Socorro', 'Cidade E', 'SC')
;

--Visualizando os dados inseridos na tabela TBCliente
select * from TBCliente3139786


-----------------------------------------------------------------------------------
--Criar tabela Pessoa Juridica
create table TBPessoaJuridica3139786(
	CodCliente				int					not null primary key,
	CNPJ					bigint				not null,
	NomeFantasia			varchar(20)			not null,
	foreign key (CodCliente) references TBCliente3139786 (IDCliente)
);

--Inserindo dados na tabela TBPessoaJuridica
insert into TBPessoaJuridica3139786 values
	(1, 12123123000112, 'Empresa A'),
	(2, 23234234000123, 'Empresa B'),
	(3, 34345345000134, 'Empresa C'),
	(4, 45456456000145, 'Empresa D'),
	(5, 56567567000156, 'Empresa E')
;

--Visualizando os dados inseridos na tabela TBPessoaJuridica
select * from TBPessoaJuridica3139786


-----------------------------------------------------------------------------------
--Criar tabela Telefone Cliente
create table TBTelefoneCliente3139786(
	IDTelefone				bigint				not null,
	CodCliente				int					not null,
	primary key (IDTelefone, CodCliente),
	foreign key (CodCliente) references TBCliente3139786 (IDCliente)
);

--Inserindo dados na tabela TBTelefoneCliente
insert into TBTelefoneCliente3139786 values
	(17123324554, 1),
	(17234435665, 2),
	(17345546776, 3),
	(17456657887, 4),
	(17567768998, 5)
;

--Visualizando os dados inseridos na tabela TBTelefoneCliente
select * from TBTelefoneCliente3139786


-----------------------------------------------------------------------------------
--Criar tabela Pessoa Fisica
create table TBPessoaFisica3139786(
	CodCliente				int					not null primary key,
	CPF						bigint				not null,
	EstadoCivil				varchar(20)			not null,
	Sexo					varchar(1)			not null,
	RG						int					not null,
	foreign key (CodCliente) references TBCliente3139786 (IDCliente)
);

--Inserindo dados na tabela TBPessoaFisica
insert into TBPessoaFisica3139786 values
	(1, 32132132112, 'Solteiro(a)', 'F', 3213213),
	(2, 43242342323, 'Solteiro(a)', 'F', 4324324),
	(3, 54354354334, 'Casado(a)', 'M', 5435435),
	(4, 65465465445, 'Divorciado(a)', 'M', 6546546),
	(5, 76576576556, 'Solteiro(a)', 'F', 7657657)
;

--Visualizando os dados inseridos na tabela TBPessoaFisica
select * from TBPessoaFisica3139786


-----------------------------------------------------------------------------------
--Alterando tabela TBAgencia e adicionando os relacionamentos
alter table TBAgencia3139786
add
	primary key (IDAgencia, CodBanco),
	foreign key (CodBanco) references TBBanco3139786 (IDBanco),
	foreign key (CPFGerente) references TBFuncionario3139786 (CPF)
;


-----------------------------------------------------------------------------------
--Criar tabela TBConta
create table TBConta3139786(
	IDConta					int					not null,
	CodAgencia				int					not null,
	CodBanco				int					not null,
	Saldo					decimal(10,2)		not null,
	primary key (IDConta, CodAgencia, CodBanco),
	foreign key	(CodAgencia, CodBanco) references TBAgencia3139786 (IDAgencia, CodBanco),
);

--Inserindo dados na tabela TBTelefoneCliente
insert into TBConta3139786 values
	(1, 1, 1, 300.00),
	(2, 2, 2, 3000.00),
	(3, 3, 3, 357.00),
	(4, 4, 4, 789.00),
	(5, 5, 5, 312.00)
;

--Visualizando os dados inseridos na tabela TBTelefoneCliente
select * from TBConta3139786


-----------------------------------------------------------------------------------
--Criar tabela TBConta
create table TBClienteConta3139786(
	CodCliente				int					not null,
	CodConta				int					not null,
	CodAgencia				int					not null,
	CodBanco				int					not null,
	primary key (CodCliente, CodConta, CodAgencia, CodBanco),
	foreign key (CodCliente) references TBCliente3139786 (IDCliente),
	foreign key (CodConta, CodAgencia, CodBanco) references TBConta3139786 (IDConta, CodAgencia, CodBanco)
);

--Inserindo dados na tabela TBTelefoneCliente
insert into TBClienteConta3139786 values
	(1, 1, 1, 1),
	(2, 2, 2, 2),
	(3, 3, 3, 3),
	(4, 4, 4, 4),
	(5, 5, 5, 5)
;

--Visualizando os dados inseridos na tabela TBTelefoneCliente
select * from TBClienteConta3139786


-----------------------------------------------------------------------------------
--Criar tabela TBServico
create table TBServico3139786(
	IDServico				bigint				not null,
	CodCliente				int					not null,
	CodConta				int					not null,
	CodAgencia				int					not null,
	CodBanco				int					not null,
	Valor					decimal(10,2)		not null,
	Tipo					varchar(10)			not null,
	DataServico				datetime			not null,
	primary key (IDServico, CodCliente, CodConta, CodAgencia, CodBanco),
	foreign key (CodCliente, CodConta, CodAgencia, CodBanco) references TBClienteConta3139786 (CodCliente, CodConta, CodAgencia, CodBanco)
);

--Inserindo dados na tabela TBServico
insert into TBServico3139786 values
	(1, 1, 1, 1, 1, 30.00, 'Tipo A', '2024-09-04 08:35:00'),
	(2, 2, 2, 2, 2, 35.00, 'Tipo B', '2024-09-05 09:37:00'),
	(3, 3, 3, 3, 3, 53.00, 'Tipo C', '2024-09-05 11:06:00'),
	(4, 4, 4, 4, 4, 80.00, 'Tipo D', '2024-09-07 15:51:00'),
	(5, 5, 5, 5, 5, 15.00, 'Tipo E', '2024-09-08 16:10:00')
;

--Visualizando os dados inseridos na tabela TBServico
select * from TBServico3139786


-----------------------------------------------------------------------------------
--Criar tabela TB Conta Poupanca
create table TBContaPoupanca3139786(
	CodConta				int					not null,
	CodAgencia				int					not null,
	CodBanco				int					not null,
	TaxaJuros				decimal(10,2)		not null,
	primary key (CodConta, CodAgencia, CodBanco),
	foreign key (CodConta, CodAgencia, CodBanco) references TBConta3139786 (IDConta, CodAgencia, CodBanco)
);

--Inserindo dados na tabela TBTelefoneCliente
insert into TBContaPoupanca3139786 values
	(1, 1, 1, 1.0),
	(2, 2, 2, 2.1),
	(3, 3, 3, 1.3),
	(4, 4, 4, 1.4),
	(5, 5, 5, 1.15)
;

--Visualizando os dados inseridos na tabela TBTelefoneCliente
select * from TBContaPoupanca3139786


-----------------------------------------------------------------------------------
--Criar tabela TB Conta Corrente
create table TBContaCorrente3139786(
	CodConta				int					not null,
	CodAgencia				int					not null,
	CodBanco				int					not null,
	LimiteChequeEspecial	decimal(10,2)		not null,
	primary key (CodConta, CodAgencia, CodBanco),
	foreign key (CodConta, CodAgencia, CodBanco) references TBConta3139786 (IDConta, CodAgencia, CodBanco)
);

--Inserindo dados na tabela TBTelefoneCliente
insert into TBContaCorrente3139786 values
	(1, 1, 1, 1000.0),
	(2, 2, 2, 2750.1),
	(3, 3, 3, 1500.3),
	(4, 4, 4, 1350.4),
	(5, 5, 5, 1254.15)
;

--Visualizando os dados inseridos na tabela TBTelefoneCliente
select * from TBContaCorrente3139786


-----------------------------------------------------------------------------------
--Alterando tabela TBAgencia e adicionando os relacionamentos
alter table TBTelefoneAgencia3139786 add
primary key (Telefone, CodAgencia, CodBanco),
foreign key (CodAgencia, CodBanco) references TBAgencia3139786 (IDAgencia, CodBanco);


-----------------------------------------------------------------------------------
--Alterando tabela TBAgencia e adicionando os relacionamentos
alter table TBFuncionario3139786 add
foreign key (CodAgencia, CodBanco) references TBAgencia3139786 (IDAgencia, CodBanco),
foreign key	(CPFSupervisor) references TBFuncionario3139786 (CPF)

-----------------------------------------------------------------------------------
--Criar tabela TBRealiza
create table TBRealiza3139786(
	CodCliente				int					not null,
	CodEmprestimo			bigint				not null,
	CPFFuncionario			bigint				not null,
	DataEmprestimo			datetime			not null,
	primary key (CodCliente, CodEmprestimo, CPFFuncionario),
	foreign key (CodCliente) references TBCliente3139786 (IDCliente),
	foreign key (CodEmprestimo) references TBEmprestimo3139786 (IDEmprestimo),
	foreign key (CPFFuncionario) references TBFuncionario3139786 (CPF),
);


--Inserindo dados na tabela TBRealiza
insert into TBRealiza3139786 values
	(1, 1, 12312312312, '2024-09-04 08:35:00'),
	(2, 2, 23423423423, '2024-09-05 09:10:00'),
	(3, 3, 34534534534, '2024-09-05 10:15:00'),
	(4, 4, 45645645645, '2024-10-01 09:10:00'),
	(5, 5, 56756756756, '2024-10-02 10:13:00')
;

--Visualizando os dados inseridos na tabela TBRealiza
select * from TBRealiza3139786
