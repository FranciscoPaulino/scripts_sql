Text
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE trigger [dbo].[LDR_TI_VALIDA_MUNICIPO_IBGE] on [dbo].[CADASTRO_CLI_FOR] for INSERT NOT FOR REPLICATION as
BEGIN
  DECLARE @NULLCNT INT,
		  @VALIDCNT INT,
		  @NUMROWS INT,
		  @errno int,
		  @cep char(8),
		  @errmsg varchar(255)

  select @numrows = @@rowcount
/* */
  if 
     update(CEP) 
  begin
    select @nullcnt = 0
    select @cep = CEP
      from inserted

    if len(rtrim(@cep)) < 8
    begin
      select @errno  = 30002,
             @errmsg = 'Impossível Atualizar #CLIENTES_ATACADO #porque #CEP não está no formato correto'
      goto error
    end
  end

  if 
     update(CIDADE) OR update(UF)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,LCF_LX_MUNICIPIO,LCF_LX_UF
     where LCF_LX_MUNICIPIO.ID_UF=LCF_LX_UF.ID_UF AND
           RTRIM(inserted.CIDADE) = RTRIM(LCF_LX_MUNICIPIO.DESC_MUNICIPIO) AND
           inserted.UF = LCF_LX_UF.UF 

    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = 'Impossível Atualizar #CLIENTES_ATACADO #porque #MUNICIPIO_IBGE PRINCIPAL #não existe.'
      goto error
    end
  end
  if 
     update(COBRANCA_CIDADE) OR update(COBRANCA_UF)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,LCF_LX_MUNICIPIO,LCF_LX_UF
     where LCF_LX_MUNICIPIO.ID_UF=LCF_LX_UF.ID_UF AND
           RTRIM(inserted.COBRANCA_CIDADE) = RTRIM(LCF_LX_MUNICIPIO.DESC_MUNICIPIO) AND
           inserted.COBRANCA_UF = LCF_LX_UF.UF 
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = 'Impossível Atualizar #CLIENTES_ATACADO #porque #MUNICIPIO_IBGE COBRANÇA #não existe.'
      goto error
    end
  end

  if 
     update(ENTREGA_CIDADE) OR update(ENTREGA_UF)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,LCF_LX_MUNICIPIO,LCF_LX_UF
     where LCF_LX_MUNICIPIO.ID_UF=LCF_LX_UF.ID_UF AND
           RTRIM(inserted.ENTREGA_CIDADE) = RTRIM(LCF_LX_MUNICIPIO.DESC_MUNICIPIO) AND
           inserted.ENTREGA_UF = LCF_LX_UF.UF 
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30002,
             @errmsg = 'Impossível Atualizar #CLIENTES_ATACADO #porque #MUNICIPIO_IBGE ENTREGA #não existe.'
      goto error
    end
  end

  if 
     update(CGC_CPF)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,CADASTRO_CLI_FOR
     where CADASTRO_CLI_FOR.CGC_CPF=inserted.CGC_CPF and inserted.UF <> 'EX'
    
    if @validcnt > 1
    begin
      select @errno  = 30002,
             @errmsg = 'Impossível Incluir #CADASTRO_CLI_FOR #porque #CNPJ/CPF #Já existe.'
      goto error
    end
  end

  if 
     update(EMAIL) 
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted
     where dbo.Fun_Valida_Mail(LTRIM(RTRIM(inserted.EMAIL)))=0
    
    if @validcnt>0
    begin
      select @errno  = 30002,
             @errmsg = 'Impossível Atualizar #CADASTRO_CLI_FOR #porque #EMAIL #não foi definido corretamente.'
      goto error
    end
  end

--/* atualizar obs_de_faturamento com informações sobre endereço de entrega */
--	UPDATE 	CADASTRO_CLI_FOR 
--	SET 	OBS_DE_FATURAMENTO = 'LOCAL ENTREGA: '+RTRIM(INSERTED.ENTREGA_ENDERECO)+' CEP: '+INSERTED.ENTREGA_CEP
--	FROM 	CADASTRO_CLI_FOR, INSERTED
--	WHERE 	CADASTRO_CLI_FOR.NOME_CLIFOR = INSERTED.NOME_CLIFOR AND CADASTRO_CLI_FOR.ENDERECO<>INSERTED.ENTREGA_ENDERECO
--/*-----------------------------------------------------------------------------------------------------*/

/* atualizar o INDICADOR_FISCAL_TERCEIRO */
	UPDATE 	CADASTRO_CLI_FOR 
	SET 	INDICADOR_FISCAL_TERCEIRO=2
	FROM 	CADASTRO_CLI_FOR, INSERTED
	WHERE 	CADASTRO_CLI_FOR.NOME_CLIFOR = INSERTED.NOME_CLIFOR AND INSERTED.INDICADOR_FISCAL_TERCEIRO IS NULL
/*-----------------------------------------------------------------------------------------------------*/

/* atualizar o AGRUPAMENTO_ITENS */
	UPDATE 	CADASTRO_CLI_FOR 
	SET 	CADASTRO_CLI_FOR.AGRUPAMENTO_ITENS='2'
	FROM 	CADASTRO_CLI_FOR, INSERTED
	WHERE 	CADASTRO_CLI_FOR.NOME_CLIFOR = INSERTED.NOME_CLIFOR AND INSERTED.AGRUPAMENTO_ITENS <> '2' 
/*-----------------------------------------------------------------------------------------------------*/

/* atualizar o EMAIL_NFE */
	UPDATE 	CADASTRO_CLI_FOR 
	SET 	CADASTRO_CLI_FOR.EMAIL_NFE=CADASTRO_CLI_FOR.EMAIL
	FROM 	CADASTRO_CLI_FOR, INSERTED
	WHERE 	CADASTRO_CLI_FOR.NOME_CLIFOR = INSERTED.NOME_CLIFOR AND INSERTED.EMAIL_NFE IS NULL 
/*-----------------------------------------------------------------------------------------------------*/
	 UPDATE A  
	 SET EXPORTADO=1 
	 FROM CADASTRO_CLI_FOR A    
	 JOIN INSERTED X ON X.NOME_CLIFOR=A.NOME_CLIFOR
     WHERE A.NOME_CLIFOR = X.NOME_CLIFOR AND A.INDICA_CLIENTE=1
/*-----------------------------------------------------------------------------------------------------*/

  return
error:
    raiserror @errno @errmsg
    rollback transaction
END

