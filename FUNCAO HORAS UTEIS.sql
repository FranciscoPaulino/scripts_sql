SELECT *,
QtdTotalHorasUteis = CASE WHEN ISNULL(B.DATA_PARA_TRANSFERENCIA,0) = 0 THEN dbo.FN_CALC_HORAS_UTEIS(C.DATA_ALTERACAO_STATUS, GETDATE())  ELSE dbo.FN_CALC_HORAS_UTEIS(C.DATA_ALTERACAO_STATUS, B.DATA_PARA_TRANSFERENCIA) END,
DATEDIFF(hh, C.DATA_ALTERACAO_STATUS, B.DATA_PARA_TRANSFERENCIA) diferencaHoras,
DATEDIFF(dd, C.DATA_ALTERACAO_STATUS, B.DATA_PARA_TRANSFERENCIA) diferencaDias
FROM VENDAS A with (nolock)
LEFT JOIN (SELECT * FROM PROP_VENDAS with (nolock) WHERE PROPRIEDADE='00264') B ON B.PEDIDO=A.PEDIDO
JOIN (SELECT PEDIDO,STATUS,DATA_ALTERACAO_STATUS=MAX(DATA_ALTERACAO_STATUS) FROM VENDAS_STATUS_LOG with (nolock) WHERE STATUS='A' GROUP BY PEDIDO,STATUS) C ON C.PEDIDO=A.PEDIDO
WHERE A.PEDIDO IN ('82940','73049')

SELECT * FROM VENDAS_STATUS_LOG A
WHERE STATUS='A' AND EXISTS(SELECT * FROM PROP_VENDAS WHERE PEDIDO=A.PEDIDO ) --AND PEDIDO='33683'

SELECT * FROM PROP_VENDAS
WHERE PROPRIEDADE='00264' and PEDIDO='82940'

SELECT *,
QtdTotalHorasUteis = CASE WHEN ISNULL(B.DATA_PARA_TRANSFERENCIA,0) = 0 THEN dbo.FN_CALC_HORAS_UTEIS(C.DATA_ALTERACAO_STATUS, GETDATE())  ELSE dbo.FN_CALC_HORAS_UTEIS(C.DATA_ALTERACAO_STATUS, B.DATA_PARA_TRANSFERENCIA) END,
DATEDIFF(mi, C.DATA_ALTERACAO_STATUS, B.DATA_PARA_TRANSFERENCIA) diferencaMinutos,
DATEDIFF(hh, C.DATA_ALTERACAO_STATUS, B.DATA_PARA_TRANSFERENCIA) diferencaHoras,
DATEDIFF(dd, C.DATA_ALTERACAO_STATUS, B.DATA_PARA_TRANSFERENCIA) diferencaDias,
DATEDIFF(mm, C.DATA_ALTERACAO_STATUS, B.DATA_PARA_TRANSFERENCIA) diferencaMeses,
DATEDIFF(yy, C.DATA_ALTERACAO_STATUS, B.DATA_PARA_TRANSFERENCIA) diferencaAnos
FROM VENDAS A with (nolock)
LEFT JOIN (SELECT * FROM PROP_VENDAS with (nolock) WHERE PROPRIEDADE='00264') B ON B.PEDIDO=A.PEDIDO
JOIN (SELECT PEDIDO,STATUS,DATA_ALTERACAO_STATUS=MAX(DATA_ALTERACAO_STATUS) FROM VENDAS_STATUS_LOG with (nolock) WHERE STATUS='A' GROUP BY PEDIDO,STATUS) C ON C.PEDIDO=A.PEDIDO
WHERE A.PEDIDO IN ('82940','73049')


-- Criação de tabela temporária
CREATE TABLE #SistemaDemandas
 (
 id INT IDENTITY(1, 1) PRIMARY KEY
 ,dataAbertura DATETIME
 ,dataFechamento DATETIME
 )
 
-- Insert da massa de dados para teste
INSERT INTO #SistemaDemandas
 (dataAbertura, dataFechamento)
VALUES
 ('2016-03-01 09:12:00', '2016-03-03 15:17:00')
 ,('2016-03-01 08:58:00', '2016-03-01 10:12:00')
 ,('2016-03-02 07:20:00', '2016-04-08 19:15:00')
 ,('2016-03-04 18:50:00', '2016-03-07 10:50:00')
 ,('2016-06-01 15:12:00', '2017-08-30 09:10:00')
 
