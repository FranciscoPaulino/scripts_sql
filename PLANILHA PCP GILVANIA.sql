SELECT * FROM Table_Qtde_Mes_VENDA

drop table Table_Qtde_Mes_VENDA
go

select PRODUTO,cor_produto,tamanho,grade,mes,qtde=SUM(qtde) 
into Table_Qtde_Mes_VENDA from (
select a.produto,
a.cor_produto,
c.TAMANHO,
c.GRADE,
month(b.emissao) as mes,
qtde=(CASE WHEN c.tamanho='1'  THEN a.Vo1
           WHEN c.tamanho='2'  THEN a.Vo2
           WHEN c.tamanho='3'  THEN a.Vo3
           WHEN c.tamanho='4'  THEN a.Vo4
           WHEN c.tamanho='5'  THEN a.Vo5
           WHEN c.tamanho='6'  THEN a.Vo6
           WHEN c.tamanho='7'  THEN a.Vo7
           WHEN c.tamanho='8'  THEN a.Vo8
           WHEN c.tamanho='9'  THEN a.Vo9
           WHEN c.tamanho='10' THEN a.Vo10
           WHEN c.tamanho='11' THEN a.Vo11
           WHEN c.tamanho='12' THEN a.Vo12
           WHEN c.tamanho='13' THEN a.Vo13
           WHEN c.tamanho='14' THEN a.Vo14
           WHEN c.tamanho='15' THEN a.Vo15
           WHEN c.tamanho='16' THEN a.Vo16
END)
from vendas_produto a with (nolock)  
join vendas b with (nolock) on b.pedido = a.pedido    
join produtos_barra c with (nolock) on c.produto=a.produto and c.cor_produto=a.cor_produto 
where b.emissao between (GETDATE()-365) and GETDATE() 
and  b.tabela_filha = 'VENDAS_PRODUTO' and  b.aprovacao <> 'R' 
and  b.filial ='DR VAREJO' and c.codigo_barra_padrao=1
) as vendas_produto
group by 
vendas_produto.produto,
vendas_produto.cor_produto,
vendas_produto.TAMANHO,
vendas_produto.GRADE,
vendas_produto.mes


