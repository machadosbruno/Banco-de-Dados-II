/*
Banco de Dados: BD Biblioteca IFSP
Prova para dispensa de disciplina
DBA: Bruno Soares Machado
Matrícula: BA3139786
*/
--Criando o Banco de Dados
create database BDBibliotecaIFSP3139786
--Selecionando o Banco de dados para ser utilizado
use BDBibliotecaIFSP3139786

----------------------------------------------------------------------------
--Criando a tabela Editora
create table TBEditora3139786(
	IDEditora			int			not null primary key,
	NomeEditora			varchar(50)	not null,
	Cidade				varchar(50)	not null
);

--Inserindo dados na tabela TBEditora
insert into TBEditora3139786 values 
	(1, 'Coisa nossa', 'São Paulo'),
	(2, 'Cultura Livre', 'Cajamar'),
	(3, 'Ler é Bom', 'Osasco')
;
insert into TBEditora3139786 values 
	(4, 'Leitura que salva', 'Campinas'),
	(5, 'Livrar', 'Guarulhos')
;

--Verificando os dados inseridos na TBEditora
select * from TBEditora3139786


----------------------------------------------------------------------------
--Criando a tabela Obra
create table TBObra3139786(
	IDObra				int			not null primary key,
	Titulo				varchar(50)	not null,
	AutorPrincipal		varchar(50)	not null,
	AnoPublicacao		int			not null,
	SituacaoObra		int			not null,
	TipoObra			int			not null,
	CodEditora			int			not null,
	check(SituacaoObra = 1 or SituacaoObra = 2),
	check(TipoObra = 1 or TipoObra = 2),
	foreign key (CodEditora) references TBEditora3139786 (IDEditora)
);

--Inserindo dados na tabela TObra
insert into TBObra3139786 values 
	(1, 'Carros', 'Zezinho', 2013, 2, 1, 1),
	(2, 'Encantados', 'Fulaninho', 2014, 2, 1, 2),
	(3, 'Mickey Mouse', 'Beltraninho', 2015, 2, 1, 3),
	(4, 'Shrek', 'Ciclaninho', 2013, 2, 1, 4),
	(5, 'Pateta', 'Manezinho', 2014, 2, 1, 5)
;

--Verificando os dados inseridos na TBEditora
select * from TBObra3139786


----------------------------------------------------------------------------
--Criando a tabela Usuario
--Favor atentar que o projeto pede para que algumas
--colunas possam ser nulas nessa tabela
create table TBUsuario3139786(
	IDUsuario			int			not null primary key,
	NomeUsuario			varchar(50)	not null,
	EnderecoLogradouro	varchar(50)	not null,
	EnderecoNumero		int			not null,
	EnderecoComplemento	varchar(20),
	EnderecoBairro		varchar(30),
	EnderecoCidade		varchar(30)	not null,
	EnderecoUF			varchar(2)	not null,
	EnderecoCEP			varchar(10),
	Telefone			varchar(15),
	CPF					varchar(20)
);

--Inserindo dados na tabela TBUsuario
insert into TBUsuario3139786 (IDUsuario, NomeUsuario, EnderecoLogradouro, EnderecoNumero, EnderecoBairro, EnderecoCidade, EnderecoUF, CPF) values 
	(1, 'Karlos Kosta Kurta', 'Rua 3', 215, 'Alpha ville', 'Cajamar', 'SP', '12312312312'),
	(2, 'Karlinhos Kurto', 'Rua 2', 512, 'CDHU II', 'São Paulo', 'SP', '23423423434'),
	(3, 'Karlâo Kurtão', 'Rua 17', 222, 'Vida Nova', 'Osasco', 'SP', '56756756778'),
	(4, 'Karla Kosta Kumprida', 'Rua dos bobos', 365, 'Centro', 'Guarulhos', 'SP', '98798798712'),
	(5, 'Karlinha Kosta', 'Rua 5', 298, 'Sinatra', 'Campinas', 'SP', '10910910925')
;

--Verificando os dados inseridos na TBUsuario
select * from TBUsuario3139786


----------------------------------------------------------------------------
--Criando a tabela Obra
create table TBReserva3139786(
	IDReserva			int			not null primary key,
	CodUsuario			int			not null,
	CodObra				int			not null,
	DataReserva			date		not null,
	HorarioReserva		time		not null,
	DataRetirada		date		not null,
	foreign key (CodUsuario) references TBUsuario3139786 (IDUsuario),
	foreign key (CodObra) references TBObra3139786 (IDObra)
);

