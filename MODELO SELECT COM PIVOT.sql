--- LINHAS PARA COLUNAS
select 
pedido,caixa,produto,cor_produto,grade,
[1]=isnull([1],0),
[2]=isnull([2],0),
[3]=isnull([3],0),
[4]=isnull([4],0),
[5]=isnull([5],0),
[6]=isnull([6],0),
[7]=isnull([7],0),
[8]=isnull([8],0),
[9]=isnull([9],0),
[10]=isnull([10],0),
[11]=isnull([11],0),
[12]=isnull([12],0),
[13]=isnull([13],0),
[14]=isnull([14],0),
[15]=isnull([15],0),
[16]=isnull([16],0)
from (
select pedido,produto,cor_produto,caixa,GRADE,ORDEM_TAMANHO,QTDE
from HOMOLOGACAO.dbo.W_FATURAMENTO_PROD_VERTICAL 
) as fpv
pivot(sum(qtde) for ordem_tamanho in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16])) as ptp
where produto='1233'
ORDER by pedido,produto,cor_produto,caixa



---- COLUNAS PARA LINHAS
SELECT PRODUTO,COR_PRODUTO,TAMANHO,QTDE
FROM (SELECT PRODUTO,COR_PRODUTO,VO1=SUM(VO1),VO2=SUM(VO2),VO3=SUM(VO3),VO4=SUM(VO4),VO5=SUM(VO5),VO6=SUM(VO6),VO7=SUM(VO7),VO8=SUM(VO8),
VO9=SUM(VO9),VO10=SUM(VO10),VO11=SUM(VO11),VO12=SUM(VO12),VO13=SUM(VO13),VO14=SUM(VO14),VO15=SUM(VO15),VO16=SUM(VO16) 
FROM VENDAS_PRODUTO where produto='1233' GROUP BY PRODUTO,COR_PRODUTO) P
UNPIVOT
   (QTDE FOR TAMANHO IN 
      (VO1,VO2,VO3,VO4,VO5,VO6,VO7,VO8,VO9,VO10,VO11,VO12,VO13,VO14,VO15,VO16)
)AS unpvt
ORDER BY PRODUTO,COR_PRODUTO




SELECT PRODUTO,COR_PRODUTO,VO1=SUM(VO1),VO2=SUM(VO2),VO3=SUM(VO3),VO4=SUM(VO4),VO5=SUM(VO5),VO6=SUM(VO6),VO7=SUM(VO7),VO8=SUM(VO8),
VO9=SUM(VO9),VO10=SUM(VO10),VO11=SUM(VO11),VO12=SUM(VO12),VO13=SUM(VO13),VO14=SUM(VO14),VO15=SUM(VO15),VO16=SUM(VO16) 
FROM VENDAS_PRODUTO where produto='1233' GROUP BY PRODUTO,COR_PRODUTO
ORDER BY PRODUTO,COR_PRODUTO


