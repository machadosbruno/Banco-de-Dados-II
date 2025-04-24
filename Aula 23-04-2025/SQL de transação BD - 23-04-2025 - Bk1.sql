/*
------------------------------------
	Transações: é um lote de operações que "se tudo der certo" são gravadas e 
	encerra a transação;
	
	Caso ocorra algum erro (de software e/ou hardware) todo lote de operação será desfeito e não grava 
	nenhuma operação.
-------------------------------------
*/
-----------------------------------------------------------------------------
/* 
1) Exercício 1
iniciar explicitamente uma transação
 
 Begin transaction NomeTransacao
  
 -- iniciado uma transação explicitamente, como se encerra a transação:
    commit transaction NomeTransacao   --> Grava tudo e encerra a transação
	rollback transaction NomeTransacao --> desfaz tudo e encerra a transação (não grava nada)

-- todas as operações no SQL Server, por padrão, são executas implicitamente (na hora)
*/
-----------------------------------------------------------------------------------------------------------------

-- Exercio 2)
-- Como saber se ocorreu algum erro:
-- Consultar o código do erro emitido pelo SQL Server
-- Exemplo:  fazer uma consulta no BD Vendas
use BDVendaIFSP -- foi executado com sucessp, logo não deu erro
-- variável do SQL Server 2014 que acumula o código erro do último comando "@@error"
-- se não houve erro @@error = 0
--use BDVendaIFSP100

select @@error as [Código do erro]

---------------------------------------------------------
-- novo teste
-- select numa tabela de Vendas
-- exercício 3)
select  * 
from    clientes
----------------------------------------------

-- Exercício 4)
-- mostrar um erro
-- simular uma divisão por zero
select (50/0) as [Erro da divisão por zero]

--------------------------------------------------------
-- forçar outro erro
selectt * 
from clientes

-- transação bem sucedida
-- agora testar a varivél @@trancount
Select @@trancount [Transações abertas]
---------------------------------------


-- Outra varável usada nas transações no SQL Server 2014
-- @@trancount mostra a quantidade de transações abertas explicitamente
-- o ideal é sempre @@trancount = 0 (sem trasnsação bertas)
-------------------------------------------------------------------------------
-- teste
select  @@trancount as [número de transação aberta]
-------------------------------------------------------------------------------

/*
  Exercício 2)
  Teste 1) fazer algumas operações dentro de uma transação explicita
  e no final fechar a transação explicita com rollback (desfaz tudo)
*/
------------------------------------------------------------------------------------
 --2.1)
 Begin transaction IFSP1
 --------------------------------
		 -- fazer algumas trasações (operações no BD)
		 insert into Pessoas
		 values		('Karlos Kosta', '123456', 1),
					('Mirtes Kosta', '456789', 1),
					('Joilson Frason', '159357', 1)
		 -------------------------------------------------------
		 -- consultar a tabela Pessoas
		 select * from Pessoas
		 -------------------------------------------------
		 -- alter o conteúdo do cadastro
		 update Pessoas
		 set pes_nome = 'Maria das Dores Encarnação'
		 where pes_codigo = 10
		 ------------------------------------------------------------
		 -- deletar (excluir) um registro
		 delete from Pessoas
		 where pes_codigo = 11
		 ------------------------------------------
-- fechar a transação com rollback
rollback transaction IFSP1
-------------------------------------------------------------]

-- checar se zerou as transações
select  @@trancount as [número de transação aberta]
------------------------------------------------------------------------
-- tudo foi desfeito, não gravou nada
-- veja o Poder do rollback (desfazer) em uma transação

select * from Pessoas

----------------------------------------------------------------

/*
  -- Exercício 3)
  -- Teste 2) fazer algumas operações dentro de uma transação explicita
      e no final fechar a transação explicita com "commit" (grava tudo)
*/
------------------------------------------------------------------------------------
 -- abre a transaction
 Begin transaction IFSP2
