
CREATE PROCEDURE [dbo].[SP_PEDIDO_COM_DESCONTO_DIVERGENTE_ORIGINAL_EMAIL_HTML] AS          
begin          
DECLARE @tableHTML  NVARCHAR(MAX) ;          
DECLARE @p_recipients as nvarchar(max) ;          
DECLARE @validcnt int ;    
    
select distinct @validcnt = count(*)    
          from vendas_produto a    
          join vendas b on b.pedido=a.pedido    
          join vendas_lote_copia_pedido c on c.pedido_externo=b.pedido_externo and b.CLIENTE_ATACADO=c.CLIENTE_ATACADO   
          where b.aprovacao IN ('A','E') and     
          round((a.desconto_item/preco1)*100,0)<>c.porc_desconto and     
          a.qtde_entregar>0 and round((a.desconto_item/preco1)*100,0)>0   
    
if @validcnt > 0    
 begin    
    
  SET @p_recipients = N'karina.crc@delriointernational.com;eduardo.maia@delriointernational.com;crc6@delriointernational.com;crc7@delriointernational.com'      
          
  SET @tableHTML =          
   N'<H1>Relação de Pedidos com Desconto Divergente do Original</H1>' +          
   N'<table border="1">' +          
   N'<tr style="background-color: #000080; color: #FFFFFF;"><th>Pedido</th><th>Pedido Externo</th><th>PedidoExterno Original</th><th>Percentual Original</th>' +          
   N'<th>Percentual</th></tr>' +          
   CAST ( ( select distinct     
    td = a.pedido, '',    
    td = b.pedido_externo,'',    
    td = c.pedido_externo,'',    
    td = c.porc_desconto,'',    
    td = round((a.desconto_item/preco1)*100,0)    
    from vendas_produto a    
    join vendas b on b.pedido=a.pedido    
    join vendas_lote_copia_pedido c on c.pedido_externo=b.pedido_externo and b.CLIENTE_ATACADO=c.CLIENTE_ATACADO   
    where b.aprovacao  IN ('A','E') and     
    round((a.desconto_item/preco1)*100,0)<>c.porc_desconto and     
    a.qtde_entregar>0 and round((a.desconto_item/preco1)*100,0)>0   
    FOR XML PATH('tr'), TYPE           
   ) AS NVARCHAR(MAX) ) +          
   N'</table>' ;          
          
  EXEC msdb.dbo.sp_send_dbmail    
   @recipients=@p_recipients,          
   @copy_recipients=N'',           
   @blind_copy_recipients=N'paulino.ti@delriointernational.com',          
   @profile_name = 'ti',          
   @subject = 'Email Automático: Relação de Pedidos com Desconto Divergente do Original',          
   @body = @tableHTML,          
   @body_format = 'HTML' ;       
        
 end    
end        

GO


