SELECT * FROM CTB_LANCAMENTO_ITEM
WHERE LANCAMENTO='360739' AND ITEM=6

select * from CTB_BORDERO
WHERE LANCAMENTO='360739'


UPDATE CTB_LANCAMENTO_ITEM
SET CREDITO=132.29
WHERE LANCAMENTO='360739' AND ITEM=6


INSERT INTO CTB_LANCAMENTO_ITEM (EMPRESA,LANCAMENTO,ITEM,CONTA_CONTABIL,LX_TIPO_LANCAMENTO,
CREDITO,DEBITO,HISTORICO,CODIGO_HISTORICO,RATEIO_CENTRO_CUSTO,CONCILIADO,PERMITE_ALTERACAO,
DISPARA_FORMULA,DEBITO_MOEDA,CREDITO_MOEDA,GERADO_AUTOMATICO_TIPO,DATA_DIGITACAO,RATEIO_FILIAL,
COD_CLIFOR,MOEDA,CAMBIO_NA_DATA,ID_CONTRAPARTIDA,VALOR_FINANCEIRO,VALOR_FINANCEIRO_PADRAO,DATA_MOV,USUARIO_MOV,DOCUMENTO) 
VALUES('1','360739',3,'1120101','BTR',416.00,0.00,'BAIXA NOSSA FATURA NR. 032883/B','BTR','01','0','0','0',0.00,416.00,0,'20150716','000001',
'019101','R$', 1.000000,1,430.71,430.71,'20150716','KEDILA # LDR-FIN-001',NULL  )


DELETE FROM CTB_LANCAMENTO_ITEM
WHERE LANCAMENTO='360739' AND ITEM=6


SELECT * FROM CTB_A_RECEBER_MOV
WHERE LANCAMENTO='360739'



LX_CADE_COLUNA VALOR_JUROS_GERADO



SELECT * FROM CTB_BORDERO_PARCELA_CMD
WHERE LANCAMENTO='360739' AND ITEM_MOV=118 AND LANCAMENTO_MOV='229098'

BEGIN TRAN

UPDATE CTB_BORDERO_PARCELA_CMD
SET LANCAMENTO_MOV='344563', ITEM_MOV=1
WHERE LANCAMENTO='360739' AND ITEM_MOV=118 AND LANCAMENTO_MOV='229098'


COMMIT

    
select b.cod_representante,
d.representante,
d.gerente,
b.cod_clifor,
c.razao_social,
a.conta_portador,
rtrim(b.fatura)+'/'+a.id_parcela,
convert(char(10),b.emissao,103),
convert(char(10),a.vencimento_real,103),
cast((getdate()-a.vencimento_real) as int),
a.valor_a_receber    
from drvarejo.dbo.ctb_a_receber_parcela a with (nolock)   
join drvarejo.dbo.ctb_a_receber_fatura b with (nolock) on a.lancamento=b.lancamento and a.item=b.item    
join drvarejo.dbo.cadastro_cli_for c with (nolock) on c.clifor=b.cod_clifor     
join drvarejo.dbo.representantes d with (nolock) on d.clifor=b.cod_representante    
join ctb_lancamento e with (nolock) on e.lancamento=a.lancamento    
where a.vencimento_real<(getdate()-3) and a.valor_a_receber>=1000 and e.cod_filial='000001'    
order by c.razao_social    
    
    
select b.cod_representante,
d.representante,
d.gerente,
b.cod_clifor,
c.razao_social,
a.valor_a_receber,RANK() OVER (ORDER BY a.valor_a_receber DESC) AS Rank
from drvarejo.dbo.ctb_a_receber_parcela a with (nolock)   
join drvarejo.dbo.ctb_a_receber_fatura b with (nolock) on a.lancamento=b.lancamento and a.item=b.item    
join drvarejo.dbo.cadastro_cli_for c with (nolock) on c.clifor=b.cod_clifor     
join drvarejo.dbo.representantes d with (nolock) on d.clifor=b.cod_representante    
join ctb_lancamento e with (nolock) on e.lancamento=a.lancamento    
where a.vencimento_real<(getdate()-3) and a.valor_a_receber>=1000 and e.cod_filial='000001'    
--group by b.cod_representante,d.representante,d.gerente,b.cod_clifor,c.razao_social

order by c.razao_social    



select top (20) b.cod_representante,
d.representante,
d.gerente,
b.cod_clifor,
c.razao_social,
valor_a_receber=sum(a.valor_a_receber),709713 as total,(sum(a.valor_a_receber)/709713)*100 as percentual
from drvarejo.dbo.ctb_a_receber_parcela a with (nolock)   
join drvarejo.dbo.ctb_a_receber_fatura b with (nolock) on a.lancamento=b.lancamento and a.item=b.item    
join drvarejo.dbo.cadastro_cli_for c with (nolock) on c.clifor=b.cod_clifor     
join drvarejo.dbo.representantes d with (nolock) on d.clifor=b.cod_representante    
join ctb_lancamento e with (nolock) on e.lancamento=a.lancamento    
where a.vencimento_real<(getdate()-5) and a.valor_a_receber>=1 and e.cod_filial='000001'    
group by b.cod_representante,d.representante,d.gerente,b.cod_clifor,c.razao_social
order by valor_a_receber desc



select b.cod_representante,
d.representante,
d.gerente,
b.cod_clifor,
c.razao_social,
valor_aberto=sum(a.valor_a_receber),
valor_a_receber=sum(a.valor_a_receber),
total_geral = (
select valor_a_receber=sum(a.valor_a_receber)
from drvarejo.dbo.ctb_a_receber_parcela a with (nolock)   
join drvarejo.dbo.ctb_a_receber_fatura b with (nolock) on a.lancamento=b.lancamento and a.item=b.item    
join drvarejo.dbo.cadastro_cli_for c with (nolock) on c.clifor=b.cod_clifor     
join drvarejo.dbo.representantes d with (nolock) on d.clifor=b.cod_representante    
join ctb_lancamento e with (nolock) on e.lancamento=a.lancamento    
where a.vencimento_real<(getdate()-5) and a.valor_a_receber>=1 and e.cod_filial='000001'    
)
from drvarejo.dbo.ctb_a_receber_parcela a with (nolock)   
join drvarejo.dbo.ctb_a_receber_fatura b with (nolock) on a.lancamento=b.lancamento and a.item=b.item    
join drvarejo.dbo.cadastro_cli_for c with (nolock) on c.clifor=b.cod_clifor     
join drvarejo.dbo.representantes d with (nolock) on d.clifor=b.cod_representante    
join ctb_lancamento e with (nolock) on e.lancamento=a.lancamento    
where a.vencimento_real<(getdate()-5) and a.valor_a_receber>=1 and e.cod_filial='000001'    
group by b.cod_representante,d.representante,d.gerente,b.cod_clifor,c.razao_social


select valor_a_receber=sum(a.valor_a_receber)
from drvarejo.dbo.ctb_a_receber_parcela a with (nolock)   
join drvarejo.dbo.ctb_a_receber_fatura b with (nolock) on a.lancamento=b.lancamento and a.item=b.item    
join drvarejo.dbo.cadastro_cli_for c with (nolock) on c.clifor=b.cod_clifor     
join drvarejo.dbo.representantes d with (nolock) on d.clifor=b.cod_representante    
join ctb_lancamento e with (nolock) on e.lancamento=a.lancamento    
where a.vencimento_real<(getdate()-5) and a.valor_a_receber>=1 and e.cod_filial='000001'    