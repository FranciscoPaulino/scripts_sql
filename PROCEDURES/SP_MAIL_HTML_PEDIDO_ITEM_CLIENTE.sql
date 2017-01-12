EXEC SP_EMAIL_HTML_PEDIDO_ITEM_CLIENTE '555428'

ALTER PROCEDURE SP_EMAIL_HTML_PEDIDO_ITEM_CLIENTE 
@NUMERO_PEDIDO varchar(12) AS   
    
DECLARE @tableHTML1 NVARCHAR(MAX) ;        
DECLARE @tableHTML2 NVARCHAR(MAX) ;        
DECLARE @tableHTML3 NVARCHAR(MAX) ;        
DECLARE @p_recipients nvarchar(max) ; 
DECLARE @p_copy_recipients as nvarchar(max);
DECLARE @recipients as nvarchar(max) ; 
     
DECLARE @CLIFOR char(6),@RAZAO_SOCIAL varchar(90),@ENDERECO varchar(90), @CIDADE varchar(35),@UF char(2),@NUMERO varchar(10),
@COMPLEMENTO varchar(60), @CEP varchar(9),@DDD1 char(5), @TELEFONE1 varchar(10), @CGC_CPF varchar(19), @RG_IE varchar(19),
@PEDIDO char(12), @FILIAL varchar(25), @PEDIDO_CLIENTE varchar(25), @CODIGO_TAB_PRECO char(2), @CONDICAO_PGTO char(3),
@DESC_COND_PGTO varchar(40), @COLECAO char(6), @MOEDA char(6), @TRANSPORTADORA varchar(25),@REPRESENTANTE varchar(25), @EMISSAO char(10),
@TOT_QTDE_ORIGINAL NUMERIC(15), @TOT_VALOR_ORIGINAL NUMERIC(17,2),@OBS VARCHAR(MAX), @PEDIDO_EXTERNO char(12),
@GERENTE varchar(25) ,@EMAIL_CLI varchar(max) ,@EMAIL_GER varchar(max),@EMAIL_REP varchar(max);

declare curCapaPedido scroll cursor
for SELECT B.CLIFOR,B.RAZAO_SOCIAL,B.ENDERECO,B.CIDADE,B.UF,B.NUMERO,
  		   COMPLEMENTO=B.COMPLEMENTO,B.CEP,B.DDD1,B.TELEFONE1,B.CGC_CPF,B.RG_IE,
		   A.PEDIDO,A.FILIAL,A.PEDIDO_CLIENTE,A.CODIGO_TAB_PRECO,A.CONDICAO_PGTO,C.DESC_COND_PGTO, 
		   A.COLECAO,A.MOEDA,A.TRANSPORTADORA,A.REPRESENTANTE,EMISSAO=CONVERT(CHAR(10),A.EMISSAO,103),
		   A.TOT_QTDE_ORIGINAL,A.TOT_VALOR_ORIGINAL,A.OBS,A.PEDIDO_EXTERNO,A.GERENTE,
		   EMAIL_CLI=RTRIM(B.EMAIL),EMAIL_GER=RTRIM(D.EMAIL),EMAIL_REP=RTRIM(E.EMAIL)
	FROM VENDAS A
	JOIN CADASTRO_CLI_FOR B ON B.NOME_CLIFOR = A.CLIENTE_ATACADO
	JOIN COND_ATAC_PGTOS  C ON C.CONDICAO_PGTO = A.CONDICAO_PGTO
    JOIN CADASTRO_CLI_FOR D ON D.NOME_CLIFOR = A.GERENTE
	JOIN CADASTRO_CLI_FOR E ON E.NOME_CLIFOR = A.REPRESENTANTE
	WHERE PEDIDO=@NUMERO_PEDIDO AND PEDIDO_EXTERNO IS NOT NULL
	--WHERE PEDIDO='555428' AND PEDIDO_EXTERNO IS NOT NULL


