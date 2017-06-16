CREATE trigger [dbo].[DR_TI_PRODUCAO_ORDEM_SERVICO] 
on [dbo].[PRODUCAO_ORDEM_SERVICO] 
for INSERT NOT FOR REPLICATION 
as
/* UPDATE trigger on PRODUCAO_ORDEM_SERVICO */
--
-- 15/10/2004 - SZALONTAI - ADAPTACAO DO PROCESSO DE ATUALIZACAO DAS DATAS DE INICIO E FIM LIBERADO
--

begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insORDEM_SERVICO char(8),
           @delORDEM_SERVICO char(8),
           @errno   int,
           @errmsg  varchar(255)
  
  -- INCLUIR ORDEM_SERVICO E DATA_HORA NA TABELA PARA CONTROLAR O MOVIMENTO DA PRODUÇÃO POR HORA
  INSERT INTO PRODUCAO_ORDEM_SERVICO_HORARIA (ORDEM_SERVICO,DATA_HORA) 
  SELECT inserted.ORDEM_SERVICO,GETDATE() FROM PRODUCAO_ORDEM_SERVICO, inserted
  WHERE PRODUCAO_ORDEM_SERVICO.ORDEM_SERVICO = INSERTED.ORDEM_SERVICO
   
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end

