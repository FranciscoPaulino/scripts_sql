-- ALTERAR INATIVO=0 DOS PRODUTOS INATIVO=1
select produto,inativo from produtos
where inativo=1 and produto in (
select produto from faturamento_prod 
where serie_nf = '1' and nf_saida in (
'028039',
'026347',
'011495',
'015668',
'022298',
'014993',
'012309',
'026360',
'017025',
'013665',
'014906',
'028041',
'029814',
'023707',
'015689',
'022309',
'022287',
'019096',
'026386',
'028081'
) 
)

-- UPDATE

UPDATE produtos
SET INATIVO=0
FROM PRODUTOS A
where A.inativo=1 and A.produto in (
select produto from faturamento_prod 
where serie_nf = '1' and nf_saida in (
'028039',
'026347',
'011495',
'015668',
'022298',
'014993',
'012309',
'026360',
'017025',
'013665',
'014906',
'028041',
'029814',
'023707',
'015689',
'022309',
'022287',
'019096',
'026386',
'028081'
) 
)