OPEN curCapaPedido
FETCH NEXT FROM curCapaPedido INTO @CLIFOR,@RAZAO_SOCIAL,@ENDERECO,@CIDADE,@UF,@NUMERO,@COMPLEMENTO,@CEP,@DDD1,@TELEFONE1,@CGC_CPF,@RG_IE,@PEDIDO,@FILIAL,@PEDIDO_CLIENTE,@CODIGO_TAB_PRECO,@CONDICAO_PGTO,@DESC_COND_PGTO,@COLECAO,@MOEDA,@TRANSPORTADORA,@REPRESENTANTE,@EMISSAO,@TOT_QTDE_ORIGINAL,@TOT_VALOR_ORIGINAL,@OBS,@PEDIDO_EXTERNO,@GERENTE,@EMAIL_CLI,@EMAIL_GER,@EMAIL_REP

--- ENDEREÇOS DE EMAIL PARA ENVIO DO PEDIDO CLIENTE ATACADO 
--IF (@GERENTE='JOSE ANTONIO SARMENTO')          
--   BEGIN          
--       select @recipients=@EMAIL_CLI+';'+@EMAIL_REP
--   END          
--ELSE IF (@GERENTE='SERGIO PIRES') OR (@GERENTE='MARCUS CARIOCA')          
--   BEGIN          
--       select @recipients=@EMAIL_CLI+';'+@EMAIL_REP          
--   END           
--ELSE IF (@GERENTE='DENI RICARDO MONCAY CECHI') OR (@GERENTE='JOSE MARIO')          
--   BEGIN          
--       select @recipients=@EMAIL_CLI+';'+@EMAIL_REP
--   END           

SET @recipients=@EMAIL_CLI+';'+@EMAIL_REP
SET @p_copy_recipients = N''          
SET @p_recipients = @recipients     

WHILE @@fetch_status = 0
BEGIN	

SET @tableHTML1 =     
	N'	  <table border="0"> '+
    N'        <tr>'+ 
    N'        <td colspan="24">'+
    N'		  <table border="0" width="1500">'+
    N'			<tr style="background-color: #000080; color: #FFFFFF;">'+
    N'			<td colspan="2"><strong>LDR INDÚSTRIA DE CONFECÇÕES LTDA</strong></td>'+
    N'		    <td align="center" colspan="5"><strong>Pedido Cliente Atacado</strong></td>'+
    N'          <td align="right" class="style17"><strong>Data:'+convert(char(10),getdate(),103)+'</strong></td>'+
    N'			</tr>'+
    N'			<tr>'+
    N'          <td colspan="6"><strong>Razão Social: </strong>'+@CLIFOR+'-'+@RAZAO_SOCIAL+'</td>'+
    N'          <td align="right"><strong>Pedido: </strong>'+@PEDIDO+'</td>'+
    N'          <td align="right"><strong>Pedido Repre: </strong>'+@PEDIDO_EXTERNO+'</td>'+
    N'			</tr>'+
    N'			<tr>'+
    N'          <td colspan="3"><strong>Endereço: </strong>'+RTRIM(@ENDERECO)+' <strong>Número: </strong>'+RTRIM(@NUMERO)+'</td>'+
    N'          <td colspan="2"><strong>Tel: </strong>('+@DDD1+') '+@TELEFONE1+'</td>'+
    N'          <td align="right" colspan="3"><strong>Cond.Pag: </strong>'+RTRIM(@CONDICAO_PGTO)+'-'+@DESC_COND_PGTO+'</td>'+
    N'			</tr>'+
    N'			<tr>'+
    N'          <td colspan="2"><strong>Cidade: </strong>'+@CIDADE+'/'+@UF+'</td>'+
    N'          <td><strong>Cep: </strong>'+@CEP+'</td>'+
    N'          <td colspan="4"><strong>Emissão: </strong>'+CONVERT(CHAR(10),@EMISSAO,103)+'</td>'+
    N'          <td align="right"><strong>Coleção: </strong>'+@COLECAO+'</td>'+
    N'			</tr>'+
    N'			<tr>'+
    N'          <td colspan="2" class="style39"><strong>CNPJ/CPF: </strong>'+@CGC_CPF+'</td>'+
    N'          <td colspan="2" class="style39"><strong>I.E.: </strong>'+@RG_IE+'</td>'+
    N'          <td colspan="2" class="style39"><strong>Ped.Cl.: </strong>'+@PEDIDO_CLIENTE+'</td>'+
    N'          <td class="style39"><strong>Tab Preço: </strong>'+@CODIGO_TAB_PRECO+'</td>'+
    N'          <td align="right" class="style39"><strong>Moeda: </strong>'+@MOEDA+'</td>'+
    N'			</tr>'+
    N'			<tr>'+
    N'          <td class="style38"><strong>Filial: </strong>'+@FILIAL+'</td>'+
    N'          <td colspan="5"><strong>Transportadora: </strong>'+@TRANSPORTADORA+'</td>'+
    N'          <td colspan="2"><strong>Representante: </strong>'+@REPRESENTANTE+'</td>'+
    N'			</tr>'+
	N'		    </table>'+
    N'          </td>'+
    N'          </tr>';
  
