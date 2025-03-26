--Criando o banco de dados
create database BDTarefa4IFSP3139786

--Selecionando o BDTarefa4IFSP para realizar os próximos comandos
use BDTarefa4IFSP3139786

--Criando a tabela TBEquipamento
create table TBEquipamento3139786(
	IDEquipamento								int				not null primary key,
	NomeEquipamento								varchar(30)		not null,
	DataFabricacao								date			not null,
	DataUltimaRevisao							date			not null,
	ValorEquipamento							decimal(10,2)	not null,
	Finalidade									varchar(200)	not null
);

--Criando a tabela TBProjeto
create table TBProjeto3139786(
	IDProjeto									int				not null primary key,
	NomeProjeto									varchar(30)		not null,
	DescricaoProjeto							varchar(300)	not null,
	Valor										decimal(10,2)	not null,
	DataInicio									date			not null,
	DataFim										date			not null
);

--Criando a tabela TBOperador
create table TBOperador3139786(
	IDOperador									int				not null primary key,
	NomeOperador								varchar(50)		not null,
	DataNascimento								date			not null,
	DataQualificacao							date			not null,
	ValorHoraTrabalho							decimal(10,2)	not null,
);

--Criando a tabela TBProjetoEquipamentoOperador
create table TBProjetoEquipamentoOperador3139786(
	CodProjeto									int				not null,
	CodOperador									int				not null,
	CodEquipamento								int				not null,
	DataUso										date			not null,
	HoraInicio									time			not null,
	HoraFim										time			not null,
	TarefaRealizada								varchar(200)	not null,
	Observacao									varchar(300)	not null,
	primary key (CodProjeto, CodOperador, CodEquipamento),
	foreign key (CodProjeto) references TBProjeto3139786 (IDProjeto),
	foreign key (CodOperador) references TBOperador3139786 (IDOperador),
	foreign key (CodEquipamento) references TBEquipamento3139786 (IDEquipamento),
);