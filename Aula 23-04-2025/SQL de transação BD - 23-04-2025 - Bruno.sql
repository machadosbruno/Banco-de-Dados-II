--Exercício 2

--Criar o banco de dados
create database BDBruno3139786

--Usando o banco de dados criado
use BDBruno3139786

--Verificar se deu erro
select @@ERROR as [Código de erro]

--Verificar se há transações abertas
select @@TRANCOUNT as [Quantidade de Transações Abertas]

-- criar uma transação explicita com seu “PrimeiroNomeMatricula1”
begin transaction Bruno31397861

	-- dentro desta transação fazer as operações:

	--2.1) Criar uma tabela com pelo menos 4 campos.
	create table TBProduto3139786(
		IDProduto						int not null primary key,
		NomeProduto						varchar(50) not null,
		Descricao						varchar(255),
		Observacao						varchar(255)
	)

	--2.2) Inserir 5 registros nesta tabela;
	insert into TBProduto3139786 values 
	(201, 'Produto A', 'Desc Prod A', ''),
	(202, 'Produto B', 'Desc Prod B', ''),
	(203, 'Produto C', 'Desc Prod C', ''),
	(204, 'Produto D', 'Desc Prod D', ''),
	(205, 'Produto E', 'Desc Prod E', '');

	--2.3) Listar estes registros;
	select * from TBProduto3139786

	--2.4) Fazer a alteração do nome em um dos registros;
	update TBProduto3139786
	set NomeProduto = '3º Produto'
	where IDProduto = 203

	--2.5) Mostrar com select este registro alterado;
	select * from TBProduto3139786
	where IDProduto = 203

	--2.6) Excluir um destes registros;
	delete from TBProduto3139786 where IDProduto = 201

	--2.7) mostrar no select que o registro foi excluído;
	select * from TBProduto3139786
	where IDProduto = 201

	--2.8) mostrar com selec e @@trancout que tem uma trasanção aberta;
	select @@TRANCOUNT as [Quantidade de Transações Abertas]

--2.9) agora executar o comando para fechar a transação e não gravar nada
--(usar rollback transaction NomeTrabsacao) para fechar a transação;
rollback transaction Bruno31397861

--2.10) agora mostrar que a transação foi fechada (usar select e @@trancaout)
select @@TRANCOUNT as [Quantidade de Transações Abertas]

--e mostrar que todas as operações feitas foram excluídas ... tudo apagou com o rollback.
select * from TBProduto3139786
select @@ERROR as [Código de erro] --Código de erro será diferente de 0 (zero), portanto, o RollBack funcionou

--Exercício 3)
-- criar uma transação explicita com seu PrimeiroNomeMatricula1
begin transaction Bruno31397861

	-- dentro desta transação fazer as operações:
	--3.1) Criar outra tabela com pelo menos 4 campos.
	create table TBCentroDistribuicao3139786(
		IDCentroDistribuicao			int not null primary key,
		NomeCD							varchar(50) not null,
		TipoCD							varchar(50) not null,
		Observacao						varchar(255)
	);

	--3.2) inserir 5 registros nesta tabela;
	insert into TBCentroDistribuicao3139786 values
	(305, 'CD Belford', 'Tipo A', ''),
	(306, 'CD São Paulo', 'Tipo B', ''),
	(307, 'CD Betim', 'Tipo A', ''),
	(308, 'CD Maracanaú', 'Tipo C', 'Observado'),
	(309, 'CD Cuiabá', 'Tipo B', '');

	--3.3) Listar estes registros;
	select * from TBCentroDistribuicao3139786

	--3.4) Fazer a alteração do nome em um dos registros;
	update TBCentroDistribuicao3139786
	set NomeCD = 'Betim'
	where IDCentroDistribuicao = 307

	--3.5) Mostrar com select este registro alterado;
	select * from TBCentroDistribuicao3139786
	where IDCentroDistribuicao = 307

	--3.6) Excluir um destes registros;
	delete from TBCentroDistribuicao3139786
	where IDCentroDistribuicao = 305

	--3.7) mostrar no select que este registro foi escluido;
	select * from TBCentroDistribuicao3139786
	where IDCentroDistribuicao = 305

	--3.8) mostrar com selec e @@trancout que tem uma trasanção aberta;
	select @@TRANCOUNT as [Quantidade de Transações Abertas]

