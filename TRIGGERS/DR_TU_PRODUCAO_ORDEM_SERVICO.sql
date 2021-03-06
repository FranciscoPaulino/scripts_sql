USE [DRLINGERIE]
GO
/****** Object:  Trigger [dbo].[DR_TU_PRODUCAO_ORDEM_SERVICO]    Script Date: 10/07/2017 14:58:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER trigger [dbo].[DR_TU_PRODUCAO_ORDEM_SERVICO] 
on [dbo].[PRODUCAO_ORDEM_SERVICO] 
for UPDATE NOT FOR REPLICATION 
as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @ORDEM_SERVICO char(8),
           @ORDEM_PRODUCAO char(8),
           @nf_saida char(15),
           @serie_nf char(6),
           @errno   int,
           @errmsg  varchar(255),
		   @DATA_OS datetime

  select @numrows = @@rowcount

  IF UPDATE(DATA)
  BEGIN
      SELECT @DATA_OS = DATA FROM INSERTED
	  IF CONVERT(CHAR(10),@DATA_OS,102) <> CONVERT(CHAR(10),GETDATE(),102)
	  BEGIN    
  		SELECT 	@ERRNO  = 30002,    
         		@ERRMSG = 'Impossível Atualizar #PRODUCAO_ORDEM_SERVICO# porque DATA da ORDEM DE SERVIÇO diferente do Sistema'    
  	    GOTO ERROR    
	  END
  END

 -- if 
	--update(NF_SAIDA) OR UPDATE(SERIE_NF)
 -- begin
	--select @nullcnt = 0
	
	--select @nf_saida=NF_SAIDA,@serie_nf=SERIE_NF 
	--from deleted
	
	--if (@nf_saida is not null and @nf_saida <> '')
 --   begin
	--	select @validcnt = count(*)
	--	FROM FATURAMENTO A WITH (NOLOCK)
	--	JOIN FATURAMENTO_ITEM B WITH (NOLOCK) ON B.NF_SAIDA=A.NF_SAIDA AND B.SERIE_NF=A.SERIE_NF AND B.FILIAL=A.FILIAL
	--	JOIN inserted C WITH (NOLOCK) ON C.NF_SAIDA=A.NF_SAIDA AND C.SERIE_NF=A.SERIE_NF
	--	JOIN PRODUCAO_OS_TAREFAS D WITH (NOLOCK) ON D.ORDEM_SERVICO=C.ORDEM_SERVICO
	--	WHERE EXISTS (SELECT A.ORDEM_PRODUCAO,A.TAREFA,MAX(A.ORDEM_SERVICO) 
	--				  FROM PRODUCAO_OS_TAREFAS A WITH (NOLOCK)
	--				  JOIN PRODUCAO_ORDEM B WITH (NOLOCK) ON B.ORDEM_PRODUCAO=A.ORDEM_PRODUCAO
	--	  			  WHERE A.ORDEM_PRODUCAO=D.ORDEM_PRODUCAO AND B.STATUS <> 'E' GROUP BY A.ORDEM_PRODUCAO,A.TAREFA 
	--	  			  HAVING MAX(A.ORDEM_SERVICO)>D.ORDEM_SERVICO AND A.TAREFA <> D.TAREFA)
	--	AND A.NF_SAIDA=C.NF_SAIDA 
	--	AND A.SERIE_NF=C.SERIE_NF 
	--	AND B.COD_TABELA_FILHA='O'

	--	select @ORDEM_SERVICO = C.ORDEM_SERVICO, @ORDEM_PRODUCAO = D.ORDEM_PRODUCAO
	--	FROM FATURAMENTO A WITH (NOLOCK)
	--	JOIN FATURAMENTO_ITEM B WITH (NOLOCK) ON B.NF_SAIDA=A.NF_SAIDA AND B.SERIE_NF=A.SERIE_NF AND B.FILIAL=A.FILIAL
	--	JOIN inserted C WITH (NOLOCK) ON C.NF_SAIDA=A.NF_SAIDA AND C.SERIE_NF=A.SERIE_NF
	--	JOIN PRODUCAO_OS_TAREFAS D WITH (NOLOCK) ON D.ORDEM_SERVICO=C.ORDEM_SERVICO
	--	WHERE EXISTS (SELECT A.ORDEM_PRODUCAO,A.TAREFA,MAX(A.ORDEM_SERVICO) 
	--				  FROM PRODUCAO_OS_TAREFAS A WITH (NOLOCK)
	--				  JOIN PRODUCAO_ORDEM B WITH (NOLOCK) ON B.ORDEM_PRODUCAO=A.ORDEM_PRODUCAO
	--	  			  WHERE A.ORDEM_PRODUCAO=D.ORDEM_PRODUCAO AND B.STATUS <> 'E' GROUP BY A.ORDEM_PRODUCAO,A.TAREFA 
	--	  			  HAVING MAX(A.ORDEM_SERVICO)>D.ORDEM_SERVICO AND A.TAREFA <> D.TAREFA)
	--	AND A.NF_SAIDA=C.NF_SAIDA 
	--	AND A.SERIE_NF=C.SERIE_NF 
	--	AND B.COD_TABELA_FILHA='O'

	--	if @validcnt > 0
	--	begin
	--	  select @errno  = 30002,
	--			 @errmsg = 'Impossível alterar PRODUÇÃO ORDEM SERVIÇO ('+RTRIM(@ORDEM_SERVICO)+') porque a ORDEM PRODUÇÃO ('+RTRIM(@ORDEM_PRODUCAO)+') já foi movimentada para próxima fase'
	--	  goto error
	--	end
	--end
 -- end

  return
error:
    raiserror @errno @errmsg
    rollback transaction
end