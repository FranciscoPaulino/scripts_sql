SELECT TIPO_COMPRA ,SUM(TOT_VALOR_ORIGINAL) AS TOT_MP_MES
FROM COMPRAS 
WHERE STATUS_APROVACAO='A' AND TABELA_FILHA='COMPRAS_MATERIAL' AND EMISSAO BETWEEN '20170501' AND GETDATE()
GROUP BY TIPO_COMPRA 

SELECT TIPO_COMPRA,EMISSAO,SUM(TOT_VALOR_ORIGINAL) AS TOT_MP_MES 
FROM COMPRAS 
WHERE TABELA_FILHA='COMPRAS_MATERIAL' AND EMISSAO BETWEEN '20170501' AND GETDATE()
GROUP BY EMISSAO,TIPO_COMPRA 

SELECT TIPO_COMPRA,FORNECEDOR,SUM(TOT_VALOR_ORIGINAL) AS TOT_MP_MES 
FROM COMPRAS A
WHERE TABELA_FILHA='COMPRAS_MATERIAL' AND EMISSAO BETWEEN '20170501' AND GETDATE()
GROUP BY EMISSAO,TIPO_COMPRA,FORNECEDOR


SELECT MATRIZ_CLIENTE,PEDIDO_CLIENTE,PRIORIDADE,TIPO,ENTREGA AS FATURAMENTO,DIAS_FATURAMENTO AS DIAS_ATRASO,
SUM(QTDE_ORIGINAL)AS QTDE_ORIGINAL,SUM(QTDE_ENTREGAR)AS QTDE_ENTREGAR, SUM(QTDE_EMBALADA)AS QTDE_RESERVADA
FROM W_ENTRADA_PEDIDO_PCP with (nolock)
where PRIORIDADE in ('9','8') and FILIAL='D.R. LINGERIE' AND STATUS_APROVACAO='A' AND MATRIZ_CLIENTE<>'PROGRAMACAO PCP'
group by MATRIZ_CLIENTE,PEDIDO_CLIENTE,PRIORIDADE,TIPO,ENTREGA,DIAS_FATURAMENTO order by FATURAMENTO



SELECT A.TIPO_COMPRA,B.TIPO_COMPRA,SUM(TOT_VALOR_ORIGINAL) AS TOT_MES 
FROM COMPRAS_TIPOS A 
LEFT JOIN COMPRAS B ON B.TIPO_COMPRA=A.TIPO_COMPRA
WHERE B.STATUS_APROVACAO='A' AND EMISSAO BETWEEN '20170501' and getdate()
GROUP BY A.TIPO_COMPRA,B.TIPO_COMPRA

SELECT A.TIPO_COMPRA,TOT_MES_ESTUDO=ISNULL(B.TOT_MES_ESTUDO,0),TOT_MES_APROVADO=ISNULL(C.TOT_MES_APROVADO,0)
FROM COMPRAS_TIPOS A
LEFT JOIN (SELECT TIPO_COMPRA,SUM(TOT_VALOR_ORIGINAL) AS TOT_MES_ESTUDO FROM COMPRAS WHERE STATUS_APROVACAO='E' AND EMISSAO BETWEEN '20170501' and getdate() GROUP BY TIPO_COMPRA) B ON B.TIPO_COMPRA=A.TIPO_COMPRA
LEFT JOIN (SELECT TIPO_COMPRA,SUM(TOT_VALOR_ORIGINAL) AS TOT_MES_APROVADO FROM COMPRAS WHERE STATUS_APROVACAO='A' AND EMISSAO BETWEEN '20170501' and getdate() GROUP BY TIPO_COMPRA) C ON C.TIPO_COMPRA=A.TIPO_COMPRA