--Inserindo dados na tabela TBReserva
insert into TBReserva3139786 values 
	(1, 5, 3, '25/09/2024', '08:50', '25/09/2024'),
	(2, 2, 5, '25/09/2024', '09:10', '25/09/2024'),
	(3, 3, 4, '26/09/2024', '09:30', '26/09/2024'),
	(4, 4, 1, '27/09/2024', '11:25', '27/09/2024'),
	(5, 1, 2, '29/09/2024', '15:47', '29/09/2024')
;

--Verificando os dados inseridos na TBReserva
select * from TBReserva3139786


----------------------------------------------------------------------------
--Criando a tabela Funcionario
create table TBFuncionario3139786(
		IDMatricula		int			not null primary key,
		NomeFuncionario	varchar(50)	not null,
		CodDepartamento	int			not null
);
/*Não foi criada a restrição Chave Estrangeira na coluna CodDepartamento
pois a tabela Departamento ainda não foi criada, pois ela também
depende da Tabela Funcionario*/

--Inserindo dados na tabela TBFuncionario
insert into TBFuncionario3139786 values 
	(1, 'Serjão', 3),
	(2, 'Bitelo', 1),
	(3, 'Kariani', 2),
	(4, 'Balestrin', 5),
	(5, 'Mauricião', 4)
;

--Verificando os dados inseridos na TBFuncionario
select * from TBFuncionario3139786


----------------------------------------------------------------------------
--Criando a tabela Departamento
create table TBDepartamento3139786(
	IDDepartamento		int			not null primary key,
	NomeDepartamento	varchar(50)	not null,
	CodMatriculaChefe	int			not null,
	foreign key (CodMatriculaChefe) references TBFuncionario3139786 (IDMatricula)
);

--Inserindo dados na tabela TBDepartamento
insert into TBDepartamento3139786 values 
	(1, 'Recepção', 2),
	(2, 'Adminsitração', 3),
	(3, 'Limpeza', 1),
	(4, 'Segurança', 5),
	(5, 'Suporte', 4)
;

--Verificando os dados inseridos na TBDepartamento
select * from TBDepartamento3139786


----------------------------------------------------------------------------
--Alterando a tabela Funcionario, agora que temos a Tabela Departamento,
--da qual a Tabela Funcionario depende.
alter table TBFuncionario3139786 add foreign key (CodDepartamento) references TBDepartamento3139786 (IDDepartamento)


----------------------------------------------------------------------------
--Criando a tabela Emprestimo
create table TBEmprestimo3139786(
	IDEmprestimo		int			not null primary key,
	CodObra				int			not null,
	CodUsuario			int			not null,
	DataEmprestimo		date		not null,
	HorarioEmprestimo	time		not null,
	DataprevistaRetorno	date		not null,
	CodMatriculaFuncionario	int		not null,
	foreign key (CodObra) references TBObra3139786 (IDObra),
	foreign key (CodUsuario) references TBUsuario3139786 (IDUsuario),
	foreign key (CodMatriculaFuncionario) references TBFuncionario3139786 (IDMatricula)
);

--Inserindo dados na tabela TBEmprestimo
insert into TBEmprestimo3139786 values 
	(1, 5, 3, '25/09/2024', '08:50', '01/10/2024', 2),
	(2, 1, 5, '25/09/2024', '09:10', '01/10/2024', 2),
	(3, 4, 1, '26/09/2024', '09:30', '02/10/2024', 2),
	(4, 3, 2, '27/09/2024', '11:25', '03/10/2024', 2),
	(5, 2, 4, '29/09/2024', '15:47', '06/10/2024', 2)
;

--Verificando os dados inseridos na TBEmprestimo
select * from TBEmprestimo3139786


----------------------------------------------------------------------------
--Criando a tabela TBDevolucao
create table TBDevolucao3139786 (
	CodEmprestimo		int			not null primary key,
	DataDevolucao		date		not null,
	HoraDevolucao		time		not null,
	CodMatriculaFuncionario	int		not null,
	foreign key (CodEmprestimo) references TBEmprestimo3139786 (IDEmprestimo),
	foreign key (CodMatriculaFuncionario) references TBFuncionario3139786 (IDMatricula),
);

--Inserindo dados na tabela TBDevolucao
insert into TBDevolucao3139786 values 
	(1,	'30/09/2024', '08:30', 2),
	(2,	'01/10/2024', '09:57', 2),
	(3,	'01/10/2024', '09:05', 2),
	(4,	'03/09/2024', '11:31', 2),
	(5,	'02/09/2024', '15:30', 2)
;

--Verificando os dados inseridos na TBDevolucao
select * from TBDevolucao3139786