CREATE FUNCTION dbo.Qtde_Mes_VENDA_TABLE (@produto varchar(10),@cor_produto varchar(10),@tamanho char(2))      
RETURNS int      
WITH EXECUTE AS CALLER      
AS      
BEGIN      
     DECLARE @Retorno int      
     IF (LTRIM(@tamanho)='1')      
         SET @Retorno = (
		 select count(mes) as qtde_mes_venda 
		 from Table_Qtde_Mes_VENDA
		 where produto=@produto and cor_produto=@cor_produto and tamanho=@tamanho and qtde<>0
         )      
     IF (LTRIM(@tamanho)='2')      
         SET @Retorno = (
		 select count(mes) as qtde_mes_venda 
		 from Table_Qtde_Mes_VENDA
		 where produto=@produto and cor_produto=@cor_produto and tamanho=@tamanho and qtde<>0
         )      
     IF (LTRIM(@tamanho)='3')      
         SET @Retorno = (		 
         select count(mes) as qtde_mes_venda 
		 from Table_Qtde_Mes_VENDA
		 where produto=@produto and cor_produto=@cor_produto and tamanho=@tamanho and qtde<>0
		 )      
     IF (LTRIM(@tamanho)='4')      
         SET @Retorno = (		 
         select count(mes) as qtde_mes_venda 
		 from Table_Qtde_Mes_VENDA
		 where produto=@produto and cor_produto=@cor_produto and tamanho=@tamanho and qtde<>0
		 )      
     IF (LTRIM(@tamanho)='5')      
         SET @Retorno = (		 
         select count(mes) as qtde_mes_venda 
		 from Table_Qtde_Mes_VENDA
		 where produto=@produto and cor_produto=@cor_produto and tamanho=@tamanho and qtde<>0
		 )      
     IF (LTRIM(@tamanho)='6')      
         SET @Retorno = (		 
         select count(mes) as qtde_mes_venda 
		 from Table_Qtde_Mes_VENDA
		 where produto=@produto and cor_produto=@cor_produto and tamanho=@tamanho and qtde<>0
		 )      
     IF (LTRIM(@tamanho)='7')      
		 SET @Retorno = (		 
		 select count(mes) as qtde_mes_venda 
		 from Table_Qtde_Mes_VENDA
		 where produto=@produto and cor_produto=@cor_produto and tamanho=@tamanho and qtde<>0
		 )      
     IF (LTRIM(@tamanho)='8')      
         SET @Retorno = (		 
         select count(mes) as qtde_mes_venda 
		 from Table_Qtde_Mes_VENDA
		 where produto=@produto and cor_produto=@cor_produto and tamanho=@tamanho and qtde<>0
		 )      
     IF (LTRIM(@tamanho)='9')      
         SET @Retorno = (		 
         select count(mes) as qtde_mes_venda 
		 from Table_Qtde_Mes_VENDA
		 where produto=@produto and cor_produto=@cor_produto and tamanho=@tamanho and qtde<>0
		 )      
     IF (LTRIM(@tamanho)='10')      
         SET @Retorno = (		 
         select count(mes) as qtde_mes_venda 
		 from Table_Qtde_Mes_VENDA
		 where produto=@produto and cor_produto=@cor_produto and tamanho=@tamanho and qtde<>0
		 )      
     IF (LTRIM(@tamanho)='11')      
         SET @Retorno = (		 
         select count(mes) as qtde_mes_venda 
		 from Table_Qtde_Mes_VENDA
		 where produto=@produto and cor_produto=@cor_produto and tamanho=@tamanho and qtde<>0
		 )      
     IF (LTRIM(@tamanho)='12')      
         SET @Retorno = (		 
         select count(mes) as qtde_mes_venda 
		 from Table_Qtde_Mes_VENDA
		 where produto=@produto and cor_produto=@cor_produto and tamanho=@tamanho and qtde<>0
		 )      
     IF (LTRIM(@tamanho)='13')      
         SET @Retorno = (		 
         select count(mes) as qtde_mes_venda 
		 from Table_Qtde_Mes_VENDA
		 where produto=@produto and cor_produto=@cor_produto and tamanho=@tamanho and qtde<>0
		 )      
     IF (LTRIM(@tamanho)='14')      
         SET @Retorno = (		 
         select count(mes) as qtde_mes_venda 
		 from Table_Qtde_Mes_VENDA
		 where produto=@produto and cor_produto=@cor_produto and tamanho=@tamanho and qtde<>0
		 )      
     IF (LTRIM(@tamanho)='15')      
         SET @Retorno = (		 
         select count(mes) as qtde_mes_venda 
		 from Table_Qtde_Mes_VENDA
		 where produto=@produto and cor_produto=@cor_produto and tamanho=@tamanho and qtde<>0
		 )      
     IF (LTRIM(@tamanho)='16')      
         SET @Retorno = (		 
         select count(mes) as qtde_mes_venda 
		 from Table_Qtde_Mes_VENDA
		 where produto=@produto and cor_produto=@cor_produto and tamanho=@tamanho and qtde<>0
		 )      
     RETURN(@Retorno)      
END;     




SELECT * FROM Table_Qtde_Tamanho_EP
WHERE PRODUTO='40452.1' AND cor_produto='MA'

sp_helptext Qtde_Tamanho_EP

drop table Table_Qtde_Tamanho_EP
go
select produto,cor_produto, 
sum(a.vo1) as vo1,sum(a.vo2) as vo2,sum(a.vo3) as vo3,sum(a.vo4) as vo4,
sum(a.vo5) as vo5,sum(a.vo6) as vo6,sum(a.vo7) as vo7,sum(a.vo8) as vo8, 
sum(a.vo9) as vo9,sum(a.vo10) as vo10,sum(a.vo11) as vo11,sum(a.vo12) as vo12, 
sum(a.vo13) as vo13,sum(a.vo14) as vo14,sum(a.vo15) as vo15,sum(a.vo16) as vo16 
into Table_Qtde_Tamanho_EP from vendas_produto a with (nolock)     
join vendas b with (nolock) on b.pedido=a.pedido      
where b.aprovacao <> 'R' 
and b.tabela_filha = 'VENDAS_PRODUTO' 
and b.emissao between (GETDATE()-365) and GETDATE()
and b.filial='DR VAREJO' 
and CLIENTE_ATACADO <> 'LOJAS HAVAN'
group by produto,cor_produto
go