--3.9) agora executar o comando para fecha a transação
--e não gravar nada (usar Commit transaction NomeTrabsacao) para fechar a transação;
commit transaction Bruno31397861

--3.10) agora mostrar que a transação foram fechadas (usar select e @@trancount)
select @@TRANCOUNT as [Quantidade de Transações Abertas]
--e mostrar que todas as operações feitas foram excluídas ... tudo gravou com o commit.
select * from TBCentroDistribuicao3139786
select @@ERROR as [Código de Erro] --Código será igual a 0 (zero), portanto os dados foram gravados


--Exercício 4)
-- colocar a transação agora dentro de stored procedure (sp) - veja modelo no SQL da aula de hoje
-- criar uma transação explicita com seu PrimeiroNomeMatricula3
-- dentro desta transação fazer a operação de insert:

--4.1) Criar uma outra tabela com pelo menos 4 campos.
create table TBFabrica3139786 (
	IDFabrica					int not null primary key,
	NomeFabrica					varchar(50)	not null,
	TipoFabrica					varchar(15)	not null,
	Observacao					varchar(255),			
);

--4.2) Agora criar uma stored procedure (sp) para inserir registo na tabela criada
--(vide modelo feito em aula) e que tenha uma transação explicita dentro
create procedure SP_InsereFabrica3139786
(@IDFabrica int, @NomeFabrica varchar(50), @TipoFabrica varchar(15), @Observacao varchar(255))
as
begin
	--Iniciando a transação
	begin transaction Bruno31397863
		
		--Comando para realizar a inserção
		insert into TBFabrica3139786
		values (@IDFabrica, @NomeFabrica, @TipoFabrica, @Observacao)

		--Verificar se houve erro ou não na inserção
		if(@@ERROR = 0)
		begin
			--Gravar a inserção
			commit transaction Bruno31397863
		end
		else
		begin
			--remover a inserção
			rollback transaction Bruno31397863
		end
end
	
--4.2) executar a sp com a passagem de parâmentro e cadastrar 3 registros na tabela;
exec SP_InsereFabrica3139786 1001, 'Fabrica A', 'Tipo C', '';
exec SP_InsereFabrica3139786 1002, 'Fabrica B', 'Tipo A', '';
exec SP_InsereFabrica3139786 1003, 'Fabrica C', 'Tipo B', '';

--4.3) como foi utilizado uma transação explicita dentro da procedure (sp) - deve testar;
--4.4) Mostar com o comando select e a variável @@trancout que não tem transações abertas no BD;
select @@TRANCOUNT as [Quantidade de Transações Abertas]

--4.5) Mostrar com o Select que os registros foram gravados na tabela criada.
select * from TBFabrica3139786

--Exercício 5)
--5.1) criar uma sp (stored procedure) para alterar um registro cadastrado no Exercício 4)
create procedure SP_AlteraFabrica
(@IDFabrica int, @NomeFabrica varchar(50), @TipoFabrica varchar(15), @Observacao varchar(255))
as
begin
	--Iniciando a transação
	begin transaction T_AlteraFabrica

		--Realizando a alteração dos dados
		update TBFabrica3139786
		set NomeFabrica = @NomeFabrica, TipoFabrica = @TipoFabrica, Observacao = @Observacao
		where IDFabrica = @IDFabrica

		--Verificando se a alteração foi realizada com sucesso
		if(@@ERROR = 0)
		begin
			--Gravar as alterações realizadas
			commit transaction T_AlteraFabrica
		end
		else
		begin
			--Remover as alterações realizadas
			rollback transaction T_AlteraFabrica
		end
end

--5.2) executar a sp para pelos menos 1 registro e alterar um nome;
exec SP_AlteraFabrica 1002, 'Fabrica 2', 'TipoA', '';

--5.3) mostrar que o registro foi alterado (usar um select);
select * from TBFabrica3139786

--5.4) mostrar que todas as transações do SQL server estão fechadas
select @@TRANCOUNT as [Quantidade de Transações Abertas]