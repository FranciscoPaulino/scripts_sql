SELECT * FROM SAW_CALENDARIO_PGTO
where dia in(4,5,6,19,20,21) 


update SAW_CALENDARIO_PGTO
set periodo_folha_pgto=1
where dia in(4,5,6,19,20,21) 

select * from SAW_limite_pgto_diario

update SAW_limite_pgto_diario
set valor_liberado=800000

