 select a.produto,  
 a.COR_PRODUTO,  
 DESCRICAO=rtrim(b.DESC_PRODUTO)+'/'+RTRIM(c.DESC_COR_PRODUTO),  
 tm1=(case when a.vo1 > 0 then cast(a.vo1 as CHAR(5))+' '+RTRIM(d.TAMANHO_1) else '' end),
 tm2=(case when a.vo2 > 0 then cast(a.vo2 as CHAR(5))+' '+RTRIM(d.TAMANHO_2) else '' end),
 tm3=(case when a.vo3 > 0 then cast(a.vo3 as CHAR(5))+' '+RTRIM(d.TAMANHO_3) else '' end),
 tm4=(case when a.vo4 > 0 then cast(a.vo4 as CHAR(5))+' '+RTRIM(d.TAMANHO_4) else '' end),
 tm5=(case when a.vo5 > 0 then cast(a.vo5 as CHAR(5))+' '+RTRIM(d.TAMANHO_5) else '' end),
 tm6=(case when a.vo6 > 0 then cast(a.vo6 as CHAR(5))+' '+RTRIM(d.TAMANHO_6) else '' end),
 tm7=(case when a.vo7 > 0 then cast(a.vo7 as CHAR(5))+' '+RTRIM(d.TAMANHO_7) else '' end),
 tm8=(case when a.vo8 > 0 then cast(a.vo8 as CHAR(5))+' '+RTRIM(d.TAMANHO_8) else '' end),
 tm9=(case when a.vo9 > 0 then cast(a.vo9 as CHAR(5))+' '+RTRIM(d.TAMANHO_9) else '' end),
 tm10=(case when a.vo10 > 0 then cast(a.vo10 as CHAR(5))+' '+RTRIM(d.TAMANHO_10) else '' end),
 tm11=(case when a.vo11 > 0 then cast(a.vo11 as CHAR(5))+' '+RTRIM(d.TAMANHO_11) else '' end),
 tm12=(case when a.vo12 > 0 then cast(a.vo12 as CHAR(5))+' '+RTRIM(d.TAMANHO_12) else '' end),
 tm13=(case when a.vo13 > 0 then cast(a.vo13 as CHAR(5))+' '+RTRIM(d.TAMANHO_13) else '' end),
 tm14=(case when a.vo14 > 0 then cast(a.vo14 as CHAR(5))+' '+RTRIM(d.TAMANHO_14) else '' end),
 tm15=(case when a.vo15 > 0 then cast(a.vo15 as CHAR(5))+' '+RTRIM(d.TAMANHO_15) else '' end),
 tm16=(case when a.vo16 > 0 then cast(a.vo16 as CHAR(5))+' '+RTRIM(d.TAMANHO_16) else '' end),
 a.QTDE_ORIGINAL,  
 valor_unitario=(a.PRECO1-A.DESCONTO_ITEM),  
 a.VALOR_ORIGINAL,  
 faturamento=CONVERT(CHAR(10),a.ENTREGA,103),  
 limite=CONVERT(CHAR(10),a.LIMITE_ENTREGA,103)
 from drvarejo.dbo.vendas_produto a  
 join drvarejo.dbo.produtos b on b.produto=a.PRODUTO
 join drvarejo.dbo.produto_cores c on c.PRODUTO = a.PRODUTO and c.COR_PRODUTO=a.COR_PRODUTO
 join DRVAREJO.dbo.PRODUTOS_TAMANHOS d on d.GRADE = b.GRADE
 WHERE a.PEDIDO='555450'
 order by a.PRODUTO
             

