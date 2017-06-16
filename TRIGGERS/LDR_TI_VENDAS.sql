CREATE trigger [dbo].[LDR_TI_VENDAS] 
on [dbo].[VENDAS]
  for INSERT NOT FOR REPLICATION
  as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPEDIDO char(12),
           @errno   int,
           @errmsg  varchar(255)
           
  select @insPEDIDO = PEDIDO from inserted         
/*----------------------------------------------------------------------------------------------------------------*/
	INSERT INTO SAW_CADASTRO_PEDIDO_ENVIO_EMAIL (PEDIDO,ENVIADO,EMAIL_DATA_ENVIO)
	SELECT INSERTED.PEDIDO,0,NULL FROM VENDAS, inserted WHERE VENDAS.PEDIDO=inserted.PEDIDO AND VENDAS.TABELA_FILHA='VENDAS_PRODUTO' AND VENDAS.FILIAL='DR VAREJO'
/*-----------------------------------------------------------------------------
-----------------------------------*/
    IF UPDATE(PERIODO_PCP) OR UPDATE(NUMERO_ENTREGA) --OR UPDATE(TOT_QTDE_ORIGINAL)
       IF(SELECT COUNT(*) FROM COTA_LIMITE_PERFAT, inserted  WHERE COTA_LIMITE_PERFAT.NUMERO_ENTREGA=inserted.NUMERO_ENTREGA AND
                   COTA_LIMITE_PERFAT.PERIODO_PCP=inserted.PERIODO_PCP AND 
                   (COTA_LIMITE_PERFAT.FECHADO=1 OR COTA_LIMITE_PERFAT.QTDE_LIMITE<
                   (SELECT QTDE_ORIGINAL=CAST(SUM(A.TOT_QTDE_ORIGINAL) AS INT) 
					FROM VENDAS A WITH (NOLOCK)
					WHERE A.FILIAL='DR VAREJO' AND A.PERIODO_PCP=inserted.PERIODO_PCP AND A.NUMERO_ENTREGA=inserted.NUMERO_ENTREGA))) > 0
         EXEC SP_PEDIDO_PERFAT_FECHADO_ENVIAR_EMAIL_PCP @insPEDIDO
/*-------------------------------------------
---------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------------------------------------*/
	DECLARE @LXUSUARIO				 VARCHAR(25) 
	SELECT @LXUSUARIO = USUARIO
 FROM USERS WHERE LX_SYSTEM_USER = SYSTEM_USER
	INSERT INTO VENDAS_STATUS_LOG (PEDIDO,STATUS,DATA_ALTERACAO_STATUS,USUARIO)
	SELECT	INSERTED.PEDIDO,INSERTED.APROVACAO,GETDATE(),@LXUSUARIO
	FROM	INSERTED 
/*-------------------------------------------------
---------------------------------------------------------------*/

  -- trocar tipo dos pedidos da Lojas Americanas
  IF UPDATE(TIPO)
  BEGIN
     update b
	 set b.TIPO='GO LIBERADO'  
  	 from vendas b
	 where b.pedido=@insPEDIDO and b.CLIENTE_ATACADO like '%LOJAS AMERICANAS%' and b.FILIAL='D.R. LINGERIE'
  END
  
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end


