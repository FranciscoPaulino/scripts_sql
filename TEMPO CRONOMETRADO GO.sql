SELECT W_PRODUCAO_ORDEM_HIST_OS.data, W_PRODUCAO_ORDEM_HIST_OS.ordem_servico, W_PRODUCAO_ORDEM_HIST_OS.tarefa_anterior, 
W_PRODUCAO_ORDEM_HIST_OS.ordem_producao, W_PRODUCAO_ORDEM_HIST_OS.produto, W_PRODUCAO_ORDEM_HIST_OS.cor_produto, W_PRODUCAO_ORDEM_HIST_OS.qtde_a, 
W_PRODUCAO_ORDEM_HIST_OS.a1, W_PRODUCAO_ORDEM_HIST_OS.a2, W_PRODUCAO_ORDEM_HIST_OS.a3, W_PRODUCAO_ORDEM_HIST_OS.a4, W_PRODUCAO_ORDEM_HIST_OS.a5, 
W_PRODUCAO_ORDEM_HIST_OS.a6, W_PRODUCAO_ORDEM_HIST_OS.a7, W_PRODUCAO_ORDEM_HIST_OS.a8, W_PRODUCAO_ORDEM_HIST_OS.a9, W_PRODUCAO_ORDEM_HIST_OS.a10, 
W_PRODUCAO_ORDEM_HIST_OS.fase_producao, W_PRODUCAO_ORDEM_HIST_OS.setor_producao, W_PRODUCAO_ORDEM_HIST_OS.recurso_produtivo, 
W_PRODUCAO_ORDEM_HIST_OS.desc_fase_producao, W_PRODUCAO_ORDEM_HIST_OS.desc_setor_producao, W_PRODUCAO_ORDEM_HIST_OS.desc_recurso, 
W_PRODUCAO_ORDEM_HIST_OS.tarefa, W_PRODUCAO_ORDEM_HIST_OS.indicador_tipo_mov, PRODUTOS_TAB_OPERACOES.TABELA_OPERACOES, TEMPO_TOTAL=PRODUTOS_OPERACOES.SOMA_DE_OPERACOES,
 
PRODUCAO_FASE.FASE_PRODUCAO, PRODUCAO_FASE.DESC_FASE_PRODUCAO, PRODUCAO_SETOR.SETOR_PRODUCAO, PRODUCAO_SETOR.DESC_SETOR_PRODUCAO, PRODUCAO_RECURSOS.RECURSO_PRODUTIVO, 
PRODUCAO_RECURSOS.DESC_RECURSO, PRODUTOS.PRODUTO, PRODUTOS.GRUPO_PRODUTO, PRODUTOS.SUBGRUPO_PRODUTO, PRODUTOS.GRIFFE, PRODUTOS.COD_PRODUTO_SEGMENTO, 
PROP_PRODUTOS_GRIFFES.GRIFFE, 
convert(decimal(10,2),PROP_PRODUTOS_GRIFFES.VALOR_PROPRIEDADE) AS FATOR, convert(decimal(10,2),PROP_PRODUTOS_GRIFFES.VALOR_PROPRIEDADE)* W_PRODUCAO_ORDEM_HIST_OS.qtde_a AS LIQUIDO

FROM DRLINGERIE.dbo.PRODUCAO_FASE PRODUCAO_FASE, DRLINGERIE.dbo.PRODUCAO_RECURSOS PRODUCAO_RECURSOS, DRLINGERIE.dbo.PRODUCAO_SETOR PRODUCAO_SETOR, 
DRLINGERIE.dbo.PRODUTOS PRODUTOS, DRLINGERIE.dbo.PRODUTOS_TAB_OPERACOES PRODUTOS_TAB_OPERACOES, 
DRLINGERIE.dbo.PROP_PRODUTOS_GRIFFES PROP_PRODUTOS_GRIFFES, DRLINGERIE.dbo.W_PRODUCAO_ORDEM_HIST_OS W_PRODUCAO_ORDEM_HIST_OS
,
(
select a.TABELA_OPERACOES,a.TEMPO_TOTAL,SOMA_DE_OPERACOES=sum(b.TEMPO_CRONOMETRADO) 
from PRODUTOS_TAB_OPERACOES a
join PRODUTOS_OPERACOES b on b.TABELA_OPERACOES=a.TABELA_OPERACOES
group by a.TABELA_OPERACOES,a.TEMPO_TOTAL
) PRODUTOS_OPERACOES


WHERE PRODUCAO_FASE.FASE_PRODUCAO = W_PRODUCAO_ORDEM_HIST_OS.fase_producao AND PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO AND 
PRODUCAO_RECURSOS.RECURSO_PRODUTIVO = W_PRODUCAO_ORDEM_HIST_OS.recurso_produtivo AND PRODUCAO_SETOR.SETOR_PRODUCAO = W_PRODUCAO_ORDEM_HIST_OS.setor_producao AND 
PRODUCAO_SETOR.FASE_PRODUCAO = W_PRODUCAO_ORDEM_HIST_OS.fase_producao AND PRODUTOS.PRODUTO = W_PRODUCAO_ORDEM_HIST_OS.produto AND 
PRODUTOS.GRIFFE = PROP_PRODUTOS_GRIFFES.GRIFFE AND 
PRODUTOS.TABELA_OPERACOES = PRODUTOS_TAB_OPERACOES.TABELA_OPERACOES AND 
PRODUTOS_OPERACOES.TABELA_OPERACOES=PRODUTOS_TAB_OPERACOES.TABELA_OPERACOES AND
((W_PRODUCAO_ORDEM_HIST_OS.data>={ts '2016-02-01 00:00:00'})) 



select * from PRODUTOS_TAB_OPERACOES
where tabELA_OPERACOES IN('52770-K5')
'50509-K32',                
'50509-K33',                
'50027-D35',                
'50027-D34',                
'52770-K5 ',                
'52770-K25')                

SELECT * FROM PRODUTOS_OPERACOES
where tabELA_OPERACOES IN('52770-K5')
'50509-K32',                
'50509-K33',                
'50027-D35',                
'50027-D34',                
'52770-K5 ',                
'52770-K25')                


update d 
set d.tempo_total=soma_de_operacoes
from PRODUTOS_TAB_OPERACOES d
join (
select a.TABELA_OPERACOES,a.TEMPO_TOTAL,SOMA_DE_OPERACOES=sum(b.TEMPO_CRONOMETRADO) 
from PRODUTOS_TAB_OPERACOES a
join PRODUTOS_OPERACOES b on b.TABELA_OPERACOES=a.TABELA_OPERACOES
where a.TABELA_OPERACOES='52770-K5'
group by a.TABELA_OPERACOES,a.TEMPO_TOTAL
having a.TEMPO_TOTAL=0
) c on c.TABELA_OPERACOES=d.TABELA_OPERACOES