------ tudo fica denytro desta transação (ou espécie de guarda chuva) -----
		 -- 3.1)
		 -- fazer algumas trasações
		 insert into Pessoas
		 values		('Karlos Kosta', '123456', 1),
					('Mirtes Kosta', '456789', 1),
					('Joilson Frason', '159357', 1)
		 -------------------------------------------------------
		 -- consultar a tabela Pessoas
		 -- ver que os dados foram gravados
		 select * from Pessoas
		 -------------------------------------------------
		 
		 -- 3.2) fazer uma operação
		 -- alter o conteúdo do cadastro
		 update Pessoas
		 set pes_nome = 'Maria das Dores Encarnação'
		 where pes_codigo = 13
		 
		 -- 3.3) fazer outra operação
		 -- dar um select e checar que o Nome foi alterado na tabela Pessoas
		 Select   *
		 from     Pessoas
        -- condição
         where pes_codigo = 13	
		 ------------------------------------------------------------
		 
		 -- 3.4) fazer Outra operação
		 -- deletar (excluir) um registro
		 delete from Pessoas
		 where pes_codigo = 14
		 ------------------------------------------
		 
		 -- 3.4) ver com select que a pessoa 14 foi excluída
		 select   * 
		 from    Pessoas
		 where pes_codigo = 14
		 -- não existe mais a pessoa 14
		 
-- Agora: fechar a transação com rollback
Commit transaction IFSP2
-------------------------------------------------------------

------- agora testar se ficou transação aberto ------
-- checar se zerou as transações
select  @@trancount as [número de transação aberta]
------------------------------------------------------------------------

-- tudo foi efetivado (gravado), Gravou todas as operações
select * from Pessoas
----------------------------------------------------------------

-- é recomendado usar transação dentro de Stored Procedure ou Trigger (gatilho).
-- Nestes casos o IF (commit/rollback) e o Else (commit/rollback)
-- sempre vai fechar a transação aberta
--------------------------------------------------------------------

-- Exemplificando
/*
 -- exercício 4)
 Criando uma Stored Procedure (sp) com transação explicita para inserir registros
 na tabela de Pessoas
*/

------------------------------------------------
-- testes
--4.1) verificar tem transação aberta
Select  @@trancount as [número de transação aberta]
-- tem que retornar 0 (nenhuma transação aberta)

-----------------------------------------------------------------------
-- 4.2) verificar se não ocorreu erro
-- lembrar @@error armazena o erro a última operação feita
select @@error  as [Código erro]
-- retorno 0 =  não tem erro na última operação

-------- a variáfel @@IDENTITY  -----------------------------------
-- @@IDENTITY ARMAZENA O ÚLTIMO CÓDIGO INSERIDO
-- criar a sp com trabsação inbutida
Create Procedure SP_CadastraPessoa
( @nome varchar(50), @cpf varchar(12), @status int )
AS
BEGIN
        -- EXPLICITAR A TRANSAÇÃO
		BEGIN TRANSACTION IFSP5
		-- FAZ A INSERÇÃO
		insert into Pessoas
		values   (@nome, @cpf, @status )
		--------------- notar que a última operação foi um insert -----------
		-- VERIFICAR SE "@@ERROR" ACUMULOU ERRO OU NÃO
		IF (@@ERROR = 0) -- NÃO OCORREU ERRO (tudo deu certo, então gravo)
		     Begin
				-- como não ocrreu erro, fecho a transação e gravo
				Commit transaction  IFSP5
			 End
		ELSE
		-- mas pode ter ocorrido um erro
		-- exemplo caiu a rede, queimou o HD e não pode fazer a operação
			Begin
			     -- se passar pelo Else é que ocorreu algum
				 -- para fechar a transação se ocorrer algum erro
				Rollback transaction  IFSP5				  
			End
		------ MOSTRA PARA USUÁRIO QUE FOI CADATRADO o registro ----------
		SELECT 	* 
		FROM 	Pessoas 
		WHERE  	pes_codigo = @@IDENTITY  -- aqui lista o último registro da tabela
END

----------  vamos testar a sp criada -----------------------
-- executar testa na procedure
-- passar três (3) parametros para serem cadastrados na tabela Pessoa 
-- cadastrar duas (2) Pessoas
Exec SP_CadastraPessoa 'Maria Conseição das Alagoas', '987654', 1;

Exec SP_CadastraPessoa 'Jarbas Passarinto', '5555555555', 1

---------------- agora vamos tetar se a transação foi fechada pela sp --------- 
-- o que tem que checar
Select  @@trancount as [número de transação aberta]
-- tem que dar 0 (nenhuma transação aberta)

----------------------------------------------------------- 
-- o tem que se certificar que não tem transação aberta
-- após a execuação da procedure
------------------------------------------------------------- 