SET @tableHTML2 = 
    N'        <tr style="background-color: #000080; color: #FFFFFF;">'+
    N'            <td><strong>Ref</strong></td>'+
    N'            <td><strong>Cor</strong></td>'+
    N'            <td><strong>Descrição Produto/Cor</strong></td>'+
    N'            <td colspan="16"><strong>Qtde/Grade</strong></td>'+
    N'            <td><strong>Qt.Tot.</strong></td>'+
    N'            <td><strong>Preço</strong></td>'+
    N'            <td><strong>Valor</strong></td>'+
    N'            <td><strong>Faturamento</strong></td>'+
    N'            <td><strong>Limite</strong></td>'+
    N'        </tr>'+
    N'        <tr>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'        </tr>'+
    CAST ( ( select td = a.produto,'',  
             td = a.COR_PRODUTO,'',  
             td = rtrim(b.DESC_PRODUTO)+'/'+RTRIM(c.DESC_COR_PRODUTO),'',  
             td = (case when a.vo1 > 0 then cast(a.vo1 as CHAR(5))+' '+RTRIM(d.TAMANHO_1) else '' end),'',
             td = (case when a.vo2 > 0 then cast(a.vo2 as CHAR(5))+' '+RTRIM(d.TAMANHO_2) else '' end),'',
             td = (case when a.vo3 > 0 then cast(a.vo3 as CHAR(5))+' '+RTRIM(d.TAMANHO_3) else '' end),'',
             td = (case when a.vo4 > 0 then cast(a.vo4 as CHAR(5))+' '+RTRIM(d.TAMANHO_4) else '' end),'',
             td = (case when a.vo5 > 0 then cast(a.vo5 as CHAR(5))+' '+RTRIM(d.TAMANHO_5) else '' end),'',
             td = (case when a.vo6 > 0 then cast(a.vo6 as CHAR(5))+' '+RTRIM(d.TAMANHO_6) else '' end),'',
             td = (case when a.vo7 > 0 then cast(a.vo7 as CHAR(5))+' '+RTRIM(d.TAMANHO_7) else '' end),'',
             td = (case when a.vo8 > 0 then cast(a.vo8 as CHAR(5))+' '+RTRIM(d.TAMANHO_8) else '' end),'',
             td = (case when a.vo9 > 0 then cast(a.vo9 as CHAR(5))+' '+RTRIM(d.TAMANHO_9) else '' end),'',
             td = (case when a.vo10 > 0 then cast(a.vo10 as CHAR(5))+' '+RTRIM(d.TAMANHO_10) else '' end),'',
             td = (case when a.vo11 > 0 then cast(a.vo11 as CHAR(5))+' '+RTRIM(d.TAMANHO_11) else '' end),'',
             td = (case when a.vo12 > 0 then cast(a.vo12 as CHAR(5))+' '+RTRIM(d.TAMANHO_12) else '' end),'',
             td = (case when a.vo13 > 0 then cast(a.vo13 as CHAR(5))+' '+RTRIM(d.TAMANHO_13) else '' end),'',
             td = (case when a.vo14 > 0 then cast(a.vo14 as CHAR(5))+' '+RTRIM(d.TAMANHO_14) else '' end),'',
             td = (case when a.vo15 > 0 then cast(a.vo15 as CHAR(5))+' '+RTRIM(d.TAMANHO_15) else '' end),'',
             td = (case when a.vo16 > 0 then cast(a.vo16 as CHAR(5))+' '+RTRIM(d.TAMANHO_16) else '' end),'',
             td = a.QTDE_ORIGINAL,'',  
             td = (a.PRECO1-A.DESCONTO_ITEM),'',  
             td = a.VALOR_ORIGINAL,'',  
             td = CONVERT(CHAR(10),a.ENTREGA,103),'',  
             td = CONVERT(CHAR(10),a.LIMITE_ENTREGA,103)
             from drvarejo.dbo.vendas_produto a  
             join drvarejo.dbo.produtos b on b.produto=a.PRODUTO
             join drvarejo.dbo.produto_cores c on c.PRODUTO = a.PRODUTO and c.COR_PRODUTO=a.COR_PRODUTO
             join DRVAREJO.dbo.PRODUTOS_TAMANHOS d on d.GRADE = b.GRADE
         	 WHERE a.PEDIDO=@NUMERO_PEDIDO
             order by a.PRODUTO
             FOR XML PATH('tr'), TYPE   
    ) AS NVARCHAR(MAX) ) +  
    N'        <tr>'+
    N'            <td colspan="18"></td>'+
    N'            <td><strong>Sub Total:</strong></td>'+
    N'            <td><strong>'+CAST(@TOT_QTDE_ORIGINAL AS CHAR(15))+'</strong></td>'+
    N'            <td></td>'+
    N'            <td><strong>'+CAST(@TOT_VALOR_ORIGINAL AS CHAR(17))+'</strong></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'        </tr>'+
    N'        <tr>'+
    N'            <td colspan="18"></td>'+
    N'            <td><strong>Total do Pedido:</strong></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'            <td><strong>'+CAST(@TOT_VALOR_ORIGINAL AS CHAR(17))+'</strong></td>'+
    N'            <td></td>'+
    N'            <td></td>'+
    N'        </tr>'+
    N'        <tr>'+
    N'            <td colspan="24"><strong>Observações: </strong>'+@OBS+'</td>'+
    N'        </tr>'+
    N'    </table>';
    