Create Procedure SP_SFV_REL_PEDIDO_GRADE
@pedido_externo char(12)
as 
Select vl.REPRESENTANTE,
       clf.CGC_CPF,
       vl.CLIENTE_ATACADO As CLIENTE,
       clf.RAZAO_SOCIAL,
       vl.PEDIDO_EXTERNO As PEDIDO,
       vl.EMISSAO,
       vl.NUMERO_ENTREGA
       + ' => ' +
       CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
       ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
       RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
       vl.PORC_DESCONTO As PCT_DESCONTO,
       vl.PEDIDO_CLIENTE,
       vl.OBS,
       vlp.PRODUTO,
       prd.DESC_PRODUTO,
       vlp.COR_PRODUTO,
       tm1=(case when vlp.vo1 > 0 then cast(vlp.vo1 as CHAR(5))+' '+RTRIM(ptm.TAMANHO_1) else '' end),
	   tm2=(case when vlp.vo2 > 0 then cast(vlp.vo2 as CHAR(5))+' '+RTRIM(ptm.TAMANHO_2) else '' end),
	   tm3=(case when vlp.vo3 > 0 then cast(vlp.vo3 as CHAR(5))+' '+RTRIM(ptm.TAMANHO_3) else '' end),
	   tm4=(case when vlp.vo4 > 0 then cast(vlp.vo4 as CHAR(5))+' '+RTRIM(ptm.TAMANHO_4) else '' end),
	   tm5=(case when vlp.vo5 > 0 then cast(vlp.vo5 as CHAR(5))+' '+RTRIM(ptm.TAMANHO_5) else '' end),
	   tm6=(case when vlp.vo6 > 0 then cast(vlp.vo6 as CHAR(5))+' '+RTRIM(ptm.TAMANHO_6) else '' end),
	   tm7=(case when vlp.vo7 > 0 then cast(vlp.vo7 as CHAR(5))+' '+RTRIM(ptm.TAMANHO_7) else '' end),
	   tm8=(case when vlp.vo8 > 0 then cast(vlp.vo8 as CHAR(5))+' '+RTRIM(ptm.TAMANHO_8) else '' end),
       tm9=(case when vlp.vo9 > 0 then cast(vlp.vo9 as CHAR(5))+' '+RTRIM(ptm.TAMANHO_9) else '' end),
	   tm10=(case when vlp.vo10 > 0 then cast(vlp.vo10 as CHAR(5))+' '+RTRIM(ptm.TAMANHO_10) else '' end),
	   tm11=(case when vlp.vo11 > 0 then cast(vlp.vo11 as CHAR(5))+' '+RTRIM(ptm.TAMANHO_11) else '' end),
	   tm12=(case when vlp.vo12 > 0 then cast(vlp.vo12 as CHAR(5))+' '+RTRIM(ptm.TAMANHO_12) else '' end),
	   tm13=(case when vlp.vo13 > 0 then cast(vlp.vo13 as CHAR(5))+' '+RTRIM(ptm.TAMANHO_13) else '' end),
	   tm14=(case when vlp.vo14 > 0 then cast(vlp.vo14 as CHAR(5))+' '+RTRIM(ptm.TAMANHO_14) else '' end),
	   tm15=(case when vlp.vo15 > 0 then cast(vlp.vo15 as CHAR(5))+' '+RTRIM(ptm.TAMANHO_15) else '' end),
	   tm16=(case when vlp.vo16 > 0 then cast(vlp.vo16 as CHAR(5))+' '+RTRIM(ptm.TAMANHO_16) else '' end),
       vlp.QTDE_ORIGINAL As QTDE,
       vlp.PRECO1 As PRECO,
       vlp.VO1 * vlp.PRECO1 As VALOR,
       vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
       vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
       ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
       ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
  From VENDAS_LOTE vl,
       CADASTRO_CLI_FOR clf,
       FORMA_PGTO fmp,
       VENDAS_LOTE_PROD vlp,
       PRODUTOS prd,
       PRODUTOS_TAMANHOS ptm
 Where vl.PEDIDO_EXTERNO =  @pedido_externo --'0020z.001156'
   And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
   And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
   And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
   And prd.PRODUTO = vlp.PRODUTO
   And ptm.GRADE = prd.GRADE




             
Select REPRESENTANTE, CGC_CPF, CLIENTE, RAZAO_SOCIAL, 
       PERIODO_FATURAMENTO, FORMA_PGTO, PCT_DESCONTO, PEDIDO_CLIENTE, OBS,
       PEDIDO, EMISSAO,
       PRODUTO, DESC_PRODUTO, COR_PRODUTO, TAMANHO, QTDE, PRECO, VALOR,
       QTDE_TOTAL, VALOR_TOTAL, VALOR_DESCONTO, VALOR_LIQUIDO
  From (Select vl.REPRESENTANTE,
               clf.CGC_CPF,
               vl.CLIENTE_ATACADO As CLIENTE,
               clf.RAZAO_SOCIAL,
               vl.PEDIDO_EXTERNO As PEDIDO,
               vl.EMISSAO,
               vl.NUMERO_ENTREGA
               + ' => ' +
               CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
               ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
               RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
               vl.PORC_DESCONTO As PCT_DESCONTO,
               vl.PEDIDO_CLIENTE,
               vl.OBS,
               vlp.PRODUTO,
               prd.DESC_PRODUTO,
               vlp.COR_PRODUTO,
               ptm.TAMANHO_1 As TAMANHO,
               vlp.VO1 As QTDE,
               vlp.PRECO1 As PRECO,
               vlp.VO1 * vlp.PRECO1 As VALOR,
               vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
               vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
               ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
               ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
          From VENDAS_LOTE vl,
               CADASTRO_CLI_FOR clf,
               FORMA_PGTO fmp,
               VENDAS_LOTE_PROD vlp,
               PRODUTOS prd,
               PRODUTOS_TAMANHOS ptm
         Where vl.PEDIDO_EXTERNO = '0020z.001156'
           And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
           And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
           And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
           And prd.PRODUTO = vlp.PRODUTO
           And ptm.GRADE = prd.GRADE
        ) As GRADE_1
        Where QTDE > 0

UNION ALL

