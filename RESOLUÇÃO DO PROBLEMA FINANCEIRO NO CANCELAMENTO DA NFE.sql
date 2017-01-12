select DATA_CANCELAMENTO, CTB_LANCAMENTO, CTB_ITEM,* from FATURAMENTO where CTB_LANCAMENTO='250973' and nf_saida = '000288'

select * into faturamento_280213 from FATURAMENTO

SELECT CTB_ITEM,* FROM FATURAMENTO where nf_saida = '000716'  and CTB_LANCAMENTO IS NULL

begin tran
 update faturamento set ctb_item= NULL where nf_saida = '000716'  and CTB_LANCAMENTO IS NULL and CTB_ITEM='2'
 COMMIT
 ROLLBACK
 
 begin tran
 update faturamento set ctb_lancamento= NULL, CTB_ITEM= NULL where ctb_lancamento = '250973' and nf_saida = '000288' 
 COMMIT
 
 