set @tableHTML3 = @tableHTML1+@tableHTML2;
    
EXEC msdb.dbo.sp_send_dbmail  
    @recipients=@p_recipients,        
    @copy_recipients=@p_copy_recipients,       
    @blind_copy_recipients=N'',        
    @profile_name = 'ti',        
    @subject = 'Email Automático: Pedido de Venda - Cópia',        
    @body = @tableHTML3,        
    @body_format = 'HTML' ;     

	FETCH NEXT FROM curCapaPedido INTO @CLIFOR,@RAZAO_SOCIAL,@ENDERECO,@CIDADE,@UF,@NUMERO,@COMPLEMENTO,@CEP,@DDD1,@TELEFONE1,@CGC_CPF,@RG_IE,@PEDIDO,@FILIAL,@PEDIDO_CLIENTE,@CODIGO_TAB_PRECO,@CONDICAO_PGTO,@DESC_COND_PGTO,@COLECAO,@MOEDA,@TRANSPORTADORA,@REPRESENTANTE,@EMISSAO,@TOT_QTDE_ORIGINAL,@TOT_VALOR_ORIGINAL,@OBS,@PEDIDO_EXTERNO,@GERENTE,@EMAIL_CLI,@EMAIL_GER,@EMAIL_REP
	
END				
CLOSE curCapaPedido
DEALLOCATE curCapaPedido



----- TABELA PARA DAR APOIO AO JOB DE ENVIO DO EMAIL

USE [DRVAREJO]
GO

