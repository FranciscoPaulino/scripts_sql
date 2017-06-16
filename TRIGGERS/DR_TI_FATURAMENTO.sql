CREATE trigger [dbo].[DR_TI_FATURAMENTO] 
on [dbo].[FATURAMENTO]
  for INSERT NOT FOR REPLICATION
  as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @errno   int,
           @errmsg  varchar(255),
		   @numeroParcelas int,
           @tot_valor_liquido numeric(14,2),
		   @data_faturamento_relativo datetime,
		   @emissao datetime,
		   @peso_bruto numeric(9,3),
		   @peso_liquido numeric(9,3),
           @valor_minimo_parcela_vendas int,
           @valor_minimo_parcela_mostruario int,
           @conta_contabil_cliente varchar(20),
           @conta_contabil_rep varchar(20),
           @filial varchar(25)               

  select @numrows = @@rowcount
  
  --/* Verifica  */
  --if 
  --   update(PESO_BRUTO) or 
  --   update(PESO_LIQUIDO) 
  --begin
  --  select @nullcnt = 0
  --  select @peso_bruto=PESO_BRUTO,@peso_liquido=PESO_LIQUIDO
  --    from inserted

  --  if (isnull(@peso_bruto,0)+isnull(@peso_liquido,0)) = 0 
  --  begin
  --    select @errno  = 30002,
  --           @errmsg = 'Impossível Incluir #FATURAMENTO# porque #PESO_BRUTO# ou #PESO_LÍQUIDO# não foi informado'
  --    goto error
  --  end
  --end
  
  /* Verifica limite para d
ata_faturamento_relativo */
  if UPDATE(DATA_FATURAMENTO_RELATIVO)
  begin   
	  select @data_faturamento_relativo=DATA_FATURAMENTO_RELATIVO,@emissao=EMISSAO,@filial=RTRIM(FILIAL)
	  from inserted

	  if @filial = 'DR VAREJO'
	  begin
	      if (datediff(dd,@emissao,@data_faturamento_relativo) > 35)
		  begin
			  select @errno  = 30002,
		             @errmsg = 'Impossível Incluir #FATURAMENTO# porque a #DATA_FATURAMENTO_RELATIVO# é maior que valor máximo permitido (35) Dias'
			  goto error		      
		  end
      end
	  else
	  begin
		  if (datediff(dd,@emissao,@data_faturamento_relativo) > 35)
		  begin
			  select @errno  = 30002,
		  	         @errmsg = 'Impossível Incluir #FATURAMENTO# porque a #DATA_FATURAMENTO_RELATIVO# é maior que valor máximo permitido (35) Dias'
			  goto error		      
		  end
	  end
  end
  /* Fim */

  /* verifica a filial de faturamento */
  select @filial=ltrim(rtrim(inserted.filial)) 
  from inserted 
  
  if (@filial) = 'DR VAREJO'
  BEGIN  
	  /* Verifica limite de parcela da condição de pagamento*/
	  if UPDATE(CONDICAO_PGTO) --AND SUSER_NAME() NOT IN ('MILTON')
	  BEGIN   
		 -- Busca números de parcelas e valor líquido do pedido
		 SELECT @numeroParcelas=A.NUMERO_PARCELAS,@tot_valor_liquido=(B.MPADRAO_VALOR_TOTAL) 
		 FROM FORMA_PGTO A 
		 JOIN inserted B ON B.CONDICAO_PGTO=A.CONDICAO_PGTO
		 WHERE (A.TIPO_CONDICAO<>'VISTA') AND (LTRIM(RTRIM(A.DESC_COND_PGTO)) <> 'CUSTOMIZADA')
	     
		 -- Busca conta contabil do cliente em faturamento
		 SELECT @conta_contabil_cliente = RTRIM(A.CTB_CONTA_CONTABIL)
		 FROM CLIENTES_ATACADO A
		 JOIN inserted B ON B.NOME_CLIFOR=A.CLIENTE_ATACADO
		 WHERE B.NOME_CLIFOR=A.CLIENTE_ATACADO

		 -- Busca conta contabil do representante de vendas
		 SELECT @conta_contabil_rep = LTRIM(RTRIM(VALOR_ATUAL))
		 FROM PARAMETROS 
		 WHERE PARAMETRO='CONTA_CONTABIL_REP'
	 
		 -- Busca valor mínimo de parcela vendas
		 SELECT @valor_minimo_parcela_vendas = VALOR_ATUAL 
		 FROM PARAMETROS 
		 WHERE PARAMETRO='VLR_MINIMO_PARCELA_VENDAS'
	     
		 -- Busca valor mínimo de parcela mostruário
		 SELECT @valor_minimo_parcela_mostruario = VALOR_ATUAL 
		 FROM PARAMETROS 
		 WHERE PARAMETRO='VLR_MINIMO_PARCELA_MOSTRU'
	     
		 -- Verifica conta do representante x cliente
		 if (ltrim(rtrim(@conta_contabil_rep))=ltrim(rtrim(@conta_contabil_cliente)))
		 BEGIN
		     if @valor_minimo_parcela_mostruario>0
			 begin
				 if (@tot_valor_liquido / @numeroParcelas) < @valor_minimo_parcela_mostruario
				 BEGIN
				  select @errno  = 30002,
						 @errmsg = 'Impossível Incluir #FATURAMENTO# porque o #VALOR DA PARCELA#('+RTRIM(CAST(CAST((@tot_valor_liquido / @numeroParcelas) AS numeric(14,2)) AS CHAR(20)))+') é menor que valor mínimo permitido ('+RTRIM(CAST(@valor_minimo_parcela_mostruario as char(20)))+')'
				  goto error
				 END  
			 end
		 END
		 ELSE
		 BEGIN
		     --- modificado para evitar mudança do valor minimo da parcela ou seja,
			 --- se for uma parcela não verifica o valor minimo da parcela
		     if (@valor_minimo_parcela_vendas>0 and @numeroParcelas > 1)
			 begin
				 if (@tot_valor_liquido / @numeroParcelas) < @valor_minimo_parcela_vendas
				 BEGIN
				  select @errno  = 30002,
						 @errmsg = 'Impossível Incluir #FATURAMENTO# porque o #VALOR DA PARCELA#('+RTRIM(CAST(CAST((@tot_valor_liquido / @numeroParcelas) AS numeric(14,2)) AS CHAR(20)))+') é menor que valor mínimo permitido ('+RTRIM(CAST(@valor_minimo_parcela_vendas as char(20)))+')'
				  goto error
				 END  
			 end   
		 END
	  END
	  /* Fim */  
  END
return
error:
    raiserror (@errmsg, 16, 1)
    rollback transaction
end

