insert into COTA_LIMITE_PERFAT (numero_entrega,periodo_pcp,qtde_limite,fechado)
select numero_entrega,periodo_pcp,60000,0 
from PRODUTOS_PERIODOS_ENTREGAS a
where PERIODO_PCP like '%2017' and not exists(select * from COTA_LIMITE_PERFAT where NUMERO_ENTREGA=a.NUMERO_ENTREGA and PERIODO_PCP=a.PERIODO_PCP)