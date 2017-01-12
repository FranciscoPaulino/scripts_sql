SELECT VENDAS.PEDIDO, 
VENDAS.COLECAO, 
VENDAS.CODIGO_TAB_PRECO, 
VENDAS.CONDICAO_PGTO, 
VENDAS.CLIENTE_ATACADO, 
VENDAS.REPRESENTANTE, 
VENDAS.GERENTE, 
VENDAS.EMISSAO, 
VENDAS_PRODUTO.VALOR_ORIGINAL, 
VENDAS_PRODUTO.VALOR_ENTREGUE, 
VENDAS_PRODUTO.VALOR_CANCELADO, 
VENDAS_PRODUTO.VALOR_DEVOLVIDO, 
VENDAS_PRODUTO.VALOR_ENTREGAR, 
VENDAS.DESCONTO, 
VENDAS.PRIORIDADE, 
VENDAS.STATUS, 
VENDAS.APROVACAO, 
VENDAS.APROVADO_POR, 
VENDAS.PORC_DESCONTO, 
VENDAS.PORC_DESCONTO_BRUTO, 
VENDAS.PORC_DESCONTO_DIGITADO, 
VENDAS.DESCONTO_COND_PGTO, 
VENDAS.TIPO, 
VENDAS_PRODUTO.PEDIDO, 
VENDAS_PRODUTO.ENTREGA, 
VENDAS_PRODUTO.LIMITE_ENTREGA, 
VENDAS_PRODUTO.QTDE_ORIGINAL, 
QTDE_EMBALADA=ISNULL(QTDE_EMBALADA,0), 
QTDE_A_RESERVAR=ISNULL(ROMANEIOS_RESERVAS.QTDE_R,0), 
VENDAS_PRODUTO.QTDE_ENTREGAR, 
VENDAS_PRODUTO.QTDE_ENTREGUE, 
VENDAS_PRODUTO.QTDE_DEVOLVIDA, 
VENDAS_PRODUTO.QTDE_CANCELADA,
VENDAS_PRODUTO.GRADE,
VENDAS_PRODUTO.TAMANHO,
COLECOES.COLECAO, 
COLECOES.DESC_COLECAO, 
COND_ATAC_PGTOS.CONDICAO_PGTO, 
COND_ATAC_PGTOS.DESC_COND_PGTO, 
VENDAS_PRODUTO.PRODUTO,
VENDAS_PRODUTO.COR_PRODUTO,
QTDE_PRODUTO_FALTA=DBO.QTDE_FALTA_PRODUTO(VENDAS.PEDIDO)

