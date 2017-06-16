create trigger [dbo].[DR_TI_ESTOQUE_RET1_MAT] 
on [dbo].[ESTOQUE_RET1_MAT]
  for INSERT NOT FOR REPLICATION
  as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @condicao_pgto_forn char(3),
		   @condicao_pgto_pedido char(3),
		   @cod_tabela_filha CHAR(1),
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount

  if 
     update(PEDIDO)  
  begin
    select @condicao_pgto_forn = RTRIM(C.CONDICAO_PGTO),@condicao_pgto_pedido = RTRIM(F.CONDICAO_PGTO),@cod_tabela_filha = D.COD_TABELA_FILHA
	FROM inserted A
	JOIN ESTOQUE_RET_MAT B ON B.REQ_MATERIAL=A.REQ_MATERIAL
	JOIN ENTRADAS C ON C.NF_ENTRADA=B.NF_ENTRADA AND C.SERIE_NF_ENTRADA=B.SERIE_NF_ENTRADA AND C.NOME_CLIFOR=B.NOME_CLIFOR AND C.FILIAL=B.FILIAL
	JOIN ENTRADAS_ITEM D ON D.NF_ENTRADA=B.NF_ENTRADA AND D.SERIE_NF_ENTRADA=B.SERIE_NF_ENTRADA AND D.ITEM_IMPRESSAO=A.ITEM_IMPRESSAO AND D.REFERENCIA=A.MATERIAL
	JOIN COMPRAS F ON F.PEDIDO=A.PEDIDO
	WHERE B.NF_ENTRADA=C.NF_ENTRADA AND 
	      B.SERIE_NF_ENTRADA=C.SERIE_NF_ENTRADA AND 
		  B.NOME_CLIFOR=C.NOME_CLIFOR AND
          A.MATERIAL=D.CODIGO_ITEM AND 
		  A.ITEM_IMPRESSAO=D.ITEM_IMPRESSAO

    if (@condicao_pgto_forn != @condicao_pgto_pedido) AND @cod_tabela_filha = 'M'
    begin
      select @errno  = 30002,
             @errmsg = 'Impossí­vel Incluir #ESTOQUE_RET1_MAT #porque #Condição de Pagamento# está diferente do #PEDIDO de COMPRA#, verifique'
      goto error
    end
  end

  return
error:
    raiserror (@errmsg, 16, 1)
    rollback transaction
end


