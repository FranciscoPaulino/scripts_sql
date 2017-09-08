SELECT COD_NCM,count(ID_NCM) 
FROM LCF_LX_NCM 
GROUP BY COD_NCM
HAVING count(ID_NCM) > 1

SELECT *
FROM LCF_LX_NCM 
WHERE COD_NCM IN (
73072300,
60041020,
39211390)
ORDER BY COD_NCM


DELETE 
FROM LCF_LX_NCM 
WHERE ID_NCM IN (
126743,
134596,
130048)


