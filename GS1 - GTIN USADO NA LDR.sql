-- codigo ogiginal inicial
select produto,codigo_barra from produtos_barra
where codigo_barra like '78991405%'
order by codigo_barra

-- codigo adicional
select produto,codigo_barra from produtos_barra
where codigo_barra like '789851108%'
order by codigo_barra

select produto,codigo_barra from produtos_barra
where codigo_barra like '789851109%'
order by codigo_barra

select produto,codigo_barra from produtos_barra
where codigo_barra like '789851110%'
order by codigo_barra