Select REPRESENTANTE, CGC_CPF, CLIENTE, RAZAO_SOCIAL, 
       PERIODO_FATURAMENTO, FORMA_PGTO, PCT_DESCONTO, PEDIDO_CLIENTE, OBS,
       PEDIDO, EMISSAO,
       PRODUTO, DESC_PRODUTO, COR_PRODUTO, TAMANHO, QTDE, PRECO, VALOR,
       QTDE_TOTAL, VALOR_TOTAL, VALOR_DESCONTO, VALOR_LIQUIDO
  From (Select vl.REPRESENTANTE,
               clf.CGC_CPF,
               vl.CLIENTE_ATACADO As CLIENTE,
               clf.RAZAO_SOCIAL,
               vl.PEDIDO_EXTERNO As PEDIDO,
               vl.EMISSAO,
               vl.NUMERO_ENTREGA
               + ' => ' +
               CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
               ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
               RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
               vl.PORC_DESCONTO As PCT_DESCONTO,
               vl.PEDIDO_CLIENTE,
               vl.OBS,
               vlp.PRODUTO,
               prd.DESC_PRODUTO,
               vlp.COR_PRODUTO,
               ptm.TAMANHO_2 As TAMANHO,
               vlp.VO2 As QTDE,
               vlp.PRECO1 As PRECO,
               vlp.VO2 * vlp.PRECO1 As VALOR,
               vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
               vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
               ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
               ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
          From VENDAS_LOTE vl,
               CADASTRO_CLI_FOR clf,
               FORMA_PGTO fmp,
               VENDAS_LOTE_PROD vlp,
               PRODUTOS prd,
               PRODUTOS_TAMANHOS ptm
         Where vl.PEDIDO_EXTERNO = '0020z.001156'
           And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
           And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
           And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
           And prd.PRODUTO = vlp.PRODUTO
           And ptm.GRADE = prd.GRADE
        ) As GRADE_2
        Where QTDE > 0

UNION ALL

Select REPRESENTANTE, CGC_CPF, CLIENTE, RAZAO_SOCIAL, 
       PERIODO_FATURAMENTO, FORMA_PGTO, PCT_DESCONTO, PEDIDO_CLIENTE, OBS,
       PEDIDO, EMISSAO,
       PRODUTO, DESC_PRODUTO, COR_PRODUTO, TAMANHO, QTDE, PRECO, VALOR,
       QTDE_TOTAL, VALOR_TOTAL, VALOR_DESCONTO, VALOR_LIQUIDO
  From (Select vl.REPRESENTANTE,
               clf.CGC_CPF,
               vl.CLIENTE_ATACADO As CLIENTE,
               clf.RAZAO_SOCIAL,
               vl.PEDIDO_EXTERNO As PEDIDO,
               vl.EMISSAO,
               vl.NUMERO_ENTREGA
               + ' => ' +
               CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
               ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
               RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
               vl.PORC_DESCONTO As PCT_DESCONTO,
               vl.PEDIDO_CLIENTE,
               vl.OBS,
               vlp.PRODUTO,
               prd.DESC_PRODUTO,
               vlp.COR_PRODUTO,
               ptm.TAMANHO_3 As TAMANHO,
               vlp.VO3 As QTDE,
               vlp.PRECO1 As PRECO,
               vlp.VO3 * vlp.PRECO1 As VALOR,
               vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
               vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
               ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
               ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
          From VENDAS_LOTE vl,
               CADASTRO_CLI_FOR clf,
               FORMA_PGTO fmp,
               VENDAS_LOTE_PROD vlp,
               PRODUTOS prd,
               PRODUTOS_TAMANHOS ptm
         Where vl.PEDIDO_EXTERNO = '0020z.001156'
           And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
           And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
           And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
           And prd.PRODUTO = vlp.PRODUTO
           And ptm.GRADE = prd.GRADE
        ) As GRADE_3
        Where QTDE > 0

UNION ALL

Select REPRESENTANTE, CGC_CPF, CLIENTE, RAZAO_SOCIAL, 
       PERIODO_FATURAMENTO, FORMA_PGTO, PCT_DESCONTO, PEDIDO_CLIENTE, OBS,
       PEDIDO, EMISSAO,
       PRODUTO, DESC_PRODUTO, COR_PRODUTO, TAMANHO, QTDE, PRECO, VALOR,
       QTDE_TOTAL, VALOR_TOTAL, VALOR_DESCONTO, VALOR_LIQUIDO
  From (Select vl.REPRESENTANTE,
               clf.CGC_CPF,
               vl.CLIENTE_ATACADO As CLIENTE,
               clf.RAZAO_SOCIAL,
               vl.PEDIDO_EXTERNO As PEDIDO,
               vl.EMISSAO,
               vl.NUMERO_ENTREGA
               + ' => ' +
               CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
               ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
               RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
               vl.PORC_DESCONTO As PCT_DESCONTO,
               vl.PEDIDO_CLIENTE,
               vl.OBS,
               vlp.PRODUTO,
               prd.DESC_PRODUTO,
               vlp.COR_PRODUTO,
               ptm.TAMANHO_4 As TAMANHO,
               vlp.VO4 As QTDE,
               vlp.PRECO1 As PRECO,
               vlp.VO4 * vlp.PRECO1 As VALOR,
               vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
               vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
               ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
               ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
          From VENDAS_LOTE vl,
               CADASTRO_CLI_FOR clf,
               FORMA_PGTO fmp,
               VENDAS_LOTE_PROD vlp,
               PRODUTOS prd,
               PRODUTOS_TAMANHOS ptm
         Where vl.PEDIDO_EXTERNO = '0020z.001156'
           And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
           And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
           And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
           And prd.PRODUTO = vlp.PRODUTO
           And ptm.GRADE = prd.GRADE
        ) As GRADE_4
        Where QTDE > 0