FROM (
	SELECT 
	VENDAS_PRODUTO.VALOR_ORIGINAL, 
	VENDAS_PRODUTO.VALOR_ENTREGUE, 
	VENDAS_PRODUTO.VALOR_CANCELADO, 
	VENDAS_PRODUTO.VALOR_DEVOLVIDO, 
	VENDAS_PRODUTO.VALOR_ENTREGAR, 	
	VENDAS_PRODUTO.PEDIDO, 
	VENDAS_PRODUTO.ENTREGA, 
	VENDAS_PRODUTO.LIMITE_ENTREGA, 
	VENDAS_PRODUTO.QTDE_ENTREGUE, 
	VENDAS_PRODUTO.QTDE_DEVOLVIDA, 
	VENDAS_PRODUTO.QTDE_CANCELADA, 
    VENDAS_PRODUTO.PRODUTO,
    VENDAS_PRODUTO.COR_PRODUTO,
	PRODUTOS_BARRA.GRADE,
	PRODUTOS_BARRA.TAMANHO,


	QTDE_ORIGINAL = (
	  CASE WHEN PRODUTOS_BARRA.tamanho='1'  THEN VENDAS_PRODUTO.VO1 
		   WHEN PRODUTOS_BARRA.tamanho='2'  THEN VENDAS_PRODUTO.VO2
		   WHEN PRODUTOS_BARRA.tamanho='3'  THEN VENDAS_PRODUTO.VO3
		   WHEN PRODUTOS_BARRA.tamanho='4'  THEN VENDAS_PRODUTO.VO4
		   WHEN PRODUTOS_BARRA.tamanho='5'  THEN VENDAS_PRODUTO.VO5
		   WHEN PRODUTOS_BARRA.tamanho='6'  THEN VENDAS_PRODUTO.VO6
		   WHEN PRODUTOS_BARRA.tamanho='7'  THEN VENDAS_PRODUTO.VO7
		   WHEN PRODUTOS_BARRA.tamanho='8'  THEN VENDAS_PRODUTO.VO8
		   WHEN PRODUTOS_BARRA.tamanho='9'  THEN VENDAS_PRODUTO.VO9
		   WHEN PRODUTOS_BARRA.tamanho='10' THEN VENDAS_PRODUTO.VO10
		   WHEN PRODUTOS_BARRA.tamanho='11' THEN VENDAS_PRODUTO.VO11
		   WHEN PRODUTOS_BARRA.tamanho='12' THEN VENDAS_PRODUTO.VO12
		   WHEN PRODUTOS_BARRA.tamanho='13' THEN VENDAS_PRODUTO.VO13
		   WHEN PRODUTOS_BARRA.tamanho='14' THEN VENDAS_PRODUTO.VO14
		   WHEN PRODUTOS_BARRA.tamanho='15' THEN VENDAS_PRODUTO.VO15
		   WHEN PRODUTOS_BARRA.tamanho='16' THEN VENDAS_PRODUTO.VO16
	   END),


	QTDE_ENTREGAR = (
	  CASE WHEN PRODUTOS_BARRA.tamanho='1'  THEN VENDAS_PRODUTO.VE1 
		   WHEN PRODUTOS_BARRA.tamanho='2'  THEN VENDAS_PRODUTO.VE2
		   WHEN PRODUTOS_BARRA.tamanho='3'  THEN VENDAS_PRODUTO.VE3
		   WHEN PRODUTOS_BARRA.tamanho='4'  THEN VENDAS_PRODUTO.VE4
		   WHEN PRODUTOS_BARRA.tamanho='5'  THEN VENDAS_PRODUTO.VE5
		   WHEN PRODUTOS_BARRA.tamanho='6'  THEN VENDAS_PRODUTO.VE6
		   WHEN PRODUTOS_BARRA.tamanho='7'  THEN VENDAS_PRODUTO.VE7
		   WHEN PRODUTOS_BARRA.tamanho='8'  THEN VENDAS_PRODUTO.VE8
		   WHEN PRODUTOS_BARRA.tamanho='9'  THEN VENDAS_PRODUTO.VE9
		   WHEN PRODUTOS_BARRA.tamanho='10' THEN VENDAS_PRODUTO.VE10
		   WHEN PRODUTOS_BARRA.tamanho='11' THEN VENDAS_PRODUTO.VE11
		   WHEN PRODUTOS_BARRA.tamanho='12' THEN VENDAS_PRODUTO.VE12
		   WHEN PRODUTOS_BARRA.tamanho='13' THEN VENDAS_PRODUTO.VE13
		   WHEN PRODUTOS_BARRA.tamanho='14' THEN VENDAS_PRODUTO.VE14
		   WHEN PRODUTOS_BARRA.tamanho='15' THEN VENDAS_PRODUTO.VE15
		   WHEN PRODUTOS_BARRA.tamanho='16' THEN VENDAS_PRODUTO.VE16
	   END),

	QTDE_EMBALADA = (
	  CASE WHEN PRODUTOS_BARRA.tamanho='1'  THEN VENDAS_PROD_EMBALADO.E1 
		   WHEN PRODUTOS_BARRA.tamanho='2'  THEN VENDAS_PROD_EMBALADO.E2
		   WHEN PRODUTOS_BARRA.tamanho='3'  THEN VENDAS_PROD_EMBALADO.E3
		   WHEN PRODUTOS_BARRA.tamanho='4'  THEN VENDAS_PROD_EMBALADO.E4
		   WHEN PRODUTOS_BARRA.tamanho='5'  THEN VENDAS_PROD_EMBALADO.E5
		   WHEN PRODUTOS_BARRA.tamanho='6'  THEN VENDAS_PROD_EMBALADO.E6
		   WHEN PRODUTOS_BARRA.tamanho='7'  THEN VENDAS_PROD_EMBALADO.E7
		   WHEN PRODUTOS_BARRA.tamanho='8'  THEN VENDAS_PROD_EMBALADO.E8
		   WHEN PRODUTOS_BARRA.tamanho='9'  THEN VENDAS_PROD_EMBALADO.E9
		   WHEN PRODUTOS_BARRA.tamanho='10' THEN VENDAS_PROD_EMBALADO.E10
		   WHEN PRODUTOS_BARRA.tamanho='11' THEN VENDAS_PROD_EMBALADO.E11
		   WHEN PRODUTOS_BARRA.tamanho='12' THEN VENDAS_PROD_EMBALADO.E12
		   WHEN PRODUTOS_BARRA.tamanho='13' THEN VENDAS_PROD_EMBALADO.E13
		   WHEN PRODUTOS_BARRA.tamanho='14' THEN VENDAS_PROD_EMBALADO.E14
		   WHEN PRODUTOS_BARRA.tamanho='15' THEN VENDAS_PROD_EMBALADO.E15
		   WHEN PRODUTOS_BARRA.tamanho='16' THEN VENDAS_PROD_EMBALADO.E16
	   END)

	   
    FROM VENDAS_PRODUTO WITH (NOLOCK)
    JOIN PRODUTOS_BARRA WITH (NOLOCK) ON VENDAS_PRODUTO.PRODUTO=PRODUTOS_BARRA.PRODUTO AND VENDAS_PRODUTO.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO

    LEFT JOIN 
    ( SELECT PEDIDO,PRODUTO,COR_PRODUTO,E1=SUM(E1),E2=SUM(E2),E3=SUM(E3),E4=SUM(E4),E5=SUM(E5),E6=SUM(E6),E7=SUM(E7),E8=SUM(E8),E9=SUM(E9),E10=SUM(E10),E11=SUM(E11),E12=SUM(E12),E13=SUM(E13),E14=SUM(E14),E15=SUM(E15),E16=SUM(E16)
	  FROM VENDAS_PROD_EMBALADO WITH (NOLOCK)
	  GROUP BY PEDIDO,PRODUTO,COR_PRODUTO
    ) AS VENDAS_PROD_EMBALADO  
    ON VENDAS_PROD_EMBALADO.PRODUTO=VENDAS_PRODUTO.PRODUTO AND VENDAS_PROD_EMBALADO.COR_PRODUTO=VENDAS_PRODUTO.COR_PRODUTO AND VENDAS_PROD_EMBALADO.PEDIDO=VENDAS_PRODUTO.PEDIDO  
    
    WHERE PRODUTOS_BARRA.CODIGO_BARRA LIKE '789%' AND VENDAS_PRODUTO.QTDE_ENTREGAR>0
    
) AS VENDAS_PRODUTO

JOIN VENDAS VENDAS WITH (NOLOCK) ON VENDAS.PEDIDO = VENDAS_PRODUTO.PEDIDO

JOIN COLECOES COLECOES WITH (NOLOCK) ON COLECOES.COLECAO = VENDAS.COLECAO

JOIN COND_ATAC_PGTOS COND_ATAC_PGTOS WITH (NOLOCK) ON COND_ATAC_PGTOS.CONDICAO_PGTO = VENDAS.CONDICAO_PGTO

LEFT JOIN ROMANEIOS_RESERVAS WITH (NOLOCK) ON ROMANEIOS_RESERVAS.PEDIDO = VENDAS_PRODUTO.PEDIDO AND ROMANEIOS_RESERVAS.PRODUTO = VENDAS_PRODUTO.PRODUTO AND ROMANEIOS_RESERVAS.COR_PRODUTO = VENDAS_PRODUTO.COR_PRODUTO

WHERE VENDAS_PRODUTO.QTDE_ENTREGAR>0 
