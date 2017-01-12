SELECT EMPRESA,LANCAMENTO,ITEM,CONTA_CONTABIL,LX_TIPO_LANCAMENTO,CREDITO,DEBITO FROM ctb_lancamento_item
WHERE CONTA_CONTABIL='112010401' AND LX_TIPO_LANCAMENTO='BTR'
ORDER BY CONTA_CONTABIL 


UPDATE ctb_lancamento_item
SET CONTA_CONTABIL='1120101'
WHERE CONTA_CONTABIL='112010401' AND LX_TIPO_LANCAMENTO='BTR'


-- ANTIGO
update c set c.conta_contabil='1120101' from ctb_bordero a   
left join ctb_lancamento b on a.lancamento=b.lancamento      
left join ctb_lancamento_item c on a.lancamento=c.lancamento 
where a.layout='0037'                                        
and c.lx_tipo_lancamento='BTR'                               
and c.conta_contabil = '112010401'    


-- NOVO
update c set c.conta_contabil='1120101' from ctb_bordero a   
left join ctb_lancamento b on a.lancamento=b.lancamento      
left join ctb_lancamento_item c on a.lancamento=c.lancamento 
where a.layout='0137'                                        
and c.lx_tipo_lancamento='BTR'                               
and c.conta_contabil = '112010401'    


                      

select b.DATA_LANCAMENTO, c.CONTA_CONTABIL from ctb_bordero a   
left join ctb_lancamento b on a.lancamento=b.lancamento      
left join ctb_lancamento_item c on a.lancamento=c.lancamento 
where a.layout='0137'                                        
and c.lx_tipo_lancamento='BTR'                               
and c.conta_contabil = '112010401'         
and b.DATA_LANCAMENTO between '20131001' AND '20131031'


-- BRADESCO
update c set c.conta_contabil='1120101' from ctb_bordero a   
left join ctb_lancamento b on a.lancamento=b.lancamento      
left join ctb_lancamento_item c on a.lancamento=c.lancamento 
where a.layout='0135'                                        
and c.lx_tipo_lancamento='BTR'                               
and c.conta_contabil = '112010402'                          


UPDATE ctb_lancamento_item
SET CONTA_CONTABIL='1120101'
WHERE CONTA_CONTABIL='112010402' AND LX_TIPO_LANCAMENTO='BTR'



select c.conta_contabil from ctb_bordero a   
left join ctb_lancamento b on a.lancamento=b.lancamento      
left join ctb_lancamento_item c on a.lancamento=c.lancamento 
where a.layout='0135'                                        
and c.lx_tipo_lancamento='BTR'                               
and c.conta_contabil = '112010402'                          



SELECT CONTA_CONTABIL FROM ctb_lancamento_item
WHERE CONTA_CONTABIL='112010402' AND LX_TIPO_LANCAMENTO='BTR'
ORDER BY CONTA_CONTABIL


select * from CTB_CONTA_PLANO
WHERE CONTA_CONTABIL='1120101'