UNION ALL

Select REPRESENTANTE, CGC_CPF, CLIENTE, RAZAO_SOCIAL, 
       PERIODO_FATURAMENTO, FORMA_PGTO, PCT_DESCONTO, PEDIDO_CLIENTE, OBS,
       PEDIDO, EMISSAO,
       PRODUTO, DESC_PRODUTO, COR_PRODUTO, TAMANHO, QTDE, PRECO, VALOR,
       QTDE_TOTAL, VALOR_TOTAL, VALOR_DESCONTO, VALOR_LIQUIDO
  From (Select vl.REPRESENTANTE,
               clf.CGC_CPF,
               vl.CLIENTE_ATACADO As CLIENTE,
               clf.RAZAO_SOCIAL,
               vl.PEDIDO_EXTERNO As PEDIDO,
               vl.EMISSAO,
               vl.NUMERO_ENTREGA
               + ' => ' +
               CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
               ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
               RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
               vl.PORC_DESCONTO As PCT_DESCONTO,
               vl.PEDIDO_CLIENTE,
               vl.OBS,
               vlp.PRODUTO,
               prd.DESC_PRODUTO,
               vlp.COR_PRODUTO,
               ptm.TAMANHO_5 As TAMANHO,
               vlp.VO5 As QTDE,
               vlp.PRECO1 As PRECO,
               vlp.VO5 * vlp.PRECO1 As VALOR,
               vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
               vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
               ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
               ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
          From VENDAS_LOTE vl,
               CADASTRO_CLI_FOR clf,
               FORMA_PGTO fmp,
               VENDAS_LOTE_PROD vlp,
               PRODUTOS prd,
               PRODUTOS_TAMANHOS ptm
         Where vl.PEDIDO_EXTERNO = '0020z.001156'
           And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
           And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
           And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
           And prd.PRODUTO = vlp.PRODUTO
           And ptm.GRADE = prd.GRADE
        ) As GRADE_5
        Where QTDE > 0

UNION ALL

Select REPRESENTANTE, CGC_CPF, CLIENTE, RAZAO_SOCIAL, 
       PERIODO_FATURAMENTO, FORMA_PGTO, PCT_DESCONTO, PEDIDO_CLIENTE, OBS,
       PEDIDO, EMISSAO,
       PRODUTO, DESC_PRODUTO, COR_PRODUTO, TAMANHO, QTDE, PRECO, VALOR,
       QTDE_TOTAL, VALOR_TOTAL, VALOR_DESCONTO, VALOR_LIQUIDO
  From (Select vl.REPRESENTANTE,
               clf.CGC_CPF,
               vl.CLIENTE_ATACADO As CLIENTE,
               clf.RAZAO_SOCIAL,
               vl.PEDIDO_EXTERNO As PEDIDO,
               vl.EMISSAO,
               vl.NUMERO_ENTREGA
               + ' => ' +
               CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
               ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
               RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
               vl.PORC_DESCONTO As PCT_DESCONTO,
               vl.PEDIDO_CLIENTE,
               vl.OBS,
               vlp.PRODUTO,
               prd.DESC_PRODUTO,
               vlp.COR_PRODUTO,
               ptm.TAMANHO_6 As TAMANHO,
               vlp.VO6 As QTDE,
               vlp.PRECO1 As PRECO,
               vlp.VO6 * vlp.PRECO1 As VALOR,
               vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
               vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
               ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
               ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
          From VENDAS_LOTE vl,
               CADASTRO_CLI_FOR clf,
               FORMA_PGTO fmp,
               VENDAS_LOTE_PROD vlp,
               PRODUTOS prd,
               PRODUTOS_TAMANHOS ptm
         Where vl.PEDIDO_EXTERNO = '0020z.001156'
           And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
           And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
           And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
           And prd.PRODUTO = vlp.PRODUTO
           And ptm.GRADE = prd.GRADE
        ) As GRADE_6
        Where QTDE > 0

UNION ALL

