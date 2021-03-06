SELECT * FROM CTB_BORDERO
WHERE LAYOUT='0196'

select * from CTB_BORDERO_CHEQUE_CMD
where lx_tipo_ocorrencia='ecf'

select * from CTB_LANCAMENTO_ITEM
where lancamento='422479'

lx_cade_coluna lx_tipo_ocorrencia

SELECT * FROM CTB_BORDERO_PARCELA_CMD
where lx_tipo_ocorrencia='ecf'

SELECT * FROM CTB_BORDERO_PARCELA_NOTA
WHERE LANCAMENTO='421427' and LANCAMENTO_MOV='384793' and POSICAO=78

update CTB_BORDERO_PARCELA_NOTA
SET VALOR_CAMPO='000000000146328'
WHERE LANCAMENTO='421427' and LANCAMENTO_MOV='384793' and POSICAO=78 AND
EXISTS(SELECT * FROM CTB_BORDERO_PARCELA_NOTA WHERE LAYOUT='0196' AND POSICAO=33 AND VALOR_CAMPO<>0 AND LX_TOPOLOGIA='T1B')


-- INICIO
-- DEPOIS DE IMPORTAR ARQUIVO RETORNO EXECUTAR O SCRIPT ABAIXO PARA ARRUMAR T�TULOS
-- QUE TENHAM DESCONTO NA DATA DO VENCIMENTO, E ASSIM N�O FIQUEM COM VALOR EM ABERTO
UPDATE A
SET A.VALOR_CAMPO=B.VALOR_CAMPO
FROM CTB_BORDERO_PARCELA_NOTA A
JOIN CTB_BORDERO_PARCELA_NOTA B ON B.LANCAMENTO=A.LANCAMENTO AND B.LANCAMENTO_MOV=A.LANCAMENTO_MOV AND B.ITEM_MOV=A.ITEM_MOV AND B.POSICAO=82
WHERE A.LANCAMENTO='421769' AND A.POSICAO=78 AND EXISTS(SELECT * FROM CTB_BORDERO_PARCELA_NOTA WHERE LAYOUT='0196' AND POSICAO=33 AND VALOR_CAMPO<>0 AND LX_TOPOLOGIA='T1B' 
AND LANCAMENTO=A.LANCAMENTO AND LANCAMENTO_MOV=A.LANCAMENTO_MOV AND B.ITEM_MOV=A.ITEM_MOV)

EXECUTE LX_CTB_BORDERO_RECEBER_RETORNO 1,421769
--
-- FIM