/****** Object:  Table [dbo].[SAW_CADASTRO_PEDIDO_ENVIO_EMAIL]    Script Date: 06/18/2013 08:44:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[SAW_CADASTRO_PEDIDO_ENVIO_EMAIL](
	[PEDIDO] [char](12) NOT NULL,
	[ENVIADO] [bit] NOT NULL,
	[EMAIL_DATA_ENVIO] [datetime] NULL,
 CONSTRAINT [PK_SAW_CADASTRO_PEDIDO_ENVIO_EMAIL] PRIMARY KEY CLUSTERED 
(
	[PEDIDO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO



--- trigger ldr_ti_vendas
USE [DRVAREJO]
GO
/****** Object:  Trigger [dbo].[LDR_TI_VENDAS]    Script Date: 06/19/2013 08:07:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER trigger [dbo].[LDR_TI_VENDAS] 
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
/*----------------------------------------------------------------------------------------------------------------*/
	INSERT INTO SAW_CADASTRO_PEDIDO_ENVIO_EMAIL (PEDIDO,ENVIADO,EMAIL_DATA_ENVIO)
	SELECT INSERTED.PEDIDO,0,NULL FROM VENDAS, inserted WHERE VENDAS.PEDIDO=inserted.PEDIDO AND VENDAS.TABELA_FILHA='VENDAS_PRODUTO'
/*----------------------------------------------------------------------------------------------------------------*/
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end


--- TABELA PARA SUPORTE AO ENVIO DO PEDIDO VIA EMAIL 
SELECT * FROM SAW_CADASTRO_PEDIDO_ENVIO_EMAIL


--------------------------------- PROCEDURE FINAL PARA ENVIO DOS PEDIDOS VIA EMAIL COM SQLSERVER -----------------------
EXEC SP_EMAIL_HTML_PEDIDO_CLIENTE

-- SAW_CADASTRO_PEDIDO_ENVIO_EMAIL (PEDIDO,ENVIADO,EMAIL_DATA_ENVIO)

ALTER PROCEDURE SP_EMAIL_HTML_PEDIDO_CLIENTE
AS        

DECLARE @PEDIDO char(12), @ENVIADO bit, @EMAIL_DATA_ENVIO datetime;
declare curCapaPedidoEnvio scroll cursor
for SELECT TOP 5 PEDIDO,ENVIADO,EMAIL_DATA_ENVIO 
    FROM SAW_CADASTRO_PEDIDO_ENVIO_EMAIL 
    WHERE ENVIADO = 0 AND EMAIL_DATA_ENVIO IS NULL

OPEN curCapaPedidoEnvio
FETCH NEXT FROM curCapaPedidoEnvio INTO @PEDIDO, @ENVIADO, @EMAIL_DATA_ENVIO

WHILE @@fetch_status = 0
BEGIN	
    --- EXECUTA A PROCEDURE PARA ENVIO DO PEDIDO VIA EMAIL
    EXEC SP_EMAIL_HTML_PEDIDO_ITEM_CLIENTE @PEDIDO

    --- ATUALIZA ENVIO DO EMAIL NA TABELA SUPORTE
    UPDATE SAW_CADASTRO_PEDIDO_ENVIO_EMAIL 
    SET ENVIADO=1, EMAIL_DATA_ENVIO = GETDATE()
    WHERE PEDIDO=@PEDIDO
    
    --- PRÓXIMO PEDIDO A SER ENVIADO
    FETCH NEXT FROM curCapaPedidoEnvio INTO @PEDIDO, @ENVIADO, @EMAIL_DATA_ENVIO
END				
CLOSE curCapaPedidoEnvio
DEALLOCATE curCapaPedidoEnvio



--UPDATE SAW_CADASTRO_PEDIDO_ENVIO_EMAIL SET ENVIADO=0, EMAIL_DATA_ENVIO = null
SELECT * FROM SAW_CADASTRO_PEDIDO_ENVIO_EMAIL

UPDATE SAW_CADASTRO_PEDIDO_ENVIO_EMAIL
SET ENVIADO=0, EMAIL_DATA_ENVIO=NULL
WHERE PEDIDO >= '555561' 

SELECT * FROM VENDAS
WHERE PEDIDO >='555542'
ORDER BY PEDIDO      