Select REPRESENTANTE, CGC_CPF, CLIENTE, RAZAO_SOCIAL, 
       PERIODO_FATURAMENTO, FORMA_PGTO, PCT_DESCONTO, PEDIDO_CLIENTE, OBS,
       PEDIDO, EMISSAO,
       PRODUTO, DESC_PRODUTO, COR_PRODUTO, TAMANHO, QTDE, PRECO, VALOR,
       QTDE_TOTAL, VALOR_TOTAL, VALOR_DESCONTO, VALOR_LIQUIDO
  From (Select vl.REPRESENTANTE,
               clf.CGC_CPF,
               vl.CLIENTE_ATACADO As CLIENTE,
               clf.RAZAO_SOCIAL,
               vl.PEDIDO_EXTERNO As PEDIDO,
               vl.EMISSAO,
               vl.NUMERO_ENTREGA
               + ' => ' +
               CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
               ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
               RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
               vl.PORC_DESCONTO As PCT_DESCONTO,
               vl.PEDIDO_CLIENTE,
               vl.OBS,
               vlp.PRODUTO,
               prd.DESC_PRODUTO,
               vlp.COR_PRODUTO,
               ptm.TAMANHO_7 As TAMANHO,
               vlp.VO7 As QTDE,
               vlp.PRECO1 As PRECO,
               vlp.VO7 * vlp.PRECO1 As VALOR,
               vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
               vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
               ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
               ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
          From VENDAS_LOTE vl,
               CADASTRO_CLI_FOR clf,
               FORMA_PGTO fmp,
               VENDAS_LOTE_PROD vlp,
               PRODUTOS prd,
               PRODUTOS_TAMANHOS ptm
         Where vl.PEDIDO_EXTERNO = '0020z.001156'
           And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
           And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
           And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
           And prd.PRODUTO = vlp.PRODUTO
           And ptm.GRADE = prd.GRADE
        ) As GRADE_7
        Where QTDE > 0

UNION ALL

Select REPRESENTANTE, CGC_CPF, CLIENTE, RAZAO_SOCIAL, 
       PERIODO_FATURAMENTO, FORMA_PGTO, PCT_DESCONTO, PEDIDO_CLIENTE, OBS,
       PEDIDO, EMISSAO,
       PRODUTO, DESC_PRODUTO, COR_PRODUTO, TAMANHO, QTDE, PRECO, VALOR,
       QTDE_TOTAL, VALOR_TOTAL, VALOR_DESCONTO, VALOR_LIQUIDO
  From (Select vl.REPRESENTANTE,
               clf.CGC_CPF,
               vl.CLIENTE_ATACADO As CLIENTE,
               clf.RAZAO_SOCIAL,
               vl.PEDIDO_EXTERNO As PEDIDO,
               vl.EMISSAO,
               vl.NUMERO_ENTREGA
               + ' => ' +
               CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
               ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
               RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
               vl.PORC_DESCONTO As PCT_DESCONTO,
               vl.PEDIDO_CLIENTE,
               vl.OBS,
               vlp.PRODUTO,
               prd.DESC_PRODUTO,
               vlp.COR_PRODUTO,
               ptm.TAMANHO_8 As TAMANHO,
               vlp.VO8 As QTDE,
               vlp.PRECO1 As PRECO,
               vlp.VO8 * vlp.PRECO1 As VALOR,
               vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
               vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
               ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
               ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
          From VENDAS_LOTE vl,
               CADASTRO_CLI_FOR clf,
               FORMA_PGTO fmp,
               VENDAS_LOTE_PROD vlp,
               PRODUTOS prd,
               PRODUTOS_TAMANHOS ptm
         Where vl.PEDIDO_EXTERNO = '0020z.001156'
           And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
           And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
           And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
           And prd.PRODUTO = vlp.PRODUTO
           And ptm.GRADE = prd.GRADE
        ) As GRADE_8
        Where QTDE > 0

UNION ALL

Select REPRESENTANTE, CGC_CPF, CLIENTE, RAZAO_SOCIAL, 
       PERIODO_FATURAMENTO, FORMA_PGTO, PCT_DESCONTO, PEDIDO_CLIENTE, OBS,
       PEDIDO, EMISSAO,
       PRODUTO, DESC_PRODUTO, COR_PRODUTO, TAMANHO, QTDE, PRECO, VALOR,
       QTDE_TOTAL, VALOR_TOTAL, VALOR_DESCONTO, VALOR_LIQUIDO
  From (Select vl.REPRESENTANTE,
               clf.CGC_CPF,
               vl.CLIENTE_ATACADO As CLIENTE,
               clf.RAZAO_SOCIAL,
               vl.PEDIDO_EXTERNO As PEDIDO,
               vl.EMISSAO,
               vl.NUMERO_ENTREGA
               + ' => ' +
               CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
               ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
               RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
               vl.PORC_DESCONTO As PCT_DESCONTO,
               vl.PEDIDO_CLIENTE,
               vl.OBS,
               vlp.PRODUTO,
               prd.DESC_PRODUTO,
               vlp.COR_PRODUTO,
               ptm.TAMANHO_9 As TAMANHO,
               vlp.VO9 As QTDE,
               vlp.PRECO1 As PRECO,
               vlp.VO9 * vlp.PRECO1 As VALOR,
               vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
               vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
               ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
               ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
          From VENDAS_LOTE vl,
               CADASTRO_CLI_FOR clf,
               FORMA_PGTO fmp,
               VENDAS_LOTE_PROD vlp,
               PRODUTOS prd,
               PRODUTOS_TAMANHOS ptm
         Where vl.PEDIDO_EXTERNO = '0020z.001156'
           And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
           And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
           And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
           And prd.PRODUTO = vlp.PRODUTO
           And ptm.GRADE = prd.GRADE
        ) As GRADE_9
        Where QTDE > 0

