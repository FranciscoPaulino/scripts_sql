SELECT CTB_A_RECEBER_FATURA.LANCAMENTO,CTB_A_RECEBER_FATURA.ITEM,CTB_BORDERO_PARCELA_CMD.LANCAMENTO_MOV,CTB_BORDERO_PARCELA_CMD.ITEM_MOV
FROM CTB_A_RECEBER_FATURA
JOIN CTB_BORDERO_PARCELA_CMD ON CTB_BORDERO_PARCELA_CMD.LANCAMENTO_MOV=CTB_A_RECEBER_FATURA.LANCAMENTO AND CTB_BORDERO_PARCELA_CMD.ITEM_MOV=CTB_A_RECEBER_FATURA.ITEM
WHERE COD_CLIFOR='000001' 
ORDER BY CTB_BORDERO_PARCELA_CMD.LANCAMENTO

DELETE FROM CTB_BORDERO_PARCELA_CMD
WHERE ITEM_MOV='1' AND LANCAMENTO_MOV IN (
'236185',
'239210',
'250867',
'246899',
'242865',
'253067',
'242868',
'246898',
'234751',
'242864',
'242866',
'246895',
'234750',
'243144',
'244695',
'249677',
'249677',
'244695',
'243144',
'234750',
'246895',
'242866',
'242864',
'234751',
'246898',
'242868',
'253067',
'242865',
'246899',
'250867')


select 'delete from CTB_A_RECEBER_FATURA  where lancamento='''+cast(lancamento as varchar(10))+''' and item='''+cast(item as varchar(10))+'''' 
from W_CTB_A_RECEBER_PARCELA
WHERE W_CTB_A_RECEBER_PARCELA.COD_CLIFOR='000001'


delete from CTB_A_RECEBER_FATURA  where lancamento='219331' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='219334' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='219335' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='219337' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='219338' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='220105' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='220107' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='220109' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='220109' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='220111' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='220112' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='221100' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='221102' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='221103' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='221104' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='221105' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='221106' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='223185' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='223201' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='223202' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='223203' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='223203' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='223204' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='224917' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='224918' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='224919' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='224920' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='224920' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='224921' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='227395' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='227396' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='227397' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='227398' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='227406' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='227407' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='229162' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='229164' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='229166' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='229166' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='229167' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='230597' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='230599' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='230600' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='230602' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='230602' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='230604' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='232143' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='232144' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='232145' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='232145' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='232146' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='232148' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='233423' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='233423' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='233424' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='233426' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='233427' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='233428' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='234572' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='234573' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='234574' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='234575' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='234576' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='234747' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='234748' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='234749' and item='1'

delete from CTB_A_RECEBER_FATURA  where lancamento='234750' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='234751' and item='1'

delete from CTB_A_RECEBER_FATURA  where lancamento='234753' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='236182' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='236183' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='236184' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='236185' and item='1'

delete from CTB_A_RECEBER_FATURA  where lancamento='236188' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='236192' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='237707' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='237708' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='237708' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='237709' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='237710' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='237711' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='239132' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='239132' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='239133' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='239134' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='239136' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='239138' and item='1'

delete from CTB_A_RECEBER_FATURA  where lancamento='239210' and item='1'

delete from CTB_A_RECEBER_FATURA  where lancamento='239213' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='240575' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='240577' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='240582' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='240582' and item='3'
delete from CTB_A_RECEBER_FATURA  where lancamento='240582' and item='4'
delete from CTB_A_RECEBER_FATURA  where lancamento='240588' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='240588' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='240589' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='240589' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='240591' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='240591' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='240592' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='240592' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='241734' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='241735' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='241736' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='241737' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='241738' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='241739' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='242863' and item='1'

delete from CTB_A_RECEBER_FATURA  where lancamento='242864' and item='1'

delete from CTB_A_RECEBER_FATURA  where lancamento='242865' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='242866' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='242868' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='243139' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='243140' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='243141' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='243143' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='243144' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='243145' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='243936' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='243938' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='243940' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='243941' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='243944' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='244691' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='244692' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='244692' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='244693' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='244694' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='244695' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='246694' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='246695' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='246696' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='246697' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='246698' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='246895' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='246896' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='246897' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='246898' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='246898' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='246899' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='247022' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='247023' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='247023' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='247024' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='247025' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='247026' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='247953' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='247954' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='247954' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='247956' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='247959' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='247961' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='248457' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='248459' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='248461' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='248462' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='248463' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='249675' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='249677' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='249679' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='249680' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='249681' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='250863' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='250865' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='250865' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='250866' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='250867' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='252207' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='252209' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='252209' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='252210' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='252211' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='252409' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='252411' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='252412' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='252412' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='252414' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='252705' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='252712' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='252713' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='252714' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='253060' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='253060' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='253062' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='253067' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='253069' and item='1'



select 'delete from CTB_A_RECEBER_FATURA  where lancamento='''+cast(lancamento as varchar(10))+''' and item='''+cast(item as varchar(10))+'''' 
from W_CTB_A_RECEBER_PARCELA
WHERE W_CTB_A_RECEBER_PARCELA.COD_CLIFOR='600132'


delete from CTB_A_RECEBER_FATURA  where lancamento='9322' and item='4'
delete from CTB_A_RECEBER_FATURA  where lancamento='226336' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='221153' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='223185' and item='3'
delete from CTB_A_RECEBER_FATURA  where lancamento='216793' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='218137' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='214621' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='233567' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='216398' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='219334' and item='2'
delete from CTB_A_RECEBER_FATURA  where lancamento='220187' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='220187' and item='2'



select 'delete from CTB_A_RECEBER_FATURA  where lancamento='''+cast(lancamento as varchar(10))+''' and item='''+cast(item as varchar(10))+'''' 
from W_CTB_A_RECEBER_PARCELA
WHERE W_CTB_A_RECEBER_PARCELA.COD_CLIFOR='018855'


delete from CTB_A_RECEBER_FATURA  where lancamento='79272' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='69477' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='199882' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='218201' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='218203' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='218205' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='218206' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='218207' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='199603' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='199608' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='199617' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='208783' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='208784' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='143677' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='208785' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='208779' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='208763' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='212435' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='212436' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='212441' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='212442' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='212443' and item='1'
delete from CTB_A_RECEBER_FATURA  where lancamento='199612' and item='1'
