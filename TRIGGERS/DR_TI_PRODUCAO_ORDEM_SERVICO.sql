USE [drlingerie]
GO
/****** Object:  Trigger [dbo].[DR_TI_PRODUCAO_ORDEM_SERVICO]    Script Date: 10/07/2017 14:44:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER trigger [dbo].[DR_TI_PRODUCAO_ORDEM_SERVICO] 
on [dbo].[PRODUCAO_ORDEM_SERVICO] 
for INSERT NOT FOR REPLICATION 
as

begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insORDEM_SERVICO char(8),
           @delORDEM_SERVICO char(8),
           @errno   int,
           @errmsg  varchar(255),
		   @DATA_OS datetime
  
  IF UPDATE(DATA)
  BEGIN
      SELECT @DATA_OS = DATA FROM INSERTED
	  IF CONVERT(CHAR(10),@DATA_OS,102) <> CONVERT(CHAR(10),GETDATE(),102)
	  BEGIN    
  		SELECT 	@ERRNO  = 30002,    
         		@ERRMSG = 'Impossível incluir #PRODUCAO_ORDEM_SERVICO# porque DATA da ORDEM DE SERVIÇO diferente do Sistema'    
  	    GOTO ERROR    
	  END
	  -- INCLUIR ORDEM_SERVICO E DATA_HORA NA TABELA PARA CONTROLAR O MOVIMENTO DA PRODUÇÃO POR HORA
	  INSERT INTO PRODUCAO_ORDEM_SERVICO_HORARIA (ORDEM_SERVICO,DATA_HORA) 
	  SELECT inserted.ORDEM_SERVICO,GETDATE() FROM PRODUCAO_ORDEM_SERVICO, inserted
	  WHERE PRODUCAO_ORDEM_SERVICO.ORDEM_SERVICO = INSERTED.ORDEM_SERVICO
  END

  return
error:
    raiserror @errno @errmsg
    rollback transaction
end
