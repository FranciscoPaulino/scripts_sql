SELECT *,
ESTOQUE_DISP = 
CASE WHEN (ESTOQUE - (VENDA_ENTREGAR_JAN + VENDA_ENTREGAR_FEV + VENDA_ENTREGAR_MAR + VENDA_ENTREGAR_ABR + VENDA_ENTREGAR_MAI + VENDA_ENTREGAR_JUN + VENDA_ENTREGAR_JUL + VENDA_ENTREGAR_AGO + VENDA_ENTREGAR_SET + VENDA_ENTREGAR_OUT + VENDA_ENTREGAR_NOV + VENDA_ENTREGAR_DEZ)) > 0 THEN (ESTOQUE - (VENDA_ENTREGAR_JAN + VENDA_ENTREGAR_FEV + VENDA_ENTREGAR_MAR + VENDA_ENTREGAR_ABR + VENDA_ENTREGAR_MAI + VENDA_ENTREGAR_JUN + VENDA_ENTREGAR_JUL + VENDA_ENTREGAR_AGO + VENDA_ENTREGAR_SET + VENDA_ENTREGAR_OUT + VENDA_ENTREGAR_NOV + VENDA_ENTREGAR_DEZ)) ELSE 0 END,
FURO = 
CASE WHEN (ESTOQUE - (VENDA_ENTREGAR_JAN + VENDA_ENTREGAR_FEV + VENDA_ENTREGAR_MAR + VENDA_ENTREGAR_ABR + VENDA_ENTREGAR_MAI + VENDA_ENTREGAR_JUN + VENDA_ENTREGAR_JUL + VENDA_ENTREGAR_AGO + VENDA_ENTREGAR_SET + VENDA_ENTREGAR_OUT + VENDA_ENTREGAR_NOV + VENDA_ENTREGAR_DEZ)) < 0 THEN (ESTOQUE - (VENDA_ENTREGAR_JAN + VENDA_ENTREGAR_FEV + VENDA_ENTREGAR_MAR + VENDA_ENTREGAR_ABR + VENDA_ENTREGAR_MAI + VENDA_ENTREGAR_JUN + VENDA_ENTREGAR_JUL + VENDA_ENTREGAR_AGO + VENDA_ENTREGAR_SET + VENDA_ENTREGAR_OUT + VENDA_ENTREGAR_NOV + VENDA_ENTREGAR_DEZ)) ELSE 0 END
FROM (
SELECT SETOR_PRODUCAO,RECURSO_PRODUTIVO,linha,produto,cor_produto,tamanho,grade, 
VENDA_ENTREGAR_JAN=ISNULL(dbo.Qtde_Tamanho_VE(produto,cor_produto,tamanho,'20140101','20140131'),0),
VENDA_ENTREGAR_FEV=ISNULL(dbo.Qtde_Tamanho_VE(produto,cor_produto,tamanho,'20140201','20140228'),0),
VENDA_ENTREGAR_MAR=ISNULL(dbo.Qtde_Tamanho_VE(produto,cor_produto,tamanho,'20140301','20140331'),0),
VENDA_ENTREGAR_ABR=ISNULL(dbo.Qtde_Tamanho_VE(produto,cor_produto,tamanho,'20140401','20140430'),0),
VENDA_ENTREGAR_MAI=ISNULL(dbo.Qtde_Tamanho_VE(produto,cor_produto,tamanho,'20140501','20140531'),0),
VENDA_ENTREGAR_JUN=ISNULL(dbo.Qtde_Tamanho_VE(produto,cor_produto,tamanho,'20140601','20140630'),0),
VENDA_ENTREGAR_JUL=ISNULL(dbo.Qtde_Tamanho_VE(produto,cor_produto,tamanho,'20140701','20140731'),0),
VENDA_ENTREGAR_AGO=ISNULL(dbo.Qtde_Tamanho_VE(produto,cor_produto,tamanho,'20140801','20140831'),0),
VENDA_ENTREGAR_SET=ISNULL(dbo.Qtde_Tamanho_VE(produto,cor_produto,tamanho,'20140901','20140930'),0),
VENDA_ENTREGAR_OUT=ISNULL(dbo.Qtde_Tamanho_VE(produto,cor_produto,tamanho,'20141001','20141031'),0),
VENDA_ENTREGAR_NOV=ISNULL(dbo.Qtde_Tamanho_VE(produto,cor_produto,tamanho,'20141101','20141130'),0),
VENDA_ENTREGAR_DEZ=ISNULL(dbo.Qtde_Tamanho_VE(produto,cor_produto,tamanho,'20141201','20141231'),0),
ESTOQUE=ISNULL(dbo.Qtde_Tamanho(produto,cor_produto,tamanho),0)
FROM  
( 
SELECT d.SETOR_PRODUCAO,d.RECURSO_PRODUTIVO,b.linha,a.produto,a.cor_produto,c.tamanho,c.grade 
FROM produto_cores a with (NOLOCK) 
JOIN produtos b with (NOLOCK) ON b.produto = a.produto 
JOIN (select produto,cor_produto,tamanho,grade 
from produtos_barra with (NOLOCK) where codigo_barra_padrao=1 
) c ON  c.produto=a.produto AND c.cor_produto=a.cor_produto  
LEFT JOIN ( 
SELECT * FROM PRODUTO_OPERACOES_ROTAS with (nolock) WHERE FASE_PRODUCAO='007'	
) D ON D.TABELA_OPERACOES=b.PRODUTO 
WHERE a.desc_cor_produto NOT LIKE '%-FL' AND 
b.cod_categoria='01' AND b.cod_subcategoria ='01' AND b.EMPRESA=1 
) EM_LINHA 
) AS VENDAS_ENTREGAR
ORDER BY PRODUTO
