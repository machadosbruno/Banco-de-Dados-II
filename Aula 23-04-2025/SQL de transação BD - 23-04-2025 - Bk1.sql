/*
------------------------------------
	Transa��es: � um lote de opera��es que "se tudo der certo" s�o gravadas e 
	encerra a transa��o;
	
	Caso ocorra algum erro (de software e/ou hardware) todo lote de opera��o ser� desfeito e n�o grava 
	nenhuma opera��o.
-------------------------------------
*/
-----------------------------------------------------------------------------
/* 
1) Exerc�cio 1
iniciar explicitamente uma transa��o
 
 Begin transaction NomeTransacao
  
 -- iniciado uma transa��o explicitamente, como se encerra a transa��o:
    commit transaction NomeTransacao   --> Grava tudo e encerra a transa��o
	rollback transaction NomeTransacao --> desfaz tudo e encerra a transa��o (n�o grava nada)

-- todas as opera��es no SQL Server, por padr�o, s�o executas implicitamente (na hora)
*/
-----------------------------------------------------------------------------------------------------------------

-- Exercio 2)
-- Como saber se ocorreu algum erro:
-- Consultar o c�digo do erro emitido pelo SQL Server
-- Exemplo:  fazer uma consulta no BD Vendas
use BDVendaIFSP -- foi executado com sucessp, logo n�o deu erro
-- vari�vel do SQL Server 2014 que acumula o c�digo erro do �ltimo comando "@@error"
-- se n�o houve erro @@error = 0
--use BDVendaIFSP100

select @@error as [C�digo do erro]

---------------------------------------------------------
-- novo teste
-- select numa tabela de Vendas
-- exerc�cio 3)
select  * 
from    clientes
----------------------------------------------

-- Exerc�cio 4)
-- mostrar um erro
-- simular uma divis�o por zero
select (50/0) as [Erro da divis�o por zero]

--------------------------------------------------------
-- for�ar outro erro
selectt * 
from clientes

-- transa��o bem sucedida
-- agora testar a variv�l @@trancount
Select @@trancount [Transa��es abertas]
---------------------------------------


-- Outra var�vel usada nas transa��es no SQL Server 2014
-- @@trancount mostra a quantidade de transa��es abertas explicitamente
-- o ideal � sempre @@trancount = 0 (sem trasnsa��o bertas)
-------------------------------------------------------------------------------
-- teste
select  @@trancount as [n�mero de transa��o aberta]
-------------------------------------------------------------------------------

/*
  Exerc�cio 2)
  Teste 1) fazer algumas opera��es dentro de uma transa��o explicita
  e no final fechar a transa��o explicita com rollback (desfaz tudo)
*/
------------------------------------------------------------------------------------
 --2.1)
 Begin transaction IFSP1
 --------------------------------
		 -- fazer algumas trasa��es (opera��es no BD)
		 insert into Pessoas
		 values		('Karlos Kosta', '123456', 1),
					('Mirtes Kosta', '456789', 1),
					('Joilson Frason', '159357', 1)
		 -------------------------------------------------------
		 -- consultar a tabela Pessoas
		 select * from Pessoas
		 -------------------------------------------------
		 -- alter o conte�do do cadastro
		 update Pessoas
		 set pes_nome = 'Maria das Dores Encarna��o'
		 where pes_codigo = 10
		 ------------------------------------------------------------
		 -- deletar (excluir) um registro
		 delete from Pessoas
		 where pes_codigo = 11
		 ------------------------------------------
-- fechar a transa��o com rollback
rollback transaction IFSP1
-------------------------------------------------------------]

-- checar se zerou as transa��es
select  @@trancount as [n�mero de transa��o aberta]
------------------------------------------------------------------------
-- tudo foi desfeito, n�o gravou nada
-- veja o Poder do rollback (desfazer) em uma transa��o

select * from Pessoas

----------------------------------------------------------------

/*
  -- Exerc�cio 3)
  -- Teste 2) fazer algumas opera��es dentro de uma transa��o explicita
      e no final fechar a transa��o explicita com "commit" (grava tudo)
*/
------------------------------------------------------------------------------------
 -- abre a transaction
 Begin transaction IFSP2
