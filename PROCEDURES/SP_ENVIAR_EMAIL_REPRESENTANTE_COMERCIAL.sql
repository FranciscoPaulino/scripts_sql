sp_helptext SP_ENVIAR_EMAIL_REPRESENTANTE_COMERCIAL

create PROC SP_ENVIAR_EMAIL_REPRESENTANTE_COMERCIAL           
AS          
begin          
  declare  @endereco_email_ger nvarchar(70),          
           @endereco_email_rep nvarchar(70),          
           @tableHTML  NVARCHAR(MAX),           
           @p_recipients as nvarchar(max),          
     @p_copy_recipients as nvarchar(max),          
           @pedido_externo char(12),          
           @cliente_atacado varchar(25),          
     @assunto as nvarchar(max),          
           @gerente as nvarchar(25),          
           @recipients as nvarchar(max)          
            
  select distinct @gerente=rtrim(a.gerente),@endereco_email_ger=c.email,@endereco_email_rep=b.email,@pedido_externo=pedido_externo,@cliente_atacado=cliente_atacado          
  from ldr_produtos_periodos_entregas_futuras a          
  join cadastro_cli_for b on a.representante=b.nome_clifor          
  join cadastro_cli_for c on a.gerente=c.nome_clifor          
  where enviar_email=1 and pedido_externo like '%w%'         
          
  -- verificando email          
          
  IF (@gerente='JOSE ANTONIO SARMENTO')          
     BEGIN          
         select @recipients=@endereco_email_ger+';'+@endereco_email_rep+';crc6@delriointernational.com'          
     END          
  ELSE IF (@gerente='SERGIO PIRES') OR (@gerente='MARCUS CARIOCA')          
     BEGIN          
         select @recipients=@endereco_email_ger+';'+@endereco_email_rep+';eduardo.maia@delriointernational.com'          
     END           
  ELSE IF (@gerente='DENI RICARDO MONCAY CECHI') OR (@gerente='JOSE MARIO')          
     BEGIN          
         select @recipients=@endereco_email_ger+';'+@endereco_email_rep+';crc7@delriointernational.com'          
     END           
          
SET @p_copy_recipients = N'karina.crc@delriointernational.com'          
SET @p_recipients = @recipients          
SET @assunto = 'Pedido Externo: '+@pedido_externo+' - '+@cliente_atacado          
          
SET @tableHTML =          
    N'<H2>PERFAT do pedido alterado com base na entrega da Referência e Cor abaixo relacionada</H2>' +          
    N'<table border="1">' +          
    N'<tr style="background-color: #000080; color: #FFFFFF;"><th>Gerente</th><th>Representante</th><th>Cliente</th><th>Pedido Externo</th>' +          
    N'<th>Produto</th><th>Cor Produto</th><th>PERFAT Escolhido</th><th>PERFAT Entrega</th><th>Início Entrega</th><th>Limite Entrega</th>' +          
    CAST ( ( select distinct          
             td=a.gerente,'',           
    td=a.representante,'',          
    td=a.cliente_atacado,'',          
    td=a.pedido_externo,'',          
    td=a.produto,'',          
    td=a.cor_produto,'',          
             td=numero_entrega_rep,'',          
    td=a.numero_entrega,'',          
    td=convert(char(10),a.entrega,103),'',          
             td=convert(char(10),a.limite_entrega,103)          
    from ldr_produtos_periodos_entregas_futuras a          
    join cadastro_cli_for b on a.representante=b.nome_clifor          
    where enviar_email=1 and pedido_externo like '%w%'      
             FOR XML PATH('tr'), TYPE           
     ) AS NVARCHAR(MAX) ) +          
    N'</table>' ;          
          
    EXEC msdb.dbo.sp_send_dbmail           
    @recipients=@p_recipients,          
    @copy_recipients=@p_copy_recipients,           
    @blind_copy_recipients=N'ti@delriointernational.com',          
    @profile_name = 'ti',          
    @subject = @assunto,          
    @body = @tableHTML,          
    @body_format = 'HTML' ;          
              
    -- altera o status do email para não enviar novamente na proxima vez          
    update ldr_produtos_periodos_entregas_futuras          
    set enviar_email=0          
    where enviar_email=1          
          
end 

