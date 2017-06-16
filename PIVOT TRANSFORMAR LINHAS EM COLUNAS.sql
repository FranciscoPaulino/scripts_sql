SELECT DESC_PRODUTO, DESC_COR_PRODUTO, [40]=isnull([40],0),[42]=isnull([42],0),
[44]=isnull([44],0),[46]=isnull([46],0),[48]=isnull([48],0),[50]=isnull([50],0),
[52]=isnull([52],0),[54]=isnull([54],0),[PP]=isnull([PP],0),[P]=isnull([P],0),
[M]=isnull([M],0),[G]=isnull([G],0),[GG]=isnull([GG],0),[EG]=isnull([EG],0)  FROM (
SELECT VENDAS.CLIENTE_ATACADO,VENDAS.PEDIDO,
PRODUTOS.PRODUTO,
PRODUTOS.DESC_PRODUTO, 
PRODUTO_CORES.DESC_COR_PRODUTO,
PRODUTOS_BARRA.GRADE,
QTDE = SUM(CASE WHEN PRODUTOS_BARRA.tamanho='1'  THEN VENDAS_PRODUTO.Vo1
                WHEN PRODUTOS_BARRA.tamanho='2'  THEN VENDAS_PRODUTO.Vo2
                WHEN PRODUTOS_BARRA.tamanho='3'  THEN VENDAS_PRODUTO.Vo3
                WHEN PRODUTOS_BARRA.tamanho='4'  THEN VENDAS_PRODUTO.Vo4
                WHEN PRODUTOS_BARRA.tamanho='5'  THEN VENDAS_PRODUTO.Vo5
                WHEN PRODUTOS_BARRA.tamanho='6'  THEN VENDAS_PRODUTO.Vo6
                WHEN PRODUTOS_BARRA.tamanho='7'  THEN VENDAS_PRODUTO.Vo7
                WHEN PRODUTOS_BARRA.tamanho='8'  THEN VENDAS_PRODUTO.Vo8
                WHEN PRODUTOS_BARRA.tamanho='9'  THEN VENDAS_PRODUTO.Vo9
                WHEN PRODUTOS_BARRA.tamanho='10' THEN VENDAS_PRODUTO.Vo10
                WHEN PRODUTOS_BARRA.tamanho='11' THEN VENDAS_PRODUTO.Vo11
                WHEN PRODUTOS_BARRA.tamanho='12' THEN VENDAS_PRODUTO.Vo12
                WHEN PRODUTOS_BARRA.tamanho='13' THEN VENDAS_PRODUTO.Vo13
                WHEN PRODUTOS_BARRA.tamanho='14' THEN VENDAS_PRODUTO.Vo14
                WHEN PRODUTOS_BARRA.tamanho='15' THEN VENDAS_PRODUTO.Vo15
                WHEN PRODUTOS_BARRA.tamanho='16' THEN VENDAS_PRODUTO.Vo16
           END)
FROM PRODUTOS_BARRA PRODUTOS_BARRA 
JOIN PRODUTOS PRODUTOS ON PRODUTOS_BARRA.PRODUTO=PRODUTOS.PRODUTO 
JOIN PRODUTO_CORES PRODUTO_CORES ON PRODUTO_CORES.PRODUTO=PRODUTOS_BARRA.PRODUTO 
 AND PRODUTO_CORES.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO 
LEFT JOIN (SELECT * FROM VENDAS_PRODUTO) AS VENDAS_PRODUTO
  ON VENDAS_PRODUTO.PRODUTO=PRODUTOS_BARRA.PRODUTO 
 AND VENDAS_PRODUTO.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO 
JOIN VENDAS ON VENDAS.PEDIDO = VENDAS_PRODUTO.PEDIDO  
WHERE PRODUTOS_BARRA.CODIGO_BARRA LIKE '789%' 
AND VENDAS_PRODUTO.QTDE_ENTREGAR=0 and 
vendas.PEDIDO='91191'
GROUP BY  VENDAS.CLIENTE_ATACADO,VENDAS.PEDIDO,
PRODUTOS.PRODUTO,
PRODUTOS.DESC_PRODUTO, 
PRODUTO_CORES.DESC_COR_PRODUTO,
PRODUTOS_BARRA.GRADE ) sq
PIVOT (SUM(QTDE) FOR grade IN ([40],[42],[44],[46],[48],[50],[52],[54],[PP],[P],[M],[G],[GG],[EG])) AS pt