UNION ALL

Select REPRESENTANTE, CGC_CPF, CLIENTE, RAZAO_SOCIAL, 
       PERIODO_FATURAMENTO, FORMA_PGTO, PCT_DESCONTO, PEDIDO_CLIENTE, OBS,
       PEDIDO, EMISSAO,
       PRODUTO, DESC_PRODUTO, COR_PRODUTO, TAMANHO, QTDE, PRECO, VALOR,
       QTDE_TOTAL, VALOR_TOTAL, VALOR_DESCONTO, VALOR_LIQUIDO
  From (Select vl.REPRESENTANTE,
               clf.CGC_CPF,
               vl.CLIENTE_ATACADO As CLIENTE,
               clf.RAZAO_SOCIAL,
               vl.PEDIDO_EXTERNO As PEDIDO,
               vl.EMISSAO,
               vl.NUMERO_ENTREGA
               + ' => ' +
               CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
               ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
               RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
               vl.PORC_DESCONTO As PCT_DESCONTO,
               vl.PEDIDO_CLIENTE,
               vl.OBS,
               vlp.PRODUTO,
               prd.DESC_PRODUTO,
               vlp.COR_PRODUTO,
               ptm.TAMANHO_10 As TAMANHO,
               vlp.VO10 As QTDE,
               vlp.PRECO1 As PRECO,
               vlp.VO10 * vlp.PRECO1 As VALOR,
               vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
               vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
               ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
               ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
          From VENDAS_LOTE vl,
               CADASTRO_CLI_FOR clf,
               FORMA_PGTO fmp,
               VENDAS_LOTE_PROD vlp,
               PRODUTOS prd,
               PRODUTOS_TAMANHOS ptm
         Where vl.PEDIDO_EXTERNO = '0020z.001156'
           And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
           And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
           And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
           And prd.PRODUTO = vlp.PRODUTO
           And ptm.GRADE = prd.GRADE
        ) As GRADE_10
        Where QTDE > 0

UNION ALL

Select REPRESENTANTE, CGC_CPF, CLIENTE, RAZAO_SOCIAL, 
       PERIODO_FATURAMENTO, FORMA_PGTO, PCT_DESCONTO, PEDIDO_CLIENTE, OBS,
       PEDIDO, EMISSAO,
       PRODUTO, DESC_PRODUTO, COR_PRODUTO, TAMANHO, QTDE, PRECO, VALOR,
       QTDE_TOTAL, VALOR_TOTAL, VALOR_DESCONTO, VALOR_LIQUIDO
  From (Select vl.REPRESENTANTE,
               clf.CGC_CPF,
               vl.CLIENTE_ATACADO As CLIENTE,
               clf.RAZAO_SOCIAL,
               vl.PEDIDO_EXTERNO As PEDIDO,
               vl.EMISSAO,
               vl.NUMERO_ENTREGA
               + ' => ' +
               CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
               ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
               RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
               vl.PORC_DESCONTO As PCT_DESCONTO,
               vl.PEDIDO_CLIENTE,
               vl.OBS,
               vlp.PRODUTO,
               prd.DESC_PRODUTO,
               vlp.COR_PRODUTO,
               ptm.TAMANHO_11 As TAMANHO,
               vlp.VO11 As QTDE,
               vlp.PRECO1 As PRECO,
               vlp.VO11 * vlp.PRECO1 As VALOR,
               vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
               vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
               ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
               ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
          From VENDAS_LOTE vl,
               CADASTRO_CLI_FOR clf,
               FORMA_PGTO fmp,
               VENDAS_LOTE_PROD vlp,
               PRODUTOS prd,
               PRODUTOS_TAMANHOS ptm
         Where vl.PEDIDO_EXTERNO = '0020z.001156'
           And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
           And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
           And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
           And prd.PRODUTO = vlp.PRODUTO
           And ptm.GRADE = prd.GRADE
        ) As GRADE_11
        Where QTDE > 0

UNION ALL

