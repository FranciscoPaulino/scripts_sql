USE [DRVAREJO]
GO
/****** Object:  Trigger [dbo].[LDR_TI_PRODUCAO_ORDEM_COR]    Script Date: 02/05/2015 17:18:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER trigger [dbo].[LDR_TI_PRODUCAO_ORDEM_COR] 
on [dbo].[PRODUCAO_ORDEM_COR]
  for INSERT NOT FOR REPLICATION
  as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insORDEM_PRODUCAO char(8), 
           @insPRODUTO char(12), 
           @insCOR_PRODUTO char(10),
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
/* PRODUCAO_ORDEM R/1140 PRODUCAO_ORDEM_COR ON CHILD INSERT RESTRICT */
  if 
     update(ORDEM_PRODUCAO)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted, PRODUCAO_ORDEM, PRODUCAO_ORDEM_COR, PRODUCAO_TAREFAS
     where 
           PRODUCAO_TAREFAS.ORDEM_PRODUCAO = PRODUCAO_ORDEM.ORDEM_PRODUCAO and
           PRODUCAO_ORDEM_COR.PRODUTO=inserted.PRODUTO and
           PRODUCAO_ORDEM_COR.COR_PRODUTO = inserted.COR_PRODUTO and
           PRODUCAO_ORDEM.ORDEM_PRODUCAO = PRODUCAO_ORDEM_COR.ORDEM_PRODUCAO and
           DATEDIFF(DAY, PRODUCAO_ORDEM.EMISSAO, GETDATE())>30 and
           YEAR(GETDATE())>2014 and 
           PRODUCAO_ORDEM_COR.QTDE_P>0 and 
           PRODUCAO_TAREFAS.FASE_PRODUCAO='006'

    --- SELEÇÃO APENAS DA ORDEM DE PRODUÇÃO
    select @insORDEM_PRODUCAO=PRODUCAO_ORDEM_COR.ORDEM_PRODUCAO
      from inserted, PRODUCAO_ORDEM, PRODUCAO_ORDEM_COR, PRODUCAO_TAREFAS
     where 
           PRODUCAO_TAREFAS.ORDEM_PRODUCAO = PRODUCAO_ORDEM.ORDEM_PRODUCAO and
           PRODUCAO_ORDEM_COR.PRODUTO=inserted.PRODUTO and
           PRODUCAO_ORDEM_COR.COR_PRODUTO = inserted.COR_PRODUTO and
           PRODUCAO_ORDEM.ORDEM_PRODUCAO = PRODUCAO_ORDEM_COR.ORDEM_PRODUCAO and
           DATEDIFF(DAY, PRODUCAO_ORDEM.EMISSAO, GETDATE())>30 and
           YEAR(GETDATE())>2014 and 
           PRODUCAO_ORDEM_COR.QTDE_P>0 and 
           PRODUCAO_TAREFAS.FASE_PRODUCAO='006'
           
    if @validcnt > 0
    begin
      select @errno  = 30002,
             @errmsg = 'Impossível Incluir #PRODUCAO_ORDEM_COR #porque existe #ORDEM DE PRODUÇÃO# '+RTRIM(@insORDEM_PRODUCAO)+' aberta por mais de 30 dias.'
      goto error
    end
  end

  return
error:
    raiserror @errno @errmsg
    rollback transaction
end



    select * 
      from PRODUCAO_ORDEM, PRODUCAO_ORDEM_COR, PRODUCAO_TAREFAS 
     where PRODUCAO_TAREFAS.ORDEM_PRODUCAO=PRODUCAO_ORDEM.ORDEM_PRODUCAO AND
           PRODUCAO_TAREFAS.FASE_PRODUCAO='006' AND 
           PRODUCAO_ORDEM_COR.PRODUTO='51169' and
           PRODUCAO_ORDEM_COR.COR_PRODUTO = 'NT023' and
           PRODUCAO_ORDEM.ORDEM_PRODUCAO = PRODUCAO_ORDEM_COR.ORDEM_PRODUCAO and
           DATEDIFF(DAY, PRODUCAO_ORDEM.EMISSAO, GETDATE())>30 and 
           YEAR(GETDATE())>2014 and 
           PRODUCAO_ORDEM_COR.QTDE_P>0
           



SELECT * FROM PRODUCAO_TAREFAS
WHERE ORDEM_PRODUCAO='78776' and FASE_PRODUCAO='006'


DELETE FROM SAW_DEVOLUCAO_PA
WHERE ID_DEVOLUCAO IN (24)

DELETE FROM SAW_DEVOLUCAO_ITEM_PA
WHERE ID_DEVOLUCAO IN (24)



