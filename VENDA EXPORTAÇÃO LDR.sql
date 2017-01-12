select 'VENDA EXPORTAÇÃO' AS TIPO,EMISSAO,qtde_total=SUM(qtde_total),valor_total=SUM(mpadrao_valor_total) from FATURAMENTO
WHERE NATUREZA_SAIDA IN('136.01','104.01') and NOTA_CANCELADA=0
GROUP BY EMISSAO
