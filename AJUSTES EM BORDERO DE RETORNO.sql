begin tran

select * from CTB_LANCAMENTO_ITEM
where LANCAMENTO='300130' and ITEM in(1,2)

select * from CTB_LANCAMENTO_ITEM
where LANCAMENTO='300130' and ITEM in(75)

delete from CTB_LANCAMENTO_ITEM
where LANCAMENTO='300130' and ITEM in(1,2)


update CTB_LANCAMENTO_ITEM
set debito=47751.50
where LANCAMENTO='300130' and ITEM in(75)


commit