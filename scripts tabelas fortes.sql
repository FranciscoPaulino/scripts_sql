--update pro set csticms='051' where csticms='000'; cancelada por Sayonara em 14/06/2011

delete from hpro

--------
update inm set cfo_codigo='1401', icmsbasecalc=0, icmsoutras=valor, icmsaliq=0, icmsdebcred=0 where cfo_codigo='1101'  ;

update inm set cfo_codigo='2401', icmsbasecalc=0, icmsoutras=valor, icmsaliq=0, icmsdebcred=0 where cfo_codigo='2101';

update pnm set cfo_codigo='1401', cstb = '30' where cfo_codigo='1101';

update pnm set cfo_codigo='2401', cstb = '30' where cfo_codigo='2101';

UPDATE PNM SET TFBASECALCCOFINS=VRTOTAL, TFBASECALCPIS=VRTOTAL

update inm set icmsbasecalc=0, icmsoutras=valor, icmsaliq=0, icmsdebcred=0 where cfo_codigo in('1122','2122','1120','2120','1121','2121','1902','2902','1903','2903','1909','2909' );

update pnm set cstb = '51' where cfo_codigo in('1902','2902','1903','2903','1909','2909' );

--inclusão da linha 19 realizada em 14/06/2011 por Sayonara
update pnm set cstb = '30' where cfo_codigo in('1122','2122','1120','2120','1121','2121' );

--retirado os CFOP 1352 e 2352 da linha 22 em 14/06/2011 por Sayonara
update inm set icmsbasecalc=0, icmsoutras=valor, icmsaliq=0, icmsdebcred=0 where cfo_codigo in('1124','2124','1125','2125','1252','2252','1551','2551','1556','2556','1924','2924','1925','2925' );

update pnm set cstb = '41' where cfo_codigo in('1124','2124','1125','2125','1252','2252','1551','2551','1556','2556','1924','2924','1925','2925','1352','2352' );


update inm set icmsbasecalc=0, icmsoutras=valor, icmsaliq=0, icmsdebcred=0 where cfo_codigo='1401';

update inm set icmsbasecalc=0, icmsoutras=valor, icmsaliq=0, icmsdebcred=0 where cfo_codigo='2401';

update pnm set cstb = '30' where cfo_codigo='1401' or cfo_codigo='2401';

--excluído o cfo_codigo like '5%' da linha 34 e alterado na mesma linha cstb = '60' em 14/06/2011 por Sayonara 
 
--incluído a linha 37 em 14/06/2011 por Sayonara 
update pnm set cstb = '60' where cfo_codigo like '5%';

update pnm set cstb = '60' where cfo_codigo like '6%';

update pnm set cstb = '60' where cfo_codigo like '7%';

update inm set icmsbasecalC=0, icmsaliq=0, icmsoutras=valor, icmsdebcred=0 where cfo_codigo like '5%' or cfo_codigo like '6%' or cfo_codigo like '7%';


-------- Conhecimento de Transporte

-- so esse dia 14/03/2011
UPDATE CTC SET  cfo_codigo='1352' WHERE  cfo_codigo='1353'

UPDATE CTC SET  cfo_codigo='2352' WHERE  cfo_codigo='2353'

update ctc set icmsbasecalc=0, icmsoutras=vrtotal, icmsaliq=0, icmsvr=0, cstb='90' where cfo_codigo in('1352','2352');

UPDATE CTC SET INDNATFRT=0,FRETE='C',CREDCSTPISCOFINS='50',NATBCCRED='07',TFCREDCOFINSPIS=VRTOTAL WHERE CFO_CODIGO IN ('1352','2352')


-------- Energia Eletrica

update cee set icmsbasecalc=0, icmsoutras=vrtotal, icmsaliq=0, icmsvr=0, cstb='90' where cfo_codigo in('1252','2252' );


--alterado a linha 54 cstb ='30' em 18/07/2011 por Sayonara
update pnm set cstb = '41' where cfo_codigo in('2201','1201');


update inm set icmsbasecalc=0, icmsisentas=valor, icmsaliq=0, icmsdebcred=0 where cfo_codigo in('2201','1201');



-------- Acerto CST

update pnm set icmstributacao=2,icmsbasecalc=0, icmsaliq=0 where cstb ='41';

update pnm set icmstributacao=3,icmsbasecalc=0, icmsaliq=0 where cstb ='51';

update pnm set icmstributacao=3,icmsbasecalc=0, icmsaliq=0 where cstb ='00';

update pnm set icmstributacao=3,icmsbasecalc=0, icmsaliq=0 where cstb ='60';

--desmarcado as linhas (69 à 98) em 14/06/2011 por Sayonara
--update pro set codigo_barra = '0000000000000' where codigo_barra='0000000000000000000000000000000000000000'


--- acerto mar 2011

--update pnm set icmstributacao=2,icmsbasecalc=0, icmsaliq=0 where cstb ='30' and cfo_codigo like '5%' or cfo_codigo like '6%' or cfo_codigo like '7%';

--update inm set icmsbasecalc=0, icmsisentas=valor, icmsaliq=0, icmsdebcred=0 where cfo_codigo like '5%' or cfo_codigo like '6%' or cfo_codigo like '7%';

--- acerto fev 2010

--update pnm set icmstributacao=2,icmsbasecalc=0, icmsaliq=0 where cstb ='40' and cfo_codigo in('6910','5910');


--update inm set icmsbasecalc=0, icmsisentas=valor, icmsaliq=0, icmsdebcred=0 where cfo_codigo in('6910','5910');

-- acerto mar 2011 (vendas)


-- so esse dia 14/03/20111
--update pnm set icmstributacao=2,icmsbasecalc=0, icmsaliq=0 where cstb ='00' and cfo_codigo in('6101');


--update inm set icmsbasecalc=0, icmsisentas=valor, icmsaliq=0, icmsdebcred=0 where cfo_codigo in('6101');


--update pnm set icmstributacao=2,icmsbasecalc=0, icmsaliq=0 where cstb ='60' and cfo_codigo in('5101');


--update inm set icmsbasecalc=0, icmsisentas=valor, icmsaliq=0, icmsdebcred=0 where cfo_codigo in('5101');

-- altera unidade medida dief ce
update pro set UNIDMEDDIEFCE=8;
 

-- CALCULO DO PIS E COFINS NOTAS DE SAIDAS

--select * from pnm where cfo_codigo like '5%' or CFO_CODIGO like '6%' or CFO_CODIGO like '7%' order by cfo_codigo


update pnm 
set TFBASECALCCOFINS=VRTOTAL, TFBASECALCPIS=VRTOTAL, VALORCOFINS=(VRTOTAL*ALIQUOTACOFINSPERC)/100, VALORPIS=(VRTOTAL*ALIQUOTAPISPERC)/100
where cfo_codigo like '5%' or CFO_CODIGO like '6%' or CFO_CODIGO like '7%' order by cfo_codigo


--- Alterações solicitadas pela Thyana Jahny 19/07/2012
update pnm set cstb='40',cstpis = '01', cstcofins='01' where cfo_codigo ='6109';

update nfm set tfcredcofinspis=totalvr
where seq in (select distinct nfm_seq from pnm where cfo_codigo='6109')

                                                         