-- Exemplos da função DATEDIFF - SQL Server
SELECT
 *
 ,DATEDIFF(mi, dataAbertura, dataFechamento) diferencaMinutos
 ,DATEDIFF(hh, dataAbertura, dataFechamento) diferencaHoras
 ,DATEDIFF(dd, dataAbertura, dataFechamento) diferencaDias
 ,DATEDIFF(mm, dataAbertura, dataFechamento) diferencaMeses
 ,DATEDIFF(yy, dataAbertura, dataFechamento) diferencaAnos
FROM
 #SistemaDemandas

 SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
/*
Função para verificar se a data informada é um dia útil
SELECT dbo.FN_DIA_NAO_TRAB ('2016-01-01')
*/
 
CREATE FUNCTION [dbo].[FN_DIA_NAO_TRAB]
 (
 @data SMALLDATETIME
 )
RETURNS BIT
AS
BEGIN
 
 DECLARE @num TINYINT
 DECLARE @flgDataNaoUtil BIT
 
 IF DATENAME(dw, @data) IN ('Sunday', 'Saturday')
 BEGIN
 SET @num = 1
 END
 
 IF @num > 0
 BEGIN
 SET @flgDataNaoUtil = 1
 END
 ELSE
 BEGIN
 SET @flgDataNaoUtil = 0
 END
 
 RETURN @flgDataNaoUtil
 
END

SP_HELPTEXT FN_CALC_HORAS_UTEIS

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
 
/*
Calcula o número de horas úteis a partir de uma data inicial, assumindo um prazo em horas.
*/
 
CREATE FUNCTION [dbo].[FN_CALC_HORAS_UTEIS]
(
@dInicial DATETIME
,@dFinal DATETIME
)
RETURNS VARCHAR(10)
AS
BEGIN
 
DECLARE @dInicialTemp DATETIME
DECLARE @dFinalTemp DATETIME
 
DECLARE @tHoraEntrada TIME
DECLARE @tSaidaAlmoco TIME
DECLARE @tRetornoAlmoco TIME
DECLARE @tHoraSaida TIME
 
DECLARE @iAlmoco INT = 0
DECLARE @iDiasInuteis INT = 0
DECLARE @iMinutos INT = 0
DECLARE @iMinutosUteisDia INT = 0
DECLARE @iMinutosTotaisDia INT = 0
 
DECLARE @QtdHoras VARCHAR(10)
 
SET @tHoraEntrada = '07:30'
SET @tSaidaAlmoco = '00:00'
SET @tRetornoAlmoco = '00:00'
SET @tHoraSaida = '17:30'
SET @QtdHoras = 0
 
 
/*PRINT('DATA INICIAL: ' + CONVERT(VARCHAR, @dInicial)) */
/*PRINT('DATA FINAL: ' + CONVERT(VARCHAR, @dFinal)) */
 
IF CAST(@dInicial AS TIME) <= @tSaidaAlmoco
AND CAST(@dFinal AS TIME) >= @tRetornoAlmoco
BEGIN
SET @iAlmoco = DATEDIFF(MINUTE, @tSaidaAlmoco, @tRetornoAlmoco)
/* PRINT('ALMOCO: ' + CONVERT(VARCHAR,@iAlmoco)) */
END
 
 
--WHILE DATEPART(DW, @dInicial) IN (1, 7)
WHILE (
SELECT
dbo.FN_DIA_NAO_TRAB(@dInicial)
) = 1
AND @dInicial < @dFinal
BEGIN
SET @dInicial = CONVERT(DATETIME, CONVERT(VARCHAR, @dInicial + 1, 112))
+ CONVERT(VARCHAR, (REPLICATE('0',
2
- LEN(CONVERT(VARCHAR, DATEPART(HOUR,
@tHoraEntrada))))
+ CONVERT(VARCHAR, DATEPART(HOUR,
@tHoraEntrada)))
+ ':' + (REPLICATE('0',
2 - LEN(CONVERT(VARCHAR, DATEPART(MINUTE,
@tHoraEntrada))))
+ CONVERT(VARCHAR, DATEPART(MINUTE, @tHoraEntrada))))
/* PRINT ('D.INICIAL + 1º DIA UTIL: ' + CONVERT(VARCHAR, @dInicial)) */
END
 
