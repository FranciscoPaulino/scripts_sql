select * from FATURAMENTO_ITEM
where NF_SAIDA='015183' AND SERIE_NF='2'

select * from ENTRADAS
where NF_ENTRADA='83' and NATUREZA='250.01'

exec LX_CTB_INTEGRAR_ENTRADA 'MUNDO  INTIMO','83','1'

update ENTRADAS
set condicao_pgto='004'
where NF_ENTRADA='83' and NATUREZA='250.01'
