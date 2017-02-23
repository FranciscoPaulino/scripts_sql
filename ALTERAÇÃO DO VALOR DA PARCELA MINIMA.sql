select * from parametros
where parametro like 'vlr%'


update parametros
set VALOR_ATUAL=400
where parametro = 'VLR_MINIMO_PARCELA_VENDAS'

update parametros
set VALOR_ATUAL=20
where parametro = 'VLR_MINIMO_PARCELA_MOSTRU'