SELECT DESC_PRODUTO, DESC_COR_PRODUTO, [tamanho_1],tamanho_2,tamanho_3,tamanho_4,tamanho_5,tamanho_6,tamanho_7,tamanho_8,tamanho_9,tamanho_10,tamanho_11,tamanho_12,tamanho_13,tamanho_14,tamanho_15,tamanho_16  FROM (
SELECT VENDAS.CLIENTE_ATACADO,VENDAS.PEDIDO,
PRODUTOS.PRODUTO,
PRODUTOS.DESC_PRODUTO, 
PRODUTO_CORES.DESC_COR_PRODUTO,
PRODUTOS_BARRA.GRADE,
QTDE = ISNULL(SUM(CASE WHEN PRODUTOS_BARRA.tamanho='1'  THEN ISNULL(VENDAS_PRODUTO.Vo1,0)
                     WHEN PRODUTOS_BARRA.tamanho='2'  THEN ISNULL(VENDAS_PRODUTO.Vo2,0) 
                     WHEN PRODUTOS_BARRA.tamanho='3'  THEN ISNULL(VENDAS_PRODUTO.Vo3,0) 
                     WHEN PRODUTOS_BARRA.tamanho='4'  THEN ISNULL(VENDAS_PRODUTO.Vo4,0) 
                     WHEN PRODUTOS_BARRA.tamanho='5'  THEN ISNULL(VENDAS_PRODUTO.Vo5,0) 
                     WHEN PRODUTOS_BARRA.tamanho='6'  THEN ISNULL(VENDAS_PRODUTO.Vo6,0) 
                     WHEN PRODUTOS_BARRA.tamanho='7'  THEN ISNULL(VENDAS_PRODUTO.Vo7,0) 
                     WHEN PRODUTOS_BARRA.tamanho='8'  THEN ISNULL(VENDAS_PRODUTO.Vo8,0) 
                     WHEN PRODUTOS_BARRA.tamanho='9'  THEN ISNULL(VENDAS_PRODUTO.Vo9,0) 
                     WHEN PRODUTOS_BARRA.tamanho='10' THEN ISNULL(VENDAS_PRODUTO.Vo10,0) 
                     WHEN PRODUTOS_BARRA.tamanho='11' THEN ISNULL(VENDAS_PRODUTO.Vo11,0) 
                     WHEN PRODUTOS_BARRA.tamanho='12' THEN ISNULL(VENDAS_PRODUTO.Vo12,0) 
                     WHEN PRODUTOS_BARRA.tamanho='13' THEN ISNULL(VENDAS_PRODUTO.Vo13,0) 
                     WHEN PRODUTOS_BARRA.tamanho='14' THEN ISNULL(VENDAS_PRODUTO.Vo14,0) 
                     WHEN PRODUTOS_BARRA.tamanho='15' THEN ISNULL(VENDAS_PRODUTO.Vo15,0) 
                     WHEN PRODUTOS_BARRA.tamanho='16' THEN ISNULL(VENDAS_PRODUTO.Vo16,0) 
                     END),0)
FROM PRODUTOS_BARRA PRODUTOS_BARRA 
JOIN PRODUTOS PRODUTOS ON PRODUTOS_BARRA.PRODUTO=PRODUTOS.PRODUTO 
JOIN PRODUTO_CORES PRODUTO_CORES ON PRODUTO_CORES.PRODUTO=PRODUTOS_BARRA.PRODUTO 
 AND PRODUTO_CORES.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO 
LEFT JOIN (SELECT * FROM VENDAS_PRODUTO) AS VENDAS_PRODUTO
  ON VENDAS_PRODUTO.PRODUTO=PRODUTOS_BARRA.PRODUTO 
 AND VENDAS_PRODUTO.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO 
JOIN VENDAS ON VENDAS.PEDIDO = VENDAS_PRODUTO.PEDIDO  
join PRODUTOS_TAMANHOS on PRODUTOS_TAMANHOS.GRADE=produtos.GRADE
WHERE PRODUTOS_BARRA.CODIGO_BARRA LIKE '789%' 
AND VENDAS_PRODUTO.QTDE_ENTREGAR>0 and vendas.PEDIDO='91191'
GROUP BY  VENDAS.CLIENTE_ATACADO,VENDAS.PEDIDO,
PRODUTOS.PRODUTO,
PRODUTOS.DESC_PRODUTO, 
PRODUTO_CORES.DESC_COR_PRODUTO,
PRODUTOS_BARRA.GRADE ) sq
PIVOT (SUM(QTDE) FOR grade IN (tamanho_1,tamanho_2,tamanho_3,tamanho_4,tamanho_5,tamanho_6,tamanho_7,tamanho_8,tamanho_9,tamanho_10,tamanho_11,tamanho_12,tamanho_13,tamanho_14,tamanho_15,tamanho_16)) AS pt