CREATE FUNCTION [dbo].[Qtde_Tamanho_EP_TABLE] (@produto varchar(10),@cor_produto varchar(10),@tamanho char(2))      
RETURNS int      
WITH EXECUTE AS CALLER      
AS      
BEGIN      
     DECLARE @Retorno int      
     IF (LTRIM(@tamanho)='1')      
         SET @Retorno =(
           select a.vo1 as qtde_tamanho from Table_Qtde_Tamanho_EP a with (nolock)     
           where a.produto=@produto and a.cor_produto=@cor_produto 
           )          
     IF (LTRIM(@tamanho)='2')      
         SET @Retorno =(
           select a.vo2 as qtde_tamanho from Table_Qtde_Tamanho_EP a with (nolock)     
           where a.produto=@produto and a.cor_produto=@cor_produto 
           )          
     IF (LTRIM(@tamanho)='3')      
         SET @Retorno =(
           select a.vo3 as qtde_tamanho from Table_Qtde_Tamanho_EP a with (nolock)     
           where a.produto=@produto and a.cor_produto=@cor_produto 
           )          
     IF (LTRIM(@tamanho)='4')      
         SET @Retorno =(
           select a.vo4 as qtde_tamanho from Table_Qtde_Tamanho_EP a with (nolock)     
           where a.produto=@produto and a.cor_produto=@cor_produto 
           )          
     IF (LTRIM(@tamanho)='5')      
         SET @Retorno =(
           select a.vo5 as qtde_tamanho from Table_Qtde_Tamanho_EP a with (nolock)     
           where a.produto=@produto and a.cor_produto=@cor_produto
           )          
     IF (LTRIM(@tamanho)='6')      
         SET @Retorno =(
           select a.vo6 as qtde_tamanho from Table_Qtde_Tamanho_EP a with (nolock)     
           where a.produto=@produto and a.cor_produto=@cor_produto
           )          
     IF (LTRIM(@tamanho)='7')      
         SET @Retorno =(
           select a.vo7 as qtde_tamanho from Table_Qtde_Tamanho_EP a with (nolock)     
           where a.produto=@produto and a.cor_produto=@cor_produto
           )          
     IF (LTRIM(@tamanho)='8')      
         SET @Retorno =(
           select a.vo8 as qtde_tamanho from Table_Qtde_Tamanho_EP a with (nolock)     
           where a.produto=@produto and a.cor_produto=@cor_produto
           )          
     IF (LTRIM(@tamanho)='9')      
         SET @Retorno =(
           select a.vo9 as qtde_tamanho from Table_Qtde_Tamanho_EP a with (nolock)     
           where a.produto=@produto and a.cor_produto=@cor_produto
           )          
     IF (LTRIM(@tamanho)='10')      
         SET @Retorno =(
           select a.vo10 as qtde_tamanho from Table_Qtde_Tamanho_EP a with (nolock)     
           where a.produto=@produto and a.cor_produto=@cor_produto
           )          
     IF (LTRIM(@tamanho)='11')      
         SET @Retorno =(
           select a.vo11 as qtde_tamanho from Table_Qtde_Tamanho_EP a with (nolock)     
           where a.produto=@produto and a.cor_produto=@cor_produto
           )          
     IF (LTRIM(@tamanho)='12')      
         SET @Retorno =(
           select a.vo12 as qtde_tamanho from Table_Qtde_Tamanho_EP a with (nolock)     
           where a.produto=@produto and a.cor_produto=@cor_produto
           )          
     IF (LTRIM(@tamanho)='13')      
         SET @Retorno =(
           select a.vo13 as qtde_tamanho from Table_Qtde_Tamanho_EP a with (nolock)     
           where a.produto=@produto and a.cor_produto=@cor_produto
           )          
     IF (LTRIM(@tamanho)='14')      
         SET @Retorno =(
           select a.vo14 as qtde_tamanho from Table_Qtde_Tamanho_EP a with (nolock)     
           where a.produto=@produto and a.cor_produto=@cor_produto
           )          
     IF (LTRIM(@tamanho)='15')      
         SET @Retorno =(
           select a.vo15 as qtde_tamanho from Table_Qtde_Tamanho_EP a with (nolock)     
           where a.produto=@produto and a.cor_produto=@cor_produto
           )          
     IF (LTRIM(@tamanho)='16')      
         SET @Retorno =(
           select a.vo16 as qtde_tamanho from Table_Qtde_Tamanho_EP a with (nolock)     
           where a.produto=@produto and a.cor_produto=@cor_produto
           )          
     RETURN(@Retorno)      
