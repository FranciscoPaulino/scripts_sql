SELECT '"'+SUBSTRING(CODIGO_EXPORTACAO,1,15)+'",'+
'"'+RTRIM(B.DESC_MATERIAL)+'",'+
'"'+RTRIM(A.COR_MATERIAL)+'",'+
'"'+RTRIM(B.MATERIAL)+'",'+
'"'+RTRIM(B.UNID_ESTOQUE)+'"'
FROM MATERIAIS_CORES A
JOIN MATERIAIS B ON B.MATERIAL=A.MATERIAL
order by CODIGO_EXPORTACAO