Select REPRESENTANTE, CGC_CPF, CLIENTE, RAZAO_SOCIAL, 
       PERIODO_FATURAMENTO, FORMA_PGTO, PCT_DESCONTO, PEDIDO_CLIENTE, OBS,
       PEDIDO, EMISSAO,
       PRODUTO, DESC_PRODUTO, COR_PRODUTO, TAMANHO, QTDE, PRECO, VALOR,
       QTDE_TOTAL, VALOR_TOTAL, VALOR_DESCONTO, VALOR_LIQUIDO
  From (Select vl.REPRESENTANTE,
               clf.CGC_CPF,
               vl.CLIENTE_ATACADO As CLIENTE,
               clf.RAZAO_SOCIAL,
               vl.PEDIDO_EXTERNO As PEDIDO,
               vl.EMISSAO,
               vl.NUMERO_ENTREGA
               + ' => ' +
               CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
               ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
               RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
               vl.PORC_DESCONTO As PCT_DESCONTO,
               vl.PEDIDO_CLIENTE,
               vl.OBS,
               vlp.PRODUTO,
               prd.DESC_PRODUTO,
               vlp.COR_PRODUTO,
               ptm.TAMANHO_12 As TAMANHO,
               vlp.VO12 As QTDE,
               vlp.PRECO1 As PRECO,
               vlp.VO12 * vlp.PRECO1 As VALOR,
               vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
               vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
               ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
               ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
          From VENDAS_LOTE vl,
               CADASTRO_CLI_FOR clf,
               FORMA_PGTO fmp,
               VENDAS_LOTE_PROD vlp,
               PRODUTOS prd,
               PRODUTOS_TAMANHOS ptm
         Where vl.PEDIDO_EXTERNO = '0020z.001156'
           And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
           And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
           And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
           And prd.PRODUTO = vlp.PRODUTO
           And ptm.GRADE = prd.GRADE
        ) As GRADE_12
        Where QTDE > 0

UNION ALL

Select REPRESENTANTE, CGC_CPF, CLIENTE, RAZAO_SOCIAL, 
       PERIODO_FATURAMENTO, FORMA_PGTO, PCT_DESCONTO, PEDIDO_CLIENTE, OBS,
       PEDIDO, EMISSAO,
       PRODUTO, DESC_PRODUTO, COR_PRODUTO, TAMANHO, QTDE, PRECO, VALOR,
       QTDE_TOTAL, VALOR_TOTAL, VALOR_DESCONTO, VALOR_LIQUIDO
  From (Select vl.REPRESENTANTE,
               clf.CGC_CPF,
               vl.CLIENTE_ATACADO As CLIENTE,
               clf.RAZAO_SOCIAL,
               vl.PEDIDO_EXTERNO As PEDIDO,
               vl.EMISSAO,
               vl.NUMERO_ENTREGA
               + ' => ' +
               CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
               ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
               RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
               vl.PORC_DESCONTO As PCT_DESCONTO,
               vl.PEDIDO_CLIENTE,
               vl.OBS,
               vlp.PRODUTO,
               prd.DESC_PRODUTO,
               vlp.COR_PRODUTO,
               ptm.TAMANHO_13 As TAMANHO,
               vlp.VO13 As QTDE,
               vlp.PRECO1 As PRECO,
               vlp.VO13 * vlp.PRECO1 As VALOR,
               vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
               vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
               ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
               ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
          From VENDAS_LOTE vl,
               CADASTRO_CLI_FOR clf,
               FORMA_PGTO fmp,
               VENDAS_LOTE_PROD vlp,
               PRODUTOS prd,
               PRODUTOS_TAMANHOS ptm
         Where vl.PEDIDO_EXTERNO = '0020z.001156'
           And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
           And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
           And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
           And prd.PRODUTO = vlp.PRODUTO
           And ptm.GRADE = prd.GRADE
        ) As GRADE_13
        Where QTDE > 0

UNION ALL

Select REPRESENTANTE, CGC_CPF, CLIENTE, RAZAO_SOCIAL, 
       PERIODO_FATURAMENTO, FORMA_PGTO, PCT_DESCONTO, PEDIDO_CLIENTE, OBS,
       PEDIDO, EMISSAO, 
       PRODUTO, DESC_PRODUTO, COR_PRODUTO, TAMANHO, QTDE, PRECO, VALOR,
       QTDE_TOTAL, VALOR_TOTAL, VALOR_DESCONTO, VALOR_LIQUIDO
  From (Select vl.REPRESENTANTE,
               clf.CGC_CPF,
               vl.CLIENTE_ATACADO As CLIENTE,
               clf.RAZAO_SOCIAL,
               vl.PEDIDO_EXTERNO As PEDIDO,
               vl.EMISSAO,
               vl.NUMERO_ENTREGA
               + ' => ' +
               CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
               ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
               RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
               vl.PORC_DESCONTO As PCT_DESCONTO,
               vl.PEDIDO_CLIENTE,
               vl.OBS,
               vlp.PRODUTO,
               prd.DESC_PRODUTO,
               vlp.COR_PRODUTO,
               ptm.TAMANHO_14 As TAMANHO,
               vlp.VO14 As QTDE,
               vlp.PRECO1 As PRECO,
               vlp.VO14 * vlp.PRECO1 As VALOR,
               vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
               vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
               ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
               ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
          From VENDAS_LOTE vl,
               CADASTRO_CLI_FOR clf,
               FORMA_PGTO fmp,
               VENDAS_LOTE_PROD vlp,
               PRODUTOS prd,
               PRODUTOS_TAMANHOS ptm
         Where vl.PEDIDO_EXTERNO = '0020z.001156'
           And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
           And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
           And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
           And prd.PRODUTO = vlp.PRODUTO
           And ptm.GRADE = prd.GRADE
        ) As GRADE_14
        Where QTDE > 0