END;


SELECT SETOR_PRODUCAO,RECURSO_PRODUTIVO,linha,produto,cor_produto,tamanho,grade, 
VENDA_ENTREGAR=ISNULL(dbo.Qtde_Tamanho_VE(produto,cor_produto,tamanho,'20150101','20151231'),0), 
COMPRA_ENTREGAR=ISNULL(dbo.Qtde_Tamanho_CE(produto,cor_produto,tamanho,'20150101','20150101'),0), 
ESTOQUE=ISNULL(dbo.Qtde_Tamanho(produto,cor_produto,tamanho),0), 
PROCESSO=ISNULL(dbo.Qtde_Tamanho_OP(produto,cor_produto,tamanho),0), 
PCP=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'00','001'),0), 
ALMOXARIFADO=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'015','002'),0), 
CORTE=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'030','003'),0), 
MOLDADO=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'047','004'),0), 
DISTRIBUICAO=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'045','005'),0), 
RECEBIMENTO_OFICINA=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'060','006'),0), 
COSTURA=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'80%','007'),0), 
REVISAO_OFICINA=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'901','008'),0), 
RETORNO_OFICINA=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'009',''),0), 
RECEBIMENTO_APA=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'095','010'),0), 
JULIETE=ISNULL(dbo.Qtde_Tamanho_FASE_SETOR_OFICINA(produto,cor_produto,tamanho,'005','JULIETE'),0), 
ELITE=ISNULL(dbo.Qtde_Tamanho_FASE_SETOR_OFICINA(produto,cor_produto,tamanho,'013','ELITE'),0), 
ATHENA=ISNULL(dbo.Qtde_Tamanho_FASE_SETOR_OFICINA(produto,cor_produto,tamanho,'019','ATHENA'),0), 
AFRODITE=ISNULL(dbo.Qtde_Tamanho_FASE_SETOR_OFICINA(produto,cor_produto,tamanho,'065','AFRODITE'),0), 
DANJOU=ISNULL(dbo.Qtde_Tamanho_FASE_SETOR_OFICINA(produto,cor_produto,tamanho,'066','DANJOU'),0), 
FACCAO=ISNULL(dbo.Qtde_Tamanho_FACCAO(produto,cor_produto,tamanho,'04 - FACCAO'),0), 
QTDE_VENDA_ANO=ISNULL(dbo.Qtde_Tamanho_EP_TABLE(produto,cor_produto,tamanho),0), 
QTDE_MES_VENDA=ISNULL(dbo.Qtde_Mes_VENDA_TABLE(produto,cor_produto,tamanho),0)  
FROM  
( 
SELECT d.SETOR_PRODUCAO,d.RECURSO_PRODUTIVO,b.linha,a.produto,a.cor_produto,c.tamanho,c.grade 
FROM produto_cores a with (NOLOCK) 
JOIN produtos b with (NOLOCK) ON b.produto = a.produto 
JOIN (select produto,cor_produto,tamanho,grade 
from produtos_barra with (NOLOCK) where codigo_barra_padrao=1 
) c ON  c.produto=a.produto AND c.cor_produto=a.cor_produto  
LEFT JOIN ( 
SELECT * FROM PRODUTO_OPERACOES_ROTAS with (nolock) WHERE FASE_PRODUCAO='007'	
) D ON D.TABELA_OPERACOES=b.PRODUTO 
WHERE a.desc_cor_produto NOT LIKE '%-FL' AND 
b.cod_categoria='01' AND b.cod_subcategoria ='01' AND b.EMPRESA=1 
) EM_LINHA 
