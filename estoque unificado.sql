select GRUPO,SUBGRUPO,MATERIAL,DESC_MATERIAL,COR_MATERIAL,DESC_COR_MATERIAL,UNID_ESTOQUE,estVarejo,resVarejo,disVarejo,estGO,resGO,disGO,disTotal,
regras_transf = case 
               when disTotal<0 then 'Falta Material' 
               when disVarejo>disGO AND resGO>estGO then 'Transf P/GO' 
               when disGO>disVarejo AND resVarejo>estVarejo then 'Transf P/Varejo' 
               else 'OK'
            end 
from (
select ma.GRUPO,
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
disTotal=((isnull(( select isnull(QTDE_ESTOQUE,0) from ESTOQUE_MATERIAIS with (nolock) where MATERIAL=mc.MATERIAL and COR_MATERIAL=mc.COR_MATERIAL and FILIAL='DR VAREJO'),0) - isnull(( select isnull(SUM(RESERVA),0) from PRODUCAO_RESERVA prv with (nolock) join PRODUCAO_ORDEM po with (nolock) on po.ORDEM_PRODUCAO=prv.ORDEM_PRODUCAO join PRODUCAO_TAREFAS pt with (nolock) on pt.ORDEM_PRODUCAO=prv.ORDEM_PRODUCAO where MATERIAL=mc.MATERIAL and COR_MATERIAL=mc.COR_MATERIAL and po.FILIAL='DR VAREJO' and pt.FASE_PRODUCAO<>'001'  and pt.QTDE_EM_PROCESSO>0 group by material,cor_material ),0))+(isnull(( select isnull(QTDE_ESTOQUE,0) from ESTOQUE_MATERIAIS with (nolock) where MATERIAL=mc.MATERIAL and COR_MATERIAL=mc.COR_MATERIAL and FILIAL='D.R. LINGERIE' ),0) - isnull(( select isnull(SUM(RESERVA),0) from PRODUCAO_RESERVA pr with (nolock) join PRODUCAO_ORDEM po with (nolock) on po.ORDEM_PRODUCAO=pr.ORDEM_PRODUCAO where MATERIAL=mc.MATERIAL and COR_MATERIAL=mc.COR_MATERIAL and po.FILIAL='D.R. LINGERIE' group by material,cor_material ),0)))
from MATERIAIS_CORES mc with (nolock)
join MATERIAIS ma with (nolock) on ma.MATERIAL=mc.MATERIAL 
) as estoque_final
where GETDATE() between INICIO_VENDAS AND FIM_VENDAS