WHILE (
SELECT
dbo.FN_DIA_NAO_TRAB(@dFinal)
) = 1
AND @dInicial < @dFinal
BEGIN
SET @dFinal = CONVERT(DATETIME, CONVERT(VARCHAR, @dFinal + 1, 112))
+ CONVERT(VARCHAR, (REPLICATE('0',
2
- LEN(CONVERT(VARCHAR, DATEPART(HOUR,
@tHoraSaida))))
+ CONVERT(VARCHAR, DATEPART(HOUR,
@tHoraSaida)))
+ ':' + (REPLICATE('0',
2 - LEN(CONVERT(VARCHAR, DATEPART(MINUTE,
@tHoraSaida))))
+ CONVERT(VARCHAR, DATEPART(MINUTE, @tHoraSaida))))
/* PRINT ('D.FINAL + 1º DIA UTIL: ' + CONVERT(VARCHAR, @dFinal)) */
END
 
SET @dInicialTemp = CONVERT(DATETIME, CONVERT(VARCHAR, @dInicial, 112))
+ CONVERT(VARCHAR, (REPLICATE('0',
2 - LEN(CONVERT(VARCHAR, DATEPART(HOUR,
@tHoraEntrada))))
+ CONVERT(VARCHAR, DATEPART(HOUR, @tHoraEntrada)))
+ ':' + (REPLICATE('0',
2 - LEN(CONVERT(VARCHAR, DATEPART(MINUTE,
@tHoraEntrada))))
+ CONVERT(VARCHAR, DATEPART(MINUTE, @tHoraEntrada))))
/*PRINT ('D.INICIAL TEMP: ' + CONVERT(VARCHAR, @dInicialTemp)) */
 
SET @dFinalTemp = CONVERT(DATETIME, CONVERT(VARCHAR, @dFinal, 112))
+ CONVERT(VARCHAR, (REPLICATE('0',
2 - LEN(CONVERT(VARCHAR, DATEPART(HOUR,
@tHoraEntrada))))
+ CONVERT(VARCHAR, DATEPART(HOUR, @tHoraEntrada)))
+ ':' + (REPLICATE('0',
2 - LEN(CONVERT(VARCHAR, DATEPART(MINUTE,
@tHoraEntrada))))
+ CONVERT(VARCHAR, DATEPART(MINUTE, @tHoraEntrada))))
/*PRINT ('D.FINAL TEMP: ' + CONVERT(VARCHAR, @dFinalTemp)) */
 
SET @iMinutosUteisDia = DATEDIFF(MINUTE, @tHoraEntrada, @tSaidaAlmoco)
+ DATEDIFF(MINUTE, @tRetornoAlmoco, @tHoraSaida)
/*PRINT('MINUTOS UTEIS: ' + CONVERT(VARCHAR, @iMinutosUteisDia)) */
 
SET @iMinutosTotaisDia = DATEDIFF(MINUTE, @tHoraEntrada, @tHoraSaida)
/*PRINT('TOTAL MINUTOS DIA: ' + CONVERT(VARCHAR, @iMinutosTotaisDia)) */
 
SET @iMinutos = DATEDIFF(DD, @dInicial, @dFinal) * @iMinutosUteisDia
+ ((
SELECT
CASE WHEN DATEDIFF(MI, @dInicialTemp, @dInicial) < 0 THEN 0
WHEN DATEDIFF(MI, @dInicialTemp, @dInicial) > @iMinutosTotaisDia
THEN @iMinutosTotaisDia
ELSE DATEDIFF(MI, @dInicialTemp, @dInicial)
END
) * -1
+ (
SELECT
CASE WHEN DATEDIFF(MI, @dFinalTemp, @dFinal) < 0 THEN 0
WHEN DATEDIFF(MI, @dFinalTemp, @dFinal) > @iMinutosTotaisDia
THEN @iMinutosTotaisDia
ELSE DATEDIFF(MI, @dFinalTemp, @dFinal)
END
))
+ (
SELECT
CASE WHEN CAST(@dInicial AS TIME) >= @tRetornoAlmoco
AND CAST(@dInicial AS TIME) <> CAST(@dFinal AS TIME)
THEN @iMinutosTotaisDia - @iMinutosUteisDia
ELSE 0
END
)
- (
SELECT
CASE WHEN CAST(@dFinal AS TIME) >= @tSaidaAlmoco
AND CAST(@dFinal AS TIME) <= @tRetornoAlmoco
THEN @iMinutosTotaisDia - @iMinutosUteisDia
ELSE 0
END
)
 
