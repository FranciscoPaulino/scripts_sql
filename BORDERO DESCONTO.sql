declare @cStringFile varchar(max)

set @cStringFile = '1020179024700011100000280236700095303001003445390001J         000000005124000047960000000000000000000000000006271015032908/J  00000000512400004796261015000000002655623701522  000000000000000000000000000000000000000000000000000000000000000000000000000000000000002713200000000005760000000000000                          0000000000                                                                  000002'

select a.posicao, a.tamanho, a.id_comando, b.desc_comando, b.lx_tipo_conteudo, b.lx_tipo_dado, c.descricao_campo,a.lx_topologia,	
	conteudo= case when lx_tipo_conteudo in ('A','L') then substring(@cStringFile, a.posicao, a.tamanho) else valor_campo end, valor_campo	
	from ctb_bordero_layout_campo a																								
		join ctb_bordero_layout_cmd b on a.id_comando=b.id_comando																
		left join ctb_bordero_layout_valida c on a.layout=c.layout and a.lx_topologia=c.lx_topologia and a.posicao=c.posicao	
	where a.lx_topologia like 'T%'																								
		and a.layout='0235'--?v_ctb_lancamento_01_bordero.layout 																		
		and ((b.lx_tipo_conteudo='A' and c.layout is null)																		
		 or(b.lx_tipo_conteudo='T' and valor_campo=substring(@cStringFile,a.posicao,a.tamanho)))								
	order by a.lx_topologia, a.posicao																						
	
SELECT * FROM BORDERO_RETORNO_DESCONTO

truncate table BORDERO_RETORNO_DESCONTO

CREATE TABLE [dbo].[BORDERO_RETORNO_DESCONTO](
    [LINHA_RETORNO] [char](400) NOT NULL
)
GO
BULK INSERT dbo.BORDERO_RETORNO_DESCONTO 
FROM 'C:\temp\DS111100.RET'


INSERT INTO BORDERO_RETORNO_DESCONTO(LINHA_RETORNO) VALUES('02RETORNO01COBRANCA       00000000000000332142LDR INDUSTRIA DE CONFECCOES LT237BRADESCO       0910150160000001197                                                                                                                                                                                                                                                                          091015         000001')

SELECT * FROM dbo.BORDERO_RETORNO_DESCONTO 
ORDER BY LINHA_RETORNO

SELECT * FROM DBO.BORDERO_RETORNO_DESCONTO_PROCESSADO
ORDER BY LINHA_RETORNO


truncate table DBO.BORDERO_RETORNO_DESCONTO_PROCESSADO
CREATE TABLE [dbo].[BORDERO_RETORNO_DESCONTO_PROCESSADO](
    [LINHA_RETORNO] [char](400) NOT NULL,
    [VALOR_ORIGINAL] [CHAR](13) NULL,
    [DESCONTO_CONCEDIDO] [CHAR](13) NULL,
    [VALOR_RECEBIDO] [CHAR](13) NULL,    
    [JUROS_DE_MORA] [CHAR](13) NULL
)

TRUNCATE TABLE BORDERO_RETORNO_DESCONTO_PROCESSADO

---- REG '0'
INSERT INTO BORDERO_RETORNO_DESCONTO_PROCESSADO (LINHA_RETORNO,VALOR_ORIGINAL,DESCONTO_CONCEDIDO,VALOR_RECEBIDO,JUROS_DE_MORA)
SELECT LINHA_RETORNO,NULL,NULL,NULL,NULL
FROM dbo.BORDERO_RETORNO_DESCONTO 
WHERE SUBSTRING(LINHA_RETORNO,1,1)='0' 
---- REG '1'
INSERT INTO BORDERO_RETORNO_DESCONTO_PROCESSADO
SELECT LINHA_RETORNO,
VALOR_ORIGINAL = substring(LINHA_RETORNO,153,13),
DESCONTO_CONCEDIDO = CASE 
WHEN (cast(substring(LINHA_RETORNO,153,13) as numeric(13)) - cast(substring(LINHA_RETORNO,254,13) AS numeric(13))) > 0 
THEN (REPLICATE('0',(13-LEN((cast(substring(LINHA_RETORNO,153,13) as numeric(13)) - cast(substring(LINHA_RETORNO,254,13) AS numeric(13))))))+CAST(cast(substring(LINHA_RETORNO,153,13) as numeric(13)) - cast(substring(LINHA_RETORNO,254,13) AS numeric(13)) AS CHAR(13)))
ELSE '0000000000000' END,
VALOR_RECEBIDO = substring(LINHA_RETORNO,254,13),
JUROS_DE_MORA = CASE 
WHEN (cast(substring(LINHA_RETORNO,153,13) as numeric(13)) - cast(substring(LINHA_RETORNO,254,13) AS numeric(13))) < 0 
THEN (REPLICATE('0',(13-LEN(ABS (cast(substring(LINHA_RETORNO,153,13) as numeric(13)) - cast(substring(LINHA_RETORNO,254,13) AS numeric(13))))))+CAST(ABS(cast(substring(LINHA_RETORNO,153,13) as numeric(13)) - cast(substring(LINHA_RETORNO,254,13) AS numeric(13)))  AS CHAR(13)))
ELSE '0000000000000' END
FROM dbo.BORDERO_RETORNO_DESCONTO 
WHERE SUBSTRING(LINHA_RETORNO,1,1)='1' --and substring(linha_retorno,117,8)='034905/A'
--- REG '9'
INSERT INTO BORDERO_RETORNO_DESCONTO_PROCESSADO (LINHA_RETORNO,VALOR_ORIGINAL,DESCONTO_CONCEDIDO,VALOR_RECEBIDO,JUROS_DE_MORA)
SELECT LINHA_RETORNO,NULL,NULL,NULL,NULL
FROM dbo.BORDERO_RETORNO_DESCONTO 
WHERE SUBSTRING(LINHA_RETORNO,1,1)='9' 

SELECT LINHA_RETORNO FROM BORDERO_RETORNO_DESCONTO_PROCESSADO

---- ATUALIZAR
UPDATE BORDERO_RETORNO_DESCONTO_PROCESSADO
SET LINHA_RETORNO=substring(LINHA_RETORNO,1,240)+
DESCONTO_CONCEDIDO+
substring(LINHA_RETORNO,254,13)+
JUROS_DE_MORA+
substring(LINHA_RETORNO,280,121)
FROM BORDERO_RETORNO_DESCONTO_PROCESSADO
WHERE SUBSTRING(LINHA_RETORNO,1,1)='1' and SUBSTRING(LINHA_RETORNO,109,2)='06'

SELECT LINHA_RETORNO FROM BORDERO_RETORNO_DESCONTO_PROCESSADO