UNION ALL

Select REPRESENTANTE, CGC_CPF, CLIENTE, RAZAO_SOCIAL, 
       PERIODO_FATURAMENTO, FORMA_PGTO, PCT_DESCONTO, PEDIDO_CLIENTE, OBS,
       PEDIDO, EMISSAO,
       PRODUTO, DESC_PRODUTO, COR_PRODUTO, TAMANHO, QTDE, PRECO, VALOR,
       QTDE_TOTAL, VALOR_TOTAL, VALOR_DESCONTO, VALOR_LIQUIDO
  From (Select vl.REPRESENTANTE,
               clf.CGC_CPF,
               vl.CLIENTE_ATACADO As CLIENTE,
               clf.RAZAO_SOCIAL,
               vl.PEDIDO_EXTERNO As PEDIDO,
               vl.EMISSAO,
               vl.NUMERO_ENTREGA
               + ' => ' +
               CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
               ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
               RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
               vl.PORC_DESCONTO As PCT_DESCONTO,
               vl.PEDIDO_CLIENTE,
               vl.OBS,
               vlp.PRODUTO,
               prd.DESC_PRODUTO,
               vlp.COR_PRODUTO,
               ptm.TAMANHO_15 As TAMANHO,
               vlp.VO15 As QTDE,
               vlp.PRECO1 As PRECO,
               vlp.VO15 * vlp.PRECO1 As VALOR,
               vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
               vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
               ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
               ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
          From VENDAS_LOTE vl,
               CADASTRO_CLI_FOR clf,
               FORMA_PGTO fmp,
               VENDAS_LOTE_PROD vlp,
               PRODUTOS prd,
               PRODUTOS_TAMANHOS ptm
         Where vl.PEDIDO_EXTERNO = '0020z.001156'
           And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
           And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
           And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
           And prd.PRODUTO = vlp.PRODUTO
           And ptm.GRADE = prd.GRADE
        ) As GRADE_15
        Where QTDE > 0

UNION ALL

Select REPRESENTANTE, CGC_CPF, CLIENTE, RAZAO_SOCIAL, 
       PERIODO_FATURAMENTO, FORMA_PGTO, PCT_DESCONTO, PEDIDO_CLIENTE, OBS,
       PEDIDO, EMISSAO,
       PRODUTO, DESC_PRODUTO, COR_PRODUTO, TAMANHO, QTDE, PRECO, VALOR,
       QTDE_TOTAL, VALOR_TOTAL, VALOR_DESCONTO, VALOR_LIQUIDO
  From (Select vl.REPRESENTANTE,
               clf.CGC_CPF,
               vl.CLIENTE_ATACADO As CLIENTE,
               clf.RAZAO_SOCIAL,
               vl.PEDIDO_EXTERNO As PEDIDO,
               vl.EMISSAO,
               vl.NUMERO_ENTREGA
               + ' => ' +
               CONVERT(VarChar(10), vlp.ENTREGA,103) + ' até ' + + CONVERT(VarChar(10), vlp.LIMITE_ENTREGA,103) +
               ' - ' + vl.PERIODO_PCP As PERIODO_FATURAMENTO,
               RTRIM(vl.CONDICAO_PGTO) + ' => ' + fmp.DESC_COND_PGTO As FORMA_PGTO,
               vl.PORC_DESCONTO As PCT_DESCONTO,
               vl.PEDIDO_CLIENTE,
               vl.OBS,
               vlp.PRODUTO,
               prd.DESC_PRODUTO,
               vlp.COR_PRODUTO,
               ptm.TAMANHO_16 As TAMANHO,
               vlp.VO16 As QTDE,
               vlp.PRECO1 As PRECO,
               vlp.VO16 * vlp.PRECO1 As VALOR,
               vl.TOT_QTDE_ORIGINAL As QTDE_TOTAL,
               vl.TOT_VALOR_ORIGINAL As VALOR_TOTAL,
               ROUND(vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100, 2) As VALOR_DESCONTO,
               ROUND(vl.TOT_VALOR_ORIGINAL - (vl.TOT_VALOR_ORIGINAL * vl.PORC_DESCONTO / 100),2) As VALOR_LIQUIDO
          From VENDAS_LOTE vl,
               CADASTRO_CLI_FOR clf,
               FORMA_PGTO fmp,
               VENDAS_LOTE_PROD vlp,
               PRODUTOS prd,
               PRODUTOS_TAMANHOS ptm
         Where vl.PEDIDO_EXTERNO = '0020z.001156'
           And clf.NOME_CLIFOR = vl.CLIENTE_ATACADO
           And fmp.CONDICAO_PGTO = vl.CONDICAO_PGTO
           And vlp.PEDIDO_EXTERNO = vl.PEDIDO_EXTERNO
           And prd.PRODUTO = vlp.PRODUTO
           And ptm.GRADE = prd.GRADE
        ) As GRADE_16
        Where QTDE > 0

Order By 13,14


