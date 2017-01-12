alter PROCEDURE SP_CLIENTES_NOVOS_EMAIL_HTML AS              
              
DECLARE @tableHTML  NVARCHAR(MAX) ;              
DECLARE @p_recipients as nvarchar(max) ;              
  
SET @p_recipients = N'karina.crc@delriointernational.com;crc1@delriointernational.com;crc2@delriointernational.com;crc6@delriointernational.com;crc7@delriointernational.com'          
    
SET @tableHTML =              
    N'<H1>Relação de Clientes Novos</H1>' +              
    N'<table border="1">' +              
    N'<tr style="background-color: #000080; color: #FFFFFF;"><th>Código</th><th>Cliente</th><th>Razão Social</th><th>Cadastro</th>' +              
    N'<th>CNPJ</th><th>Gerente</th><th>Representante</th></tr>' +              
    CAST ( ( select td = b.clifor,'',              
             td = b.cliente_atacado,'',              
             td = c.razao_social,'',              
             td = convert(char(10),c.cadastramento,103),'',              
             td = c.cgc_cpf,'',              
             td = d.gerente,'',              
             td = a.representante,''    
             from drvarejo.dbo.cliente_repre a,drvarejo.dbo.clientes_atacado b, drvarejo.dbo.cadastro_cli_for c,drvarejo.dbo.representantes d               
             where a.cliente_atacado=b.cliente_atacado and b.cliente_atacado=c.nome_clifor and a.representante=d.representante    
             and a.representante_principal=1             
             and b.conceito='cliente novo'              
             and c.pj_pf = 1              
             and convert(char(10),c.cadastramento,103) = convert(char(10),GETDATE(),103)              
             FOR XML PATH('tr'), TYPE               
    ) AS NVARCHAR(MAX) ) +              
    N'</table>' ;              

select * from drvarejo.dbo.cliente_repre a,drvarejo.dbo.clientes_atacado b, drvarejo.dbo.cadastro_cli_for c,drvarejo.dbo.representantes d               
where a.cliente_atacado=b.cliente_atacado and b.cliente_atacado=c.nome_clifor and a.representante=d.representante    
and a.representante_principal=1             
and b.conceito='cliente novo'              
and c.pj_pf = 1              
and convert(char(10),c.cadastramento,103) = convert(char(10),GETDATE(),103)   
  
IF @@ROWCOUNT > 0               
BEGIN  
 EXEC msdb.dbo.sp_send_dbmail        
  @recipients=@p_recipients,              
  @copy_recipients=N'',               
  @blind_copy_recipients=N'paulino.ti@delriointernational.com',              
  @profile_name = 'ti',              
  @subject = 'Email Automático:Relação de Clientes Novos',              
  @body = @tableHTML,              
  @body_format = 'HTML' ;     
END      


