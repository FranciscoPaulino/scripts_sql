--Ao verificar o XML da nota foi verificado que as novas tags não haviam sido geradas.
--Pelo banco confirmei que o valor dos campos UTC_EMISSAO e DATA_HORA_EMISSAO estavam Null.
--Adicionei as informações e a nota foi autorizada.



lx_cade_coluna utc_emissao

UPDATE ENTRADAS
SET UTC_EMISSAO='3',DATA_HORA_EMISSAO='20151019'
WHERE NF_ENTRADA='043039' and SERIE_NF_ENTRADA='4'


select UTC_EMISSAO,DATA_HORA_EMISSAO,* from ENTRADAS
WHERE UTC_EMISSAO IS NULL and NF_ENTRADA='043039' and SERIE_NF_ENTRADA='4'

order by NF_ENTRADA


