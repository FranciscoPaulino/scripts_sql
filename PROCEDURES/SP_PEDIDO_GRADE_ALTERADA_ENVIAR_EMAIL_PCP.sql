USE [DRLINGERIE]
GO
/****** Object:  StoredProcedure [dbo].[SP_PEDIDO_PERFAT_FECHADO_ENVIAR_EMAIL_PCP]    Script Date: 03/04/2017 08:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_PEDIDO_GRADE_ALTERADA_ENVIAR_EMAIL_PCP]           
@PEDIDO CHAR(12)    
AS                      
                      
DECLARE @tableHTML  NVARCHAR(MAX) ;                      
DECLARE @p_recipients as nvarchar(max) ;    
DECLARE @p_subject as nvarchar(max);                      
                
SET @p_recipients = N'fatima.pcp@drling.com.br;gilvania.pcp@drling.com.br;Rogeria.pcp@drling.com.br;Vladia.pcp@drling.com.br;Tayse.pcp@drling.com.br;Eveline.pcp@drling.com.br;Claudia.pcp@drling.com.br;Wilson.pcp@drling.com.br;Daniel.pcp@drling.com.br;Vania.pcp@drling.com.br;Ticiane.pcp@drling.com.br;Dea.supply@drling.com.br;Aline.comercial@delrio.com.br;Luciana.dr@delrio.com.br;Beatriz.pcp@drling.com.br';          
--SET @p_recipients = N'paulino.ti@drling.com.br';

SET @p_subject = N'Email Automático:Pedido '+@PEDIDO+' Grade ou Qtde Total alterada depois de aprovado';    
    
                      
SET @tableHTML =                      
    N'<H1>Pedido '+@PEDIDO+' Grade ou Qtde Total alterada depois de aprovado</H1>' +                      
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
             and tot_qtde_entregar>0 order by a.emissao            
             FOR XML PATH('tr'), TYPE                       
    ) AS NVARCHAR(MAX) ) +                      
    N'</table>' ;                      
                      
EXEC msdb.dbo.sp_send_dbmail                
    @recipients=@p_recipients,                      
    @copy_recipients=N'',                       
    @blind_copy_recipients=N'',                      
    @profile_name = 'ti',                      
    @subject = @p_subject,                      
    @body = @tableHTML,                      
    @body_format = 'HTML' ; 