------ tudo fica denytro desta transa��o (ou esp�cie de guarda chuva) -----
		 -- 3.1)
		 -- fazer algumas trasa��es
		 insert into Pessoas
		 values		('Karlos Kosta', '123456', 1),
					('Mirtes Kosta', '456789', 1),
					('Joilson Frason', '159357', 1)
		 -------------------------------------------------------
		 -- consultar a tabela Pessoas
		 -- ver que os dados foram gravados
		 select * from Pessoas
		 -------------------------------------------------
		 
		 -- 3.2) fazer uma opera��o
		 -- alter o conte�do do cadastro
		 update Pessoas
		 set pes_nome = 'Maria das Dores Encarna��o'
		 where pes_codigo = 13
		 
		 -- 3.3) fazer outra opera��o
		 -- dar um select e checar que o Nome foi alterado na tabela Pessoas
		 Select   *
		 from     Pessoas
        -- condi��o
         where pes_codigo = 13	
		 ------------------------------------------------------------
		 
		 -- 3.4) fazer Outra opera��o
		 -- deletar (excluir) um registro
		 delete from Pessoas
		 where pes_codigo = 14
		 ------------------------------------------
		 
		 -- 3.4) ver com select que a pessoa 14 foi exclu�da
		 select   * 
		 from    Pessoas
		 where pes_codigo = 14
		 -- n�o existe mais a pessoa 14
		 
-- Agora: fechar a transa��o com rollback
Commit transaction IFSP2
-------------------------------------------------------------

------- agora testar se ficou transa��o aberto ------
-- checar se zerou as transa��es
select  @@trancount as [n�mero de transa��o aberta]
------------------------------------------------------------------------

-- tudo foi efetivado (gravado), Gravou todas as opera��es
select * from Pessoas
----------------------------------------------------------------

-- � recomendado usar transa��o dentro de Stored Procedure ou Trigger (gatilho).
-- Nestes casos o IF (commit/rollback) e o Else (commit/rollback)
-- sempre vai fechar a transa��o aberta
--------------------------------------------------------------------

-- Exemplificando
/*
 -- exerc�cio 4)
 Criando uma Stored Procedure (sp) com transa��o explicita para inserir registros
 na tabela de Pessoas
*/

------------------------------------------------
-- testes
--4.1) verificar tem transa��o aberta
Select  @@trancount as [n�mero de transa��o aberta]
-- tem que retornar 0 (nenhuma transa��o aberta)

-----------------------------------------------------------------------
-- 4.2) verificar se n�o ocorreu erro
-- lembrar @@error armazena o erro a �ltima opera��o feita
select @@error  as [C�digo erro]
-- retorno 0 =  n�o tem erro na �ltima opera��o

-------- a vari�fel @@IDENTITY  -----------------------------------
-- @@IDENTITY ARMAZENA O �LTIMO C�DIGO INSERIDO
-- criar a sp com trabsa��o inbutida
Create Procedure SP_CadastraPessoa
( @nome varchar(50), @cpf varchar(12), @status int )
AS
BEGIN
        -- EXPLICITAR A TRANSA��O
		BEGIN TRANSACTION IFSP5
		-- FAZ A INSER��O
		insert into Pessoas
		values   (@nome, @cpf, @status )
		--------------- notar que a �ltima opera��o foi um insert -----------
		-- VERIFICAR SE "@@ERROR" ACUMULOU ERRO OU N�O
		IF (@@ERROR = 0) -- N�O OCORREU ERRO (tudo deu certo, ent�o gravo)
		     Begin
				-- como n�o ocrreu erro, fecho a transa��o e gravo
				Commit transaction  IFSP5
			 End
		ELSE
		-- mas pode ter ocorrido um erro
		-- exemplo caiu a rede, queimou o HD e n�o pode fazer a opera��o
			Begin
			     -- se passar pelo Else � que ocorreu algum
				 -- para fechar a transa��o se ocorrer algum erro
				Rollback transaction  IFSP5				  
			End
		------ MOSTRA PARA USU�RIO QUE FOI CADATRADO o registro ----------
		SELECT 	* 
		FROM 	Pessoas 
		WHERE  	pes_codigo = @@IDENTITY  -- aqui lista o �ltimo registro da tabela
END

----------  vamos testar a sp criada -----------------------
-- executar testa na procedure
-- passar tr�s (3) parametros para serem cadastrados na tabela Pessoa 
-- cadastrar duas (2) Pessoas
Exec SP_CadastraPessoa 'Maria Consei��o das Alagoas', '987654', 1;

Exec SP_CadastraPessoa 'Jarbas Passarinto', '5555555555', 1

---------------- agora vamos tetar se a transa��o foi fechada pela sp --------- 
-- o que tem que checar
Select  @@trancount as [n�mero de transa��o aberta]
-- tem que dar 0 (nenhuma transa��o aberta)

----------------------------------------------------------- 
-- o tem que se certificar que n�o tem transa��o aberta
-- ap�s a execua��o da procedure
------------------------------------------------------------- 