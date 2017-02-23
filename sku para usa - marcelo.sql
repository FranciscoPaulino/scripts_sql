select c.*, b.* from faturamento a
join FATURAMENTO_ITEM b on b.NF_SAIDA=a.NF_SAIDA and b.SERIE_NF=a.SERIE_NF
join PRODUTOS_BARRA c on rtrim(c.produto)+rtrim(c.COR_PRODUTO)+rtrim(c.GRADE)=b.CODIGO_ITEM
where a.nf_saida='0077811' and a.serie_nf='55' and c.CODIGO_BARRA_PADRAO=1