/*PRINT(CONVERT(VARCHAR, ((DATEDIFF(DD, @dInicial, @dFinal) * @iMinutosUteisDia) +(@iTEMP * -1 + @iTEMP2)))) */
/*PRINT('DIAS ENTRE INI & FIM * MINUTOS UTEIS: ' + CONVERT(VARCHAR, DATEDIFF(DD, @dInicial, @dFinal) * @iMinutosUteisDia)) */
/*PRINT('MINUTOS ENTRE INI.TEMP & INI: ' + CONVERT(VARCHAR, DATEDIFF(MI, @dInicialTemp, @dInicial))) */
/*PRINT('MINUTOS ENTRE FIM.TEMP & FIM: ' + CONVERT(VARCHAR, DATEDIFF(MI, @dFinalTemp, @dFinal))) */
/*PRINT('MINUTOS: ' + CONVERT(VARCHAR, @iMinutos)) */
 
WHILE @dInicial < = @dFinal
BEGIN
IF (
SELECT
dbo.FN_DIA_NAO_TRAB(@dInicial)
) = 1
BEGIN
SET @iDiasInuteis = @iDiasInuteis + 1
END
SET @dInicial = @dInicial + 1
END
/*PRINT('DIAS INUTEIS: ' + CONVERT(VARCHAR, @iDiasInuteis)) */
 
SET @iMinutos = (
SELECT
CASE WHEN @iMinutos < (@iDiasInuteis
* @iMinutosTotaisDia) THEN 0
ELSE @iMinutos - (@iDiasInuteis
* @iMinutosUteisDia)
END
)
/*PRINT('MINUTOS - DIAS INUTEIS: ' + CONVERT(VARCHAR, @iMinutos)) */
 
SET @iMinutos = @iMinutos - @iAlmoco
/*PRINT('ALMOCO: ' + CONVERT(VARCHAR, @iAlmoco)) */
/*PRINT('MINUTOS - ALMOCO: ' + CONVERT(VARCHAR, @iMinutos)) */
 
/*PRINT('CONVERSAO DE MINUTOS EM HORAS: ' + CONVERT(VARCHAR, CONVERT(int, @iMinutos / 60)) + ':' + RIGHT(CONVERT(VARCHAR, CONVERT(int, @iMinutos % 60) + 100), 2) ) */
 
SET @QtdHoras = CONVERT(VARCHAR, CONVERT(INT, @iMinutos / 60)) + ':'
+ RIGHT(CONVERT(VARCHAR, CONVERT(INT, @iMinutos % 60) + 100), 2)
 
RETURN @QtdHoras
 
END


-- Exemplos da função DATEDIFF - SQL Server
SELECT
*
,dbo.FN_CALC_HORAS_UTEIS(dataAbertura, dataFechamento) AS QtdTotalHorasUteis
,DATEDIFF(mi, dataAbertura, dataFechamento) diferencaMinutos
,DATEDIFF(hh, dataAbertura, dataFechamento) diferencaHoras
,DATEDIFF(dd, dataAbertura, dataFechamento) diferencaDias
,DATEDIFF(mm, dataAbertura, dataFechamento) diferencaMeses
,DATEDIFF(yy, dataAbertura, dataFechamento) diferencaAnos
FROM
#SistemaDemandas

-- Exemplos da função DATEDIFF - SQL Server
SELECT
 *
 ,DATEDIFF(mi, dataAbertura, dataFechamento) diferencaMinutos
 ,DATEDIFF(hh, dataAbertura, dataFechamento) diferencaHoras
 ,DATEDIFF(dd, dataAbertura, dataFechamento) diferencaDias
 ,DATEDIFF(mm, dataAbertura, dataFechamento) diferencaMeses
 ,DATEDIFF(yy, dataAbertura, dataFechamento) diferencaAnos
FROM
 #SistemaDemandas
