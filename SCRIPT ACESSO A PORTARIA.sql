SELECT [NOME], [EMPRESA], [TIPO], [CONTATO], [TIPO_VISITA], [DATA_MOVIMENTO], [STATUS],[DATA_SAIDA_ENTRADA] FROM [SAW_ACESSO_PORTARIA]
WHERE ((STATUS='SAIDA' AND TIPO='FUNCIONARIO') OR (STATUS='ENTRADA' AND TIPO='VISITANTE') AND CONVERT(CHAR(10),DATA_MOVIMENTO,103)=CONVERT(CHAR(10),GETDATE(),103))


SELECT [NOME], [EMPRESA], [TIPO], [CONTATO], [TIPO_VISITA], [DATA_MOVIMENTO], [STATUS] FROM [SAW_ACESSO_PORTARIA] A
WHERE (STATUS='SAIDA' AND TIPO='FUNCIONARIO') OR (TIPO='VISITANTE') AND CONVERT(CHAR(10),DATA_MOVIMENTO,103)=CONVERT(CHAR(10),GETDATE(),103) AND NOME NOT IN 
(SELECT NOME FROM SAW_ACESSO_PORTARIA WHERE STATUS='SAIDA' AND NOME=A.NOME)


SELECT * FROM SAW_ACESSO_PORTARIA

SELECT [NOME], [EMPRESA], [TIPO], [CONTATO], [TIPO_VISITA], [DATA_MOVIMENTO], 
CASE [STATUS] WHEN 'ENTRADA' THEN 'PRESENTE' WHEN 'SAIDA' THEN 'AUSENTE' END AS STATUS
FROM [SAW_ACESSO_PORTARIA] WHERE ([DATA_SAIDA_ENTRADA] IS NULL)

case cli.pj_pf	when '1' then 'CNPJ' when '0' then 'CPF' end as TipoCli,


SELECT [NOME], [EMPRESA], [TIPO], [CONTATO], [TIPO_VISITA], [DATA_MOVIMENTO], [STATUS] 
FROM [SAW_ACESSO_PORTARIA] 
WHERE (CONVERT(CHAR(10),DATA_MOVIMENTO,103) = CONVERT(CHAR(10),GETDATE(),103))


SELECT NOME, EMPRESA, TIPO, CONTATO, TIPO_VISITA, DATA_MOVIMENTO, STATUS 
FROM SAW_ACESSO_PORTARIA 
WHERE (CONVERT (CHAR(10), DATA_MOVIMENTO, 103) = CONVERT (CHAR(10), GETDATE(), 103))





SELECT CONVERT(CHAR(10),DATA_MOVIMENTO,103) FROM SAW_ACESSO_PORTARIA
WHERE CONVERT(CHAR(10),DATA_MOVIMENTO,103)=CONVERT(CHAR(10),GETDATE(),103)







