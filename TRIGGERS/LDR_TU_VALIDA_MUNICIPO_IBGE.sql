CREATE trigger [dbo].[LDR_TU_VALIDA_MUNICIPO_IBGE] on [dbo].[CADASTRO_CLI_FOR] for UPDATE NOT FOR REPLICATION as
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
     update(EMAIL) OR update(EMAIL_NFE)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted
     where (dbo.Fun_Valida_Mail(LTRIM(RTRIM(inserted.EMAIL)))=0 OR dbo.Fun_Valida_Mail(LTRIM(RTRIM(inserted.EMAIL_NFE)))=0)
    
    if @validcnt>0
    begin
      select @errno  = 30002,
             @errmsg = 'Impossível Atualizar #CADASTRO_CLI_FOR #porque #EMAIL #não foi definido corretamente.'
      goto error
    end
  end

  if 
     update(CADASTRAMENTO)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,CADASTRO_CLI_FOR
     where inserted.CLIFOR=CADASTRO_CLI_FOR.CLIFOR
    
    if @validcnt + @nullcnt = @numrows
    begin
      select @errno  = 30002,
             @errmsg = 'Impossível Atualizar #CADASTRO_CLI_FOR #porque data #CADASTRAMENTO #já existe.'
      goto error
    end
  end
  

  if 
     update(AGRUPAMENTO_ITENS)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,CADASTRO_CLI_FOR
     where inserted.CLIFOR=CADASTRO_CLI_FOR.CLIFOR AND inserted.AGRUPAMENTO_ITENS <> '2'
    
    if @validcnt > 0 
    begin
      select @errno  = 30002,
             @errmsg = 'Impossível Atualizar #CADASTRO_CLI_FOR #porque AGRUPAMENTO_ITENS não pode ser diferente de REFERENCIA + COR + TAMANHO.'
      goto error
    end
  end
  
  if 
     update(CGC_CPF)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,CADASTRO_CLI_FOR
     where CADASTRO_CLI_FOR.CGC_CPF=inserted.CGC_CPF AND inserted.UF <> 'EX'
    
    if @validcnt > 1
    begin
      select @errno  = 30002,
             @errmsg = 'Impossível Atualizar #CLIENTES_ATACADO #porque #CNPJ/CPF #Já existe.'
      goto error
    end
  end

  return
error:
    raiserror @errno @errmsg
    rollback transaction
END

