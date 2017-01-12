--- FUNCTION MEDIA_TEMPO_CRONOMETRADO_PROCESSO

CREATE FUNCTION [dbo].[MEDIA_TEMPO_CRONOMETRADO_PROCESSO] (@RECURSO_PRODUTIVO varchar(MAX))          
RETURNS int          
WITH EXECUTE AS CALLER          
AS          
BEGIN          
     DECLARE @Retorno int          
    
     SET @Retorno =  
        (
			SELECT SUM(PRODUTOS_TAB_OPERACOES.TEMPO_TOTAL*PRODUCAO_TAREFAS.QTDE_EM_PROCESSO)/SUM(PRODUCAO_TAREFAS.QTDE_EM_PROCESSO) 
			FROM dbo.PRODUCAO_FASE PRODUCAO_FASE with (nolock), 
			dbo.PRODUCAO_RECURSOS PRODUCAO_RECURSOS with (nolock), 
			dbo.PRODUCAO_SETOR PRODUCAO_SETOR with (nolock), 
			dbo.PRODUCAO_TAREFAS PRODUCAO_TAREFAS with (nolock), 
			dbo.PRODUTOS PRODUTOS with (nolock), 
			dbo.PRODUCAO_ORDEM with (nolock),
			dbo.PRODUTOS_TAB_OPERACOES with (nolock)
			WHERE PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
			PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO AND 
			PRODUCAO_RECURSOS.RECURSO_PRODUTIVO = PRODUCAO_TAREFAS.RECURSO_PRODUTIVO AND 
			PRODUCAO_SETOR.SETOR_PRODUCAO = PRODUCAO_TAREFAS.SETOR_PRODUCAO AND 
			PRODUCAO_SETOR.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
			PRODUCAO_ORDEM.PRODUTO=PRODUTOS.PRODUTO AND
			PRODUCAO_ORDEM.ORDEM_PRODUCAO=PRODUCAO_TAREFAS.ORDEM_PRODUCAO AND
			PRODUTOS_TAB_OPERACOES.TABELA_OPERACOES=PRODUCAO_ORDEM.PRODUTO AND
			PRODUCAO_FASE.FASE_PRODUCAO IN('60','61') AND PRODUCAO_ORDEM.FILIAL='D.R. LINGERIE'
			AND PRODUCAO_RECURSOS.RECURSO_PRODUTIVO=RTRIM(@RECURSO_PRODUTIVO) AND PRODUCAO_TAREFAS.QTDE_EM_PROCESSO>0 
	)
			  
     RETURN(@Retorno)          
END;           

