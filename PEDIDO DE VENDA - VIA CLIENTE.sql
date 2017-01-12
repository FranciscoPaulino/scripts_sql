SELECT d.GRADE,F.CLIFOR,F.RAZAO_SOCIAL,F.ENDERECO,F.CIDADE,F.UF,F.NUMERO,
COMPLEMENTO=F.COMPLEMENTO,F.CEP,F.DDD1,F.TELEFONE1,F.CGC_CPF,F.RG_IE,
E.PEDIDO,E.FILIAL,E.PEDIDO_CLIENTE,E.CODIGO_TAB_PRECO,E.CONDICAO_PGTO,G.DESC_COND_PGTO, 
E.COLECAO,E.MOEDA,E.TRANSPORTADORA,E.REPRESENTANTE,EMISSAO=CONVERT(CHAR(10),E.EMISSAO,103),
E.TOT_QTDE_ORIGINAL,E.TOT_VALOR_ORIGINAL,E.OBS,E.PEDIDO_EXTERNO,E.GERENTE,
EMAIL_CLI=RTRIM(F.EMAIL),EMAIL_GER=RTRIM(H.EMAIL),EMAIL_REP=RTRIM(I.EMAIL),
a.produto,a.COR_PRODUTO,  
rtrim(b.DESC_PRODUTO)+'/'+RTRIM(c.DESC_COR_PRODUTO) as desc_produto ,  
(case when a.vo1 > 0 then cast(a.vo1 as CHAR(5)) else '' end) as 'qtde1',
(case when a.vo2 > 0 then cast(a.vo2 as CHAR(5)) else '' end) as 'qtde2',
(case when a.vo3 > 0 then cast(a.vo3 as CHAR(5)) else '' end) as 'qtde3',
(case when a.vo4 > 0 then cast(a.vo4 as CHAR(5)) else '' end) as 'qtde4',
(case when a.vo5 > 0 then cast(a.vo5 as CHAR(5)) else '' end) as 'qtde5',
(case when a.vo6 > 0 then cast(a.vo6 as CHAR(5)) else '' end) as 'qtde6',
(case when a.vo7 > 0 then cast(a.vo7 as CHAR(5)) else '' end) as 'qtde7',
(case when a.vo8 > 0 then cast(a.vo8 as CHAR(5)) else '' end) as 'qtde8',
(case when a.vo9 > 0 then cast(a.vo9 as CHAR(5)) else '' end) as 'qtde9',
(case when a.vo10 > 0 then cast(a.vo10 as CHAR(5)) else '' end) as 'qtde10',
(case when a.vo11 > 0 then cast(a.vo11 as CHAR(5)) else '' end) as 'qtde11',
(case when a.vo12 > 0 then cast(a.vo12 as CHAR(5)) else '' end) as 'qtde12',
(case when a.vo13 > 0 then cast(a.vo13 as CHAR(5)) else '' end) as 'qtde13',
(case when a.vo14 > 0 then cast(a.vo14 as CHAR(5)) else '' end) as 'qtde14',
(case when a.vo15 > 0 then cast(a.vo15 as CHAR(5)) else '' end) as 'qtde15',
(case when a.vo16 > 0 then cast(a.vo16 as CHAR(5)) else '' end) as 'qtde16',
(case when a.vo1 > 0 then RTRIM(d.TAMANHO_1) else '' end) as 'tam1',
(case when a.vo2 > 0 then RTRIM(d.TAMANHO_2) else '' end) as 'tam2',
(case when a.vo3 > 0 then RTRIM(d.TAMANHO_3) else '' end) as 'tam3',
(case when a.vo4 > 0 then RTRIM(d.TAMANHO_4) else '' end) as 'tam4',
(case when a.vo5 > 0 then RTRIM(d.TAMANHO_5) else '' end) as 'tam5',
(case when a.vo6 > 0 then RTRIM(d.TAMANHO_6) else '' end) as 'tam6',
(case when a.vo7 > 0 then RTRIM(d.TAMANHO_7) else '' end) as 'tam7',
(case when a.vo8 > 0 then RTRIM(d.TAMANHO_8) else '' end) as 'tam8',
(case when a.vo9 > 0 then RTRIM(d.TAMANHO_9) else '' end) as 'tam9',
(case when a.vo10 > 0 then RTRIM(d.TAMANHO_10) else '' end) as 'tam10',
(case when a.vo11 > 0 then RTRIM(d.TAMANHO_11) else '' end) as 'tam11',
(case when a.VO12 > 0 then RTRIM(d.TAMANHO_12) else '' end) as 'tam12',
(case when a.vo13 > 0 then RTRIM(d.TAMANHO_13) else '' end) as 'tam13',
(case when a.vo14 > 0 then RTRIM(d.TAMANHO_14) else '' end) as 'tam14',
(case when a.vo15 > 0 then RTRIM(d.TAMANHO_15) else '' end) as 'tam15',
(case when a.vo16 > 0 then RTRIM(d.TAMANHO_16) else '' end) as 'tam16',
a.QTDE_ORIGINAL,  
(a.PRECO1-A.DESCONTO_ITEM) as preco_unitario,  
a.VALOR_ORIGINAL,  
CONVERT(CHAR(10),a.ENTREGA,103) as entrega,  
CONVERT(CHAR(10),a.LIMITE_ENTREGA,103) as limite_entrega
from drvarejo.dbo.vendas_produto a with (nolock) 
join drvarejo.dbo.produtos b with (nolock) on b.produto=a.PRODUTO
join drvarejo.dbo.produto_cores c with (nolock) on c.PRODUTO = a.PRODUTO and c.COR_PRODUTO=a.COR_PRODUTO
join DRVAREJO.dbo.PRODUTOS_TAMANHOS d with (nolock) on d.GRADE = b.GRADE
join DRVAREJO.dbo.VENDAS E WITH (NOLOCK) ON E.PEDIDO=A.PEDIDO
JOIN DRVAREJO.dbo.CADASTRO_CLI_FOR F with (nolock) ON F.NOME_CLIFOR = E.CLIENTE_ATACADO
JOIN DRVAREJO.dbo.COND_ATAC_PGTOS  G with (nolock) ON G.CONDICAO_PGTO = E.CONDICAO_PGTO
JOIN DRVAREJO.dbo.CADASTRO_CLI_FOR H with (nolock) ON H.NOME_CLIFOR = E.GERENTE
JOIN DRVAREJO.dbo.CADASTRO_CLI_FOR I with (nolock) ON I.NOME_CLIFOR = E.REPRESENTANTE
WHERE a.PEDIDO='578039' AND (PEDIDO_EXTERNO IS NOT NULL)
order by a.PRODUTO

select * from CTB_AVISO_LANCAMENTO
where LANCAMENTO='316411'

begin tran

delete from CTB_AVISO_LANCAMENTO
where LANCAMENTO='316411'

commit


select GRADE,* from PRODUTOS