DECLARE @SQLStr VARCHAR(5000)
SET @SQLStr=''
SELECT @SQLStr=@SQLStr+'['+[asa].[Column]+'],'
FROM
(SELECT DISTINCT CONVERT(VARCHAR(4),GRADE) as [Column]
 FROM PRODUTOS_BARRA 
 JOIN VENDAS_PRODUTO ON VENDAS_PRODUTO.PRODUTO=PRODUTOS_BARRA.PRODUTO AND VENDAS_PRODUTO.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO
 WHERE VENDAS_PRODUTO.PEDIDO='91191' 
) asa
SET @SQLStr=LEFT(@SQLStr,len(@SQLStr)-1)
PRINT @SQLStr

SET @SQLStr = 'SELECT td = PRODUTO,'''', td = COR_PRODUTO,'''', td = RTRIM(DESC_PRODUTO)+''/''+RTRIM(DESC_COR_PRODUTO),'''',' + @SQLStr + ','''',td = QTDE_ORIGINAL,'''',td = (PRECO1-DESCONTO_ITEM),'''',td = VALOR_ORIGINAL,'''',td = CONVERT(CHAR(10),ENTREGA,103),'''',td = CONVERT(CHAR(10),LIMITE_ENTREGA,103),''''  FROM (
SELECT  VENDAS_PRODUTO.PRODUTO,  VENDAS_PRODUTO.COR_PRODUTO, DESC_PRODUTO,DESC_COR_PRODUTO,QTDE_ORIGINAL,PRECO1,DESCONTO_ITEM,VALOR_ORIGINAL,ENTREGA,LIMITE_ENTREGA, PRODUTOS_BARRA.GRADE,
QTDE = ISNULL(SUM(CASE WHEN PRODUTOS_BARRA.tamanho=''1''  THEN ISNULL(VENDAS_PRODUTO.Vo1,0)
                     WHEN PRODUTOS_BARRA.tamanho=''2''  THEN ISNULL(VENDAS_PRODUTO.Vo2,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''3''  THEN ISNULL(VENDAS_PRODUTO.Vo3,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''4''  THEN ISNULL(VENDAS_PRODUTO.Vo4,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''5''  THEN ISNULL(VENDAS_PRODUTO.Vo5,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''6''  THEN ISNULL(VENDAS_PRODUTO.Vo6,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''7''  THEN ISNULL(VENDAS_PRODUTO.Vo7,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''8''  THEN ISNULL(VENDAS_PRODUTO.Vo8,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''9''  THEN ISNULL(VENDAS_PRODUTO.Vo9,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''10'' THEN ISNULL(VENDAS_PRODUTO.Vo10,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''11'' THEN ISNULL(VENDAS_PRODUTO.Vo11,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''12'' THEN ISNULL(VENDAS_PRODUTO.Vo12,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''13'' THEN ISNULL(VENDAS_PRODUTO.Vo13,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''14'' THEN ISNULL(VENDAS_PRODUTO.Vo14,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''15'' THEN ISNULL(VENDAS_PRODUTO.Vo15,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''16'' THEN ISNULL(VENDAS_PRODUTO.Vo16,0) 
                     END),0)
FROM PRODUTOS_BARRA PRODUTOS_BARRA 
JOIN PRODUTOS PRODUTOS ON PRODUTOS_BARRA.PRODUTO=PRODUTOS.PRODUTO 
JOIN PRODUTO_CORES PRODUTO_CORES ON PRODUTO_CORES.PRODUTO=PRODUTOS_BARRA.PRODUTO 
 AND PRODUTO_CORES.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO 
LEFT JOIN (SELECT * FROM VENDAS_PRODUTO) AS VENDAS_PRODUTO
  ON VENDAS_PRODUTO.PRODUTO=PRODUTOS_BARRA.PRODUTO 
 AND VENDAS_PRODUTO.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO 
JOIN VENDAS ON VENDAS.PEDIDO = VENDAS_PRODUTO.PEDIDO  
join PRODUTOS_TAMANHOS on PRODUTOS_TAMANHOS.GRADE=produtos.GRADE
WHERE PRODUTOS_BARRA.CODIGO_BARRA LIKE ''789%'' 
AND VENDAS_PRODUTO.QTDE_ENTREGAR>0 and vendas.PEDIDO=''91191''
GROUP BY   VENDAS_PRODUTO.PRODUTO,  VENDAS_PRODUTO.COR_PRODUTO, DESC_PRODUTO,DESC_COR_PRODUTO,QTDE_ORIGINAL,PRECO1,DESCONTO_ITEM,VALOR_ORIGINAL,ENTREGA,LIMITE_ENTREGA, PRODUTOS_BARRA.GRADE ) sq
PIVOT (SUM(QTDE) FOR grade IN ('+@SQLStr+')) AS pt'
PRINT @SQLStr
EXEC(@SQLStr)


      select td = a.produto,'',    
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
             from vendas_produto a with (nolock)   
             join produtos b with (nolock) on b.produto=a.PRODUTO  
             join produto_cores c with (nolock) on c.PRODUTO = a.PRODUTO and c.COR_PRODUTO=a.COR_PRODUTO  
             join PRODUTOS_TAMANHOS d with (nolock) on d.GRADE = b.GRADE  
           WHERE a.PEDIDO='91191' --@NUMERO_PEDIDO  
             order by a.PRODUTO  



SELECT Descricao, CodProduto,  [G ],[GG], [M ], [P ], [PP], [RN], [UN], [XG] 
FROM (SELECT P.Descricao, P.CodProduto, T.NomeTamanho,   SUM(IP.Quant) QTDETOTAL           
FROM Produtos P, GradeProdutos GP, Tamanhos T, ItensPedidos IP  
WHERE P.CodProduto = GP.CodProduto 
  AND P.CodProduto = IP.CodProduto    
AND GP.CodTamanho = T.CodTamanho    
AND IP.CodTamanho = T.CodTamanho    
ANDSUBSTRING(P.CodProduto, 1,2 ) = 'CL'    
AND SUBSTRING(P.CodProduto, 5,3 ) = '053'    
AND YEAR(P.DATA) >= 2012  
GROUP BY P.CodProduto, P.Descricao, T.NomeTamanho          ) sq 
PIVOT (SUM(QTDETOTAL) FOR NomeTamanho IN ([G ], [GG], [M ], [P ], [PP], [RN], [UN], [XG])) AS pt



DECLARE @SQLStr VARCHAR(5000)
SET @SQLStr=''
SELECT @SQLStr=@SQLStr+'['+[asa].[Column]+'], '
FROM
(SELECT DISTINCT CONVERT(VARCHAR(2),TAMANHO) as [Column]
 FROM PRODUTOS_TAMANHOS
) asa
SET @SQLStr=LEFT(@SQLStr,len(@SQLStr)-1)
PRINT @SQLStr



USE [DRLINGERIE]
GO
/****** Object:  StoredProcedure [dbo].[SP_EMAIL_HTML_PEDIDO_ITEM_CLIENTE]    Script Date: 20/04/2017 11:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_EMAIL_HTML_PEDIDO_ITEM_CLIENTE]   
@NUMERO_PEDIDO varchar(12) AS     
      
DECLARE @tableHTML1 NVARCHAR(MAX) ;          
DECLARE @tableHTML2 NVARCHAR(MAX) ;          
DECLARE @tableHTML3 NVARCHAR(MAX) ;          
DECLARE @p_recipients nvarchar(max) ;   
DECLARE @p_copy_recipients as nvarchar(max);  
DECLARE @recipients as nvarchar(max) ;   
DECLARE @obs_add as nvarchar(max) ;   
       
DECLARE @CLIFOR char(6),@RAZAO_SOCIAL varchar(90),@ENDERECO varchar(90), @CIDADE varchar(35),@UF char(2),@NUMERO varchar(10),  
@COMPLEMENTO varchar(60), @CEP varchar(9),@DDD1 char(5), @TELEFONE1 varchar(10), @CGC_CPF varchar(19), @RG_IE varchar(19),  
@PEDIDO char(12), @FILIAL varchar(25), @PEDIDO_CLIENTE varchar(25), @CODIGO_TAB_PRECO char(2), @CONDICAO_PGTO char(3),  
@DESC_COND_PGTO varchar(40), @COLECAO char(6), @MOEDA char(6), @TRANSPORTADORA varchar(25),@REPRESENTANTE varchar(25), @EMISSAO char(10),  
@TOT_QTDE_ORIGINAL NUMERIC(15), @TOT_VALOR_ORIGINAL NUMERIC(17,2),@OBS VARCHAR(MAX), @PEDIDO_EXTERNO char(12),  
@GERENTE varchar(25) ,@EMAIL_CLI varchar(max) ,@EMAIL_GER varchar(max),@EMAIL_REP varchar(max);  

DECLARE @EMAIL_NFE varchar(max) 
  
declare curCapaPedido scroll cursor  
for SELECT B.CLIFOR,B.RAZAO_SOCIAL,B.ENDERECO,B.CIDADE,B.UF,B.NUMERO,  
       COMPLEMENTO=isnull(B.COMPLEMENTO,''),B.CEP,B.DDD1,B.TELEFONE1,B.CGC_CPF,B.RG_IE,  
     A.PEDIDO,A.FILIAL,A.PEDIDO_CLIENTE,A.CODIGO_TAB_PRECO,A.CONDICAO_PGTO,C.DESC_COND_PGTO,   
     A.COLECAO,A.MOEDA,A.TRANSPORTADORA,A.REPRESENTANTE,EMISSAO=CONVERT(CHAR(10),A.EMISSAO,103),  
     A.TOT_QTDE_ORIGINAL,A.TOT_VALOR_ORIGINAL,A.OBS,A.PEDIDO_EXTERNO,A.GERENTE,  
     EMAIL_CLI=RTRIM(B.EMAIL),EMAIL_GER=RTRIM(D.EMAIL),EMAIL_REP=RTRIM(E.EMAIL),EMAIL_NFE=isnull(RTRIM(B.EMAIL_NFE),'')  
 FROM VENDAS A with (nolock)  
 JOIN CADASTRO_CLI_FOR B with (nolock) ON B.NOME_CLIFOR = A.CLIENTE_ATACADO  
 JOIN COND_ATAC_PGTOS  C with (nolock) ON C.CONDICAO_PGTO = A.CONDICAO_PGTO  
 JOIN CADASTRO_CLI_FOR D with (nolock) ON D.NOME_CLIFOR = A.GERENTE  
 JOIN CADASTRO_CLI_FOR E with (nolock) ON E.NOME_CLIFOR = A.REPRESENTANTE  
 --WHERE PEDIDO=@NUMERO_PEDIDO AND PEDIDO_EXTERNO IS NOT NULL  
 WHERE PEDIDO='91191' AND PEDIDO_EXTERNO IS NOT NULL  


-- inicio: definir grade de tamanhos
DECLARE @SQLStr VARCHAR(5000), @GRADEStr VARCHAR(5000)
SET @SQLStr=''
SELECT @SQLStr=@SQLStr+'['+[asa].[Column]+'],'
FROM
(SELECT DISTINCT CONVERT(VARCHAR(4),GRADE) as [Column]
 FROM PRODUTOS_BARRA 
 JOIN VENDAS_PRODUTO ON VENDAS_PRODUTO.PRODUTO=PRODUTOS_BARRA.PRODUTO AND VENDAS_PRODUTO.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO
 WHERE VENDAS_PRODUTO.PEDIDO='91191' 
) asa
SET @GRADEStr=LEFT(@SQLStr,len(@SQLStr)-1)
-- fim 

-- inicio: corpo do email
SET @SQLStr = 'SELECT PRODUTO,COR_PRODUTO, DESC_PRODUTO,DESC_COR_PRODUTO,' + @GRADEStr + ',QTDE_ORIGINAL,PRECO1,DESCONTO_ITEM,VALOR_ORIGINAL,ENTREGA,LIMITE_ENTREGA FROM (
SELECT  VENDAS_PRODUTO.PRODUTO,  VENDAS_PRODUTO.COR_PRODUTO, DESC_PRODUTO,DESC_COR_PRODUTO,QTDE_ORIGINAL,PRECO1,DESCONTO_ITEM,VALOR_ORIGINAL,ENTREGA,LIMITE_ENTREGA, PRODUTOS_BARRA.GRADE,
QTDE = ISNULL(SUM(CASE WHEN PRODUTOS_BARRA.tamanho=''1''  THEN ISNULL(VENDAS_PRODUTO.Vo1,0)
                     WHEN PRODUTOS_BARRA.tamanho=''2''  THEN ISNULL(VENDAS_PRODUTO.Vo2,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''3''  THEN ISNULL(VENDAS_PRODUTO.Vo3,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''4''  THEN ISNULL(VENDAS_PRODUTO.Vo4,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''5''  THEN ISNULL(VENDAS_PRODUTO.Vo5,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''6''  THEN ISNULL(VENDAS_PRODUTO.Vo6,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''7''  THEN ISNULL(VENDAS_PRODUTO.Vo7,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''8''  THEN ISNULL(VENDAS_PRODUTO.Vo8,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''9''  THEN ISNULL(VENDAS_PRODUTO.Vo9,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''10'' THEN ISNULL(VENDAS_PRODUTO.Vo10,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''11'' THEN ISNULL(VENDAS_PRODUTO.Vo11,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''12'' THEN ISNULL(VENDAS_PRODUTO.Vo12,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''13'' THEN ISNULL(VENDAS_PRODUTO.Vo13,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''14'' THEN ISNULL(VENDAS_PRODUTO.Vo14,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''15'' THEN ISNULL(VENDAS_PRODUTO.Vo15,0) 
                     WHEN PRODUTOS_BARRA.tamanho=''16'' THEN ISNULL(VENDAS_PRODUTO.Vo16,0) 
                     END),0)
FROM PRODUTOS_BARRA PRODUTOS_BARRA 
JOIN PRODUTOS PRODUTOS ON PRODUTOS_BARRA.PRODUTO=PRODUTOS.PRODUTO 
JOIN PRODUTO_CORES PRODUTO_CORES ON PRODUTO_CORES.PRODUTO=PRODUTOS_BARRA.PRODUTO 
 AND PRODUTO_CORES.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO 
LEFT JOIN (SELECT * FROM VENDAS_PRODUTO) AS VENDAS_PRODUTO
  ON VENDAS_PRODUTO.PRODUTO=PRODUTOS_BARRA.PRODUTO 
 AND VENDAS_PRODUTO.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO 
JOIN VENDAS ON VENDAS.PEDIDO = VENDAS_PRODUTO.PEDIDO  
join PRODUTOS_TAMANHOS on PRODUTOS_TAMANHOS.GRADE=produtos.GRADE
WHERE PRODUTOS_BARRA.CODIGO_BARRA LIKE ''789%'' 
AND VENDAS_PRODUTO.QTDE_ENTREGAR>0 and vendas.PEDIDO=''91191''
GROUP BY   VENDAS_PRODUTO.PRODUTO,  VENDAS_PRODUTO.COR_PRODUTO, DESC_PRODUTO,DESC_COR_PRODUTO,QTDE_ORIGINAL,PRECO1,DESCONTO_ITEM,VALOR_ORIGINAL,ENTREGA,LIMITE_ENTREGA, PRODUTOS_BARRA.GRADE ) sq
PIVOT (SUM(QTDE) FOR grade IN ('+@GRADEStr+')) AS pt'
exec(@SQLStr)
-- fim

  
OPEN curCapaPedido  
FETCH NEXT FROM curCapaPedido INTO @CLIFOR,@RAZAO_SOCIAL,@ENDERECO,@CIDADE,@UF,@NUMERO,@COMPLEMENTO,@CEP,@DDD1,@TELEFONE1,@CGC_CPF,@RG_IE,@PEDIDO,@FILIAL,@PEDIDO_CLIENTE,@CODIGO_TAB_PRECO,@CONDICAO_PGTO,@DESC_COND_PGTO,@COLECAO,@MOEDA,@TRANSPORTADORA,@REPRESENTANTE,@EMISSAO,@TOT_QTDE_ORIGINAL,@TOT_VALOR_ORIGINAL,@OBS,@PEDIDO_EXTERNO,@GERENTE,@EMAIL_CLI,@EMAIL_GER,@EMAIL_REP,@EMAIL_NFE  
 
--SET @recipients=@EMAIL_CLI+';'+@EMAIL_REP
SET @p_copy_recipients = N'paulino.ti@drling.com.br'            
--SET @p_recipients = @recipients       
SET @obs_add = '[Os materiais promocionais relacionados nesta ordem de compra (cabides e sacos protetores), não serão cobrados no faturamento deste pedido. ] '  
  
WHILE @@fetch_status = 0  
BEGIN   
  
SET @tableHTML1 =       
    N'   <table border="0"> '+  
    N'        <tr>'+   
    N'        <td colspan="24">'+  
    N'    <table border="0" width="1500">'+  
    N'   <tr style="background-color: #000080; color: #FFFFFF;">'+  
    N'   <td colspan="2"><strong>D R LING INDÚSTRIA E COMÉRCIO S/A</strong></td>'+  
    N'      <td align="center" colspan="5"><strong>Pedido Cliente Atacado</strong></td>'+  
    N'          <td align="right" class="style17"><strong>Data:'+convert(char(10),getdate(),103)+'</strong></td>'+  
    N'   </tr>'+  
    N'   <tr>'+  
    N'          <td colspan="6"><strong>Razão Social: </strong>'+@CLIFOR+'-'+@RAZAO_SOCIAL+'</td>'+  
    N'          <td align="right"><strong>Pedido: </strong>'+@PEDIDO+'</td>'+  
    N'          <td align="right"><strong>Pedido Repre: </strong>'+@PEDIDO_EXTERNO+'</td>'+  
    N'   </tr>'+  
    N'   <tr>'+  
    N'          <td colspan="3"><strong>Endereço: </strong>'+RTRIM(@ENDERECO)+' <strong>Número: </strong>'+RTRIM(@NUMERO)+'</td>'+  
    N'          <td colspan="2"><strong>Tel: </strong>('+@DDD1+') '+@TELEFONE1+'</td>'+  
    N'          <td align="right" colspan="3"><strong>Cond.Pag: </strong>'+RTRIM(@CONDICAO_PGTO)+'-'+@DESC_COND_PGTO+'</td>'+  
    N'   </tr>'+  
    N'   <tr>'+  
    N'          <td colspan="2"><strong>Cidade: </strong>'+@CIDADE+'/'+@UF+'</td>'+  
    N'          <td><strong>Cep: </strong>'+@CEP+'</td>'+  
    N'          <td colspan="4"><strong>Emissão: </strong>'+CONVERT(CHAR(10),@EMISSAO,103)+'</td>'+  
    N'          <td align="right"><strong>Coleção: </strong>'+@COLECAO+'</td>'+  
    N'   </tr>'+  
    N'   <tr>'+  
    N'          <td colspan="2" class="style39"><strong>CNPJ/CPF: </strong>'+@CGC_CPF+'</td>'+  
    N'          <td colspan="2" class="style39"><strong>I.E.: </strong>'+@RG_IE+'</td>'+  
    N'          <td colspan="2" class="style39"><strong>Ped.Cl.: </strong>'+@PEDIDO_CLIENTE+'</td>'+  
    N'          <td class="style39"><strong>Tab Preço: </strong>'+@CODIGO_TAB_PRECO+'</td>'+  
    N'          <td align="right" class="style39"><strong>Moeda: </strong>'+@MOEDA+'</td>'+  
    N'   </tr>'+  
    N'   <tr>'+  
    N'          <td class="style38"><strong>Filial: </strong>'+@FILIAL+'</td>'+  
    N'          <td colspan="5"><strong>Transportadora: </strong>'+@TRANSPORTADORA+'</td>'+  
    N'          <td colspan="2"><strong>Representante: </strong>'+@REPRESENTANTE+'</td>'+  
    N'   </tr>'+  
    
    N'   <tr>'+  
    N'          <td class="style38"><strong>Contatos Eletrônicos: </strong></td>'+  
    N'          <td colspan="5"><strong>Email: </strong>'+@EMAIL_CLI+'</td>'+  
    N'          <td colspan="2"><strong>Email NFe: </strong>'+@EMAIL_NFE+'</td>'+  
    N'   </tr>'+  

    
    N'      </table>'+  
    N'          </td>'+  
    N'          </tr>';  
    
SET @tableHTML2 =   
    N'        <tr style="background-color: #000080; color: #FFFFFF;">'+  
    N'            <td><strong>Ref</strong></td>'+  
    N'            <td><strong>Cor</strong></td>'+  
    N'            <td><strong>Descrição Produto/Cor</strong></td>'+  
    N'            <td colspan="16"><strong>'+@GRADEStr+'</strong></td>'+  
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
             from vendas_produto a with (nolock)   
             join produtos b with (nolock) on b.produto=a.PRODUTO  
             join produto_cores c with (nolock) on c.PRODUTO = a.PRODUTO and c.COR_PRODUTO=a.COR_PRODUTO  
             join PRODUTOS_TAMANHOS d with (nolock) on d.GRADE = b.GRADE  
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
    N'            <td colspan="24"><strong>Observações:<H3>CASO NÃO RECEBA O BOLETO ATÉ O VENCIMENTO, FAVOR SOLICITAR.</H3></strong>'+@obs_add+@OBS+'</td>'+  
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
  
 FETCH NEXT FROM curCapaPedido INTO @CLIFOR,@RAZAO_SOCIAL,@ENDERECO,@CIDADE,@UF,@NUMERO,@COMPLEMENTO,@CEP,@DDD1,@TELEFONE1,@CGC_CPF,@RG_IE,@PEDIDO,@FILIAL,@PEDIDO_CLIENTE,@CODIGO_TAB_PRECO,@CONDICAO_PGTO,@DESC_COND_PGTO,@COLECAO,@MOEDA,@TRANSPORTADORA,@REPRESENTANTE,@EMISSAO,@TOT_QTDE_ORIGINAL,@TOT_VALOR_ORIGINAL,@OBS,@PEDIDO_EXTERNO,@GERENTE,@EMAIL_CLI,@EMAIL_GER,@EMAIL_REP,@EMAIL_NFE
   
END      
CLOSE curCapaPedido  
DEALLOCATE curCapaPedido  
  