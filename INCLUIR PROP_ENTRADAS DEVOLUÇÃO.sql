use DRVAREJO

select * from ENTRADAS
WHERE NF_ENTRADA='6280'

select * from PROP_ENTRADAS

INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','012116',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='6280'

INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','007685',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='033053'

INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','040905',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='1322' AND SERIE_NF_ENTRADA='D'

INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','013494',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='228419' AND SERIE_NF_ENTRADA='1'

INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','009536',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='0101' AND SERIE_NF_ENTRADA='1' AND TIPO_ENTRADAS='PRODUTO ACABADO'


INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','008180',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='72' AND SERIE_NF_ENTRADA='A' AND TIPO_ENTRADAS='PRODUTO ACABADO'

UPDATE PROP_ENTRADAS
SET VALOR_PROPRIEDADE='028495'
WHERE NF_ENTRADA='72' AND SERIE_NF_ENTRADA='A'


INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','004141',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='1973' AND SERIE_NF_ENTRADA='2' AND TIPO_ENTRADAS='PRODUTO ACABADO'

INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','00452',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='4175190' AND SERIE_NF_ENTRADA='890' AND TIPO_ENTRADAS='PRODUTO ACABADO'

INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','012454',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='034' AND SERIE_NF_ENTRADA='1' AND TIPO_ENTRADAS='PRODUTO ACABADO'


INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','011138',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='1550' AND SERIE_NF_ENTRADA='A' AND TIPO_ENTRADAS='PRODUTO ACABADO'

SELECT * FROM PROP_ENTRADAS
WHERE NF_ENTRADA='1550'



INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','006597',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='694' AND SERIE_NF_ENTRADA='1' AND TIPO_ENTRADAS='PRODUTO ACABADO'


INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','011685',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='15' AND SERIE_NF_ENTRADA='1' AND TIPO_ENTRADAS='PRODUTO ACABADO'


INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','004133',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='377' AND SERIE_NF_ENTRADA='D1' AND TIPO_ENTRADAS='PRODUTO ACABADO'


INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','011551',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='84' AND SERIE_NF_ENTRADA='1' AND TIPO_ENTRADAS='PRODUTO ACABADO'


INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','013053',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='013' AND SERIE_NF_ENTRADA='1' AND TIPO_ENTRADAS='PRODUTO ACABADO'


INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','000522',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='6113' AND SERIE_NF_ENTRADA='2' AND TIPO_ENTRADAS='PRODUTO ACABADO'


INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','012622',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='440' AND SERIE_NF_ENTRADA='1' AND TIPO_ENTRADAS='PRODUTO ACABADO'



INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','014665',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='0037' AND SERIE_NF_ENTRADA='1' AND TIPO_ENTRADAS='PRODUTO ACABADO'


INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','014248',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='36' AND SERIE_NF_ENTRADA='1' AND TIPO_ENTRADAS='PRODUTO ACABADO'


INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','010364',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='3092' AND SERIE_NF_ENTRADA='D1' AND TIPO_ENTRADAS='PRODUTO ACABADO'


INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','010364',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='3093' AND SERIE_NF_ENTRADA='D1' AND TIPO_ENTRADAS='PRODUTO ACABADO'


INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','007088',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='000699' AND SERIE_NF_ENTRADA='D' AND TIPO_ENTRADAS='PRODUTO ACABADO'


INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','013102',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='24' AND SERIE_NF_ENTRADA='A' AND TIPO_ENTRADAS='PRODUTO ACABADO'

INSERT INTO PROP_ENTRADAS
select '00100',NF_ENTRADA,SERIE_NF_ENTRADA,NOME_CLIFOR,'1','070418',GETDATE() from ENTRADAS
WHERE NF_ENTRADA='324' AND SERIE_NF_ENTRADA='1' AND TIPO_ENTRADAS='PRODUTO ACABADO'



SELECT * FROM PROP_ENTRADAS
WHERE NF_ENTRADA='000699' AND PROPRIEDADE='00100'

UPDATE PROP_ENTRADAS
SET VALOR_PROPRIEDADE='005452'
WHERE NF_ENTRADA='4175190' AND PROPRIEDADE='00100'
