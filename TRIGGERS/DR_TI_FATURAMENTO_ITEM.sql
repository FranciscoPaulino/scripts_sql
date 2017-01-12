USE [DRLINGERIE]
GO
/****** Object:  Trigger [dbo].[DR_TI_FATURAMENTO_ITEM]    Script Date: 10/07/2015 08:17:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE trigger [dbo].[DR_TI_FATURAMENTO_ITEM] 
on [dbo].[FATURAMENTO_ITEM] 
for INSERT NOT FOR REPLICATION 
as
/* INSERT trigger on FATURAMENTO_ITEM */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insFILIAL varchar(25), 
           @insNF_SAIDA char(15), 
           @insSERIE_NF char(6), --#1# 
           @insITEM_IMPRESSAO char(4), 
           @insSUB_ITEM_TAMANHO int,
           @errno   int,
           @errmsg  varchar(255),
           @fantasia_cliente int


  select @numrows = @@rowcount

  /* CTB_CONTA_PLANO R/3 FATURAMENTO_ITEM ON CHILD INSERT RESTRICT */
  
  	select @fantasia_cliente = COUNT(*)
	from  FATURAMENTO_ITEM,FATURAMENTO,CLIENTES_ATACADO,inserted
	where FATURAMENTO_ITEM.NF_SAIDA  = FATURAMENTO.NF_SAIDA and 
		  FATURAMENTO_ITEM.SERIE_NF  = FATURAMENTO.SERIE_NF and
		  FATURAMENTO_ITEM.FILIAL    = FATURAMENTO.FILIAL and
		  FATURAMENTO.NOME_CLIFOR    = CLIENTES_ATACADO.CLIENTE_ATACADO AND
		  inserted.NF_SAIDA          = FATURAMENTO_ITEM.NF_SAIDA AND 
		  inserted.SERIE_NF          = FATURAMENTO_ITEM.SERIE_NF AND
		  CLIENTES_ATACADO.CLIENTE_ATACADO LIKE '%RENNER%'
      
  IF @fantasia_cliente > 0
      BEGIN 
	  --- ADICIONA O CÓDIGO DO CLIENTE NA DESCRIÇÃO DO ITEM
	   	  UPDATE A
		  SET A.DESCRICAO_ITEM=RTRIM(B.CODIGO_BARRA)+' - '+RTRIM(A.DESCRICAO_ITEM)
		  FROM FATURAMENTO_ITEM A
		  JOIN PRODUTOS_BARRA B ON RTRIM(B.PRODUTO)+RTRIM(B.COR_PRODUTO)+RTRIM(B.GRADE)=A.CODIGO_ITEM
		  JOIN inserted C ON C.NF_SAIDA=A.NF_SAIDA AND C.SERIE_NF=A.SERIE_NF AND C.FILIAL=A.FILIAL
		  WHERE RTRIM(B.PRODUTO)+RTRIM(B.COR_PRODUTO)+RTRIM(B.GRADE) = C.CODIGO_ITEM AND 
		  A.NF_SAIDA=C.NF_SAIDA AND CODIGO_BARRA_PADRAO=0 AND B.NOME_CLIFOR LIKE '%RENNER%'	
	  ---
	  END

  return
error:
    raiserror (@errmsg, 16, 1)
    rollback transaction
end