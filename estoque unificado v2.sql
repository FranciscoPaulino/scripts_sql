select ORDEM_PRODUCAO,GRUPO,SUBGRUPO,MATERIAL,DESC_MATERIAL,COR_MATERIAL,DESC_COR_MATERIAL,UNID_ESTOQUE,estVarejo,resVarejo,disVarejo,estGO,resGO,disGO,disTotal,
regras_transf = case 
                  when disTotal<0 then 'Falta Material' 
                  when disVarejo>disGO AND resGO>estGO then 'Transf P/GO' 
                  when disGO>disVarejo AND resVarejo>estVarejo then 'Transf P/Varejo' 
                  else ''
                end 
from (
select pr.ORDEM_PRODUCAO,ma.GRUPO,
ma.SUBGRUPO,
ma.MATERIAL,
ma.DESC_MATERIAL,
mc.COR_MATERIAL,
mc.DESC_COR_MATERIAL,
ma.UNID_ESTOQUE,
mc.INICIO_VENDAS,
mc.fim_vendas,

estVarejo=isnull(( select isnull(QTDE_ESTOQUE,0) from ESTOQUE_MATERIAIS with (nolock) where MATERIAL=mc.MATERIAL and COR_MATERIAL=mc.COR_MATERIAL and FILIAL='DR VAREJO'),0), 
resVarejo=isnull(( select isnull(SUM(RESERVA),0) from PRODUCAO_RESERVA prv with (nolock) join PRODUCAO_ORDEM po with (nolock) on po.ORDEM_PRODUCAO=prv.ORDEM_PRODUCAO join PRODUCAO_TAREFAS pt with (nolock) on pt.ORDEM_PRODUCAO=prv.ORDEM_PRODUCAO where MATERIAL=mc.MATERIAL and COR_MATERIAL=mc.COR_MATERIAL and po.FILIAL='DR VAREJO' and pt.FASE_PRODUCAO<>'001'  and pt.QTDE_EM_PROCESSO>0 group by material,cor_material ),0),
disVarejo=(isnull(( select isnull(QTDE_ESTOQUE,0) from ESTOQUE_MATERIAIS with (nolock) where MATERIAL=mc.MATERIAL and COR_MATERIAL=mc.COR_MATERIAL and FILIAL='DR VAREJO'),0) - isnull(( select isnull(SUM(RESERVA),0) from PRODUCAO_RESERVA prv with (nolock) join PRODUCAO_ORDEM po with (nolock) on po.ORDEM_PRODUCAO=prv.ORDEM_PRODUCAO join PRODUCAO_TAREFAS pt with (nolock) on pt.ORDEM_PRODUCAO=prv.ORDEM_PRODUCAO where MATERIAL=mc.MATERIAL and COR_MATERIAL=mc.COR_MATERIAL and po.FILIAL='DR VAREJO' and pt.FASE_PRODUCAO<>'001'  and pt.QTDE_EM_PROCESSO>0 group by material,cor_material ),0)),

estGO=isnull(( select isnull(QTDE_ESTOQUE,0) from ESTOQUE_MATERIAIS with (nolock) where MATERIAL=mc.MATERIAL and COR_MATERIAL=mc.COR_MATERIAL and FILIAL='D.R. LINGERIE' ),0), 
resGO=isnull(( select isnull(SUM(RESERVA),0) from PRODUCAO_RESERVA pr with (nolock) join PRODUCAO_ORDEM po with (nolock) on po.ORDEM_PRODUCAO=pr.ORDEM_PRODUCAO where MATERIAL=mc.MATERIAL and COR_MATERIAL=mc.COR_MATERIAL and po.FILIAL='D.R. LINGERIE' group by material,cor_material ),0),
disGO=(isnull(( select isnull(QTDE_ESTOQUE,0) from ESTOQUE_MATERIAIS with (nolock) where MATERIAL=mc.MATERIAL and COR_MATERIAL=mc.COR_MATERIAL and FILIAL='D.R. LINGERIE' ),0) - isnull(( select isnull(SUM(RESERVA),0) from PRODUCAO_RESERVA pr with (nolock) join PRODUCAO_ORDEM po with (nolock) on po.ORDEM_PRODUCAO=pr.ORDEM_PRODUCAO where MATERIAL=mc.MATERIAL and COR_MATERIAL=mc.COR_MATERIAL and po.FILIAL='D.R. LINGERIE' group by material,cor_material ),0)),
disTotal=((isnull(( select isnull(QTDE_ESTOQUE,0) from ESTOQUE_MATERIAIS with (nolock) where MATERIAL=mc.MATERIAL and COR_MATERIAL=mc.COR_MATERIAL and FILIAL='DR VAREJO'),0) - isnull(( select isnull(SUM(RESERVA),0) from PRODUCAO_RESERVA pr with (nolock) join PRODUCAO_ORDEM po with (nolock) on po.ORDEM_PRODUCAO=pr.ORDEM_PRODUCAO where MATERIAL=mc.MATERIAL and COR_MATERIAL=mc.COR_MATERIAL and po.FILIAL='DR VAREJO' group by material,cor_material ),0))+(isnull(( select isnull(QTDE_ESTOQUE,0) from ESTOQUE_MATERIAIS with (nolock) where MATERIAL=mc.MATERIAL and COR_MATERIAL=mc.COR_MATERIAL and FILIAL='D.R. LINGERIE' ),0) - isnull(( select isnull(SUM(RESERVA),0) from PRODUCAO_RESERVA pr with (nolock) join PRODUCAO_ORDEM po with (nolock) on po.ORDEM_PRODUCAO=pr.ORDEM_PRODUCAO where MATERIAL=mc.MATERIAL and COR_MATERIAL=mc.COR_MATERIAL and po.FILIAL='D.R. LINGERIE' group by material,cor_material ),0)))
from MATERIAIS_CORES mc with (nolock)
join MATERIAIS ma with (nolock) on ma.MATERIAL=mc.MATERIAL 
join (select ORDEM_PRODUCAO,MATERIAL,COR_MATERIAL from PRODUCAO_RESERVA with (nolock) where ORDEM_PRODUCAO not like '%.%' and RESERVA>0) pr on pr.MATERIAL=mc.MATERIAL and pr.COR_MATERIAL=mc.COR_MATERIAL
WHERE mc.MATERIAL='15.04.0010' and mc.COR_MATERIAL='1206' --pr.ORDEM_PRODUCAO IN('180638','180677')
) as estoque_final
where GETDATE() between INICIO_VENDAS AND FIM_VENDAS



select * --SUM(RESERVA)
from PRODUCAO_RESERVA prv with (nolock) 
join PRODUCAO_ORDEM po with (nolock) on po.ORDEM_PRODUCAO=prv.ORDEM_PRODUCAO 
join PRODUCAO_TAREFAS pt with (nolock) on pt.ORDEM_PRODUCAO=prv.ORDEM_PRODUCAO
where prv.ORDEM_PRODUCAO='180677' AND MATERIAL='15.04.0010' and COR_MATERIAL='1206' and po.FILIAL='DR VAREJO' and pt.FASE_PRODUCAO='001' and pt.QTDE_EM_PROCESSO>0
group by prv.ORDEM_PRODUCAO,material,cor_material 


select SUM(RESERVA)
from PRODUCAO_RESERVA prv with (nolock) 
join PRODUCAO_ORDEM po with (nolock) on po.ORDEM_PRODUCAO=prv.ORDEM_PRODUCAO 
join PRODUCAO_TAREFAS pt with (nolock) on pt.ORDEM_PRODUCAO=prv.ORDEM_PRODUCAO
where MATERIAL='70.35.0010' and COR_MATERIAL='001' and po.FILIAL='DR VAREJO' and pt.FASE_PRODUCAO<>'001'  and pt.QTDE_EM_PROCESSO>0
group by pt.ORDEM_PRODUCAO, material,cor_material 
