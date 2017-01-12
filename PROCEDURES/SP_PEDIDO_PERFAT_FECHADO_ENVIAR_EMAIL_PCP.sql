CREATE PROCEDURE SP_PEDIDO_PERFAT_FECHADO_ENVIAR_EMAIL_PCP   
@PEDIDO CHAR(12)  
AS              
              
DECLARE @tableHTML  NVARCHAR(MAX) ;              
DECLARE @p_recipients as nvarchar(max) ;              
        
SET @p_recipients = N'gerente.pcp@delriointernational.com;gilvania@delriointernational.com;pcp3@delriointernational.com'  
              
SET @tableHTML =              
    N'<H1>Pedido Incluído em PERFAT já Fechado</H1>' +              
    N'<table border="1">' +              
    N'<tr style="background-color: #000080; color: #FFFFFF;"><th>Código</th><th>Cliente</th><th>Conceito</th><th>Emissão</th>' +              
    N'<th>Pedido</th><th>Total Qdte Original</th><th>Total Valor Original</th><th>Gerente</th><th>Representante</th>' +              
    N'<th>PerFat</th></tr>' +              
    CAST ( ( select td = b.clifor,'',              
             td = a.cliente_atacado,'',              
             td = b.conceito,'',              
             td = convert(char(10),a.emissao,103),'',              
             td = a.pedido,'',              
             td = cast(a.tot_qtde_original as numeric(10,0)),'',              
             td = cast(a.tot_valor_original as numeric(10,2)),'',              
             td = a.gerente,'',              
             td = a.representante,'',              
             td = a.numero_entrega+' - '+a.periodo_pcp              
             from vendas a, clientes_atacado b, cadastro_cli_for c              
             where a.cliente_atacado=b.cliente_atacado and b.cliente_atacado=c.nome_clifor              
             and a.tabela_filha='VENDAS_PRODUTO'               
             and a.pedido=@PEDIDO              
             and c.pj_pf = 1              
             and tot_qtde_entregar>0 order by a.emissao    
             FOR XML PATH('tr'), TYPE               
    ) AS NVARCHAR(MAX) ) +              
    N'</table>' ;              
              
EXEC msdb.dbo.sp_send_dbmail        
    @recipients=@p_recipients,              
    @copy_recipients=N'',               
    @blind_copy_recipients=N'paulino.ti@delriointernational.com',              
    @profile_name = 'ti',              
    @subject = 'Email Automático:Pedido Incluído em PERFAT já Fechado',              
    @body = @tableHTML,              
    @body_format = 'HTML' ;     
    