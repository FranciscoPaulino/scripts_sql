SELECT linha,produto,desc_cor_produto,tamanho,grade,
Qtde_VEE=ISNULL(dbo.Qtde_Tamanho_VE(produto,cor_produto,tamanho,'2012-02-01','2012-08-04'),0),
Qtde_EST=ISNULL(dbo.Qtde_Tamanho(produto,cor_produto,tamanho),0),
Qtde_PRO=ISNULL(dbo.Qtde_Tamanho_OP(produto,cor_produto,tamanho),0),
Qtde_PCP=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'00','',''),0),
Qtde_ALM=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'20','',''),0),
Qtde_COR=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'30','',''),0),
Qtde_MOL=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'100','',''),0),
Qtde_DIS=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'50','',''),0),
Qtde_RCO=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'500','',''),0),
Qtde_COS=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'60','61','63'),0),
Qtde_LIM=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'65','655',''),0),
Qtde_REV=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'699','75',''),0),
Qtde_REO=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'700','',''),0),
Qtde_RAP=ISNULL(dbo.Qtde_Tamanho_FASE(produto,cor_produto,tamanho,'70','71',''),0),
Qtde_ATHENA=ISNULL(dbo.Qtde_Tamanho_SETOR_OFICINA(produto,cor_produto,tamanho,'ATHENA'),0),
Qtde_BURITI=ISNULL(dbo.Qtde_Tamanho_SETOR_OFICINA(produto,cor_produto,tamanho,'BURITI'),0),
Qtde_DELTA=ISNULL(dbo.Qtde_Tamanho_SETOR_OFICINA(produto,cor_produto,tamanho,'DELTA'),0),
Qtde_DELTA_FILIAL=ISNULL(dbo.Qtde_Tamanho_SETOR_OFICINA(produto,cor_produto,tamanho,'DUO1T'),0),
Qtde_ELITE=ISNULL(dbo.Qtde_Tamanho_SETOR_OFICINA(produto,cor_produto,tamanho,'ELITE'),0),
Qtde_FIORUCCI=ISNULL(dbo.Qtde_Tamanho_SETOR_OFICINA(produto,cor_produto,tamanho,'FIORUCCI'),0),
Qtde_LANCADORA=ISNULL(dbo.Qtde_Tamanho_SETOR_OFICINA(produto,cor_produto,tamanho,'LANC'),0),
Qtde_NADILE=ISNULL(dbo.Qtde_Tamanho_SETOR_OFICINA(produto,cor_produto,tamanho,'NADILE'),0),
Qtde_WM=ISNULL(dbo.Qtde_Tamanho_SETOR_OFICINA(produto,cor_produto,tamanho,'WM'),0),
Qtde_ZULENE=ISNULL(dbo.Qtde_Tamanho_SETOR_OFICINA(produto,cor_produto,tamanho,'ZULENE'),0),
Qtde_SIGMA=ISNULL(dbo.Qtde_Tamanho_SETOR_OFICINA(produto,cor_produto,tamanho,'61NSIG'),0),
Qtde_SIGMA_M=ISNULL(dbo.Qtde_Tamanho_SETOR_OFICINA(produto,cor_produto,tamanho,'SIG-M'),0),
Qtde_QVA=ISNULL(dbo.Qtde_Tamanho_EP(produto,cor_produto,tamanho,(GETDATE()-365),GETDATE()),0),
Qtde_QMV=ISNULL(dbo.Qtde_mes_VENDA(produto,cor_produto,tamanho,(GETDATE()-365),GETDATE()),0) 
FROM 
(
SELECT b.linha,a.produto,a.cor_produto,a.DESC_COR_PRODUTO,c.tamanho,c.grade FROM produto_cores a
JOIN produtos b ON b.produto = a.produto
JOIN (select produto,cor_produto,tamanho,grade 
from produtos_barra where codigo_barra_padrao=1
) c ON  c.produto=a.produto AND c.cor_produto=a.cor_produto 
WHERE b.EMPRESA=1 and b.PRODUTO='1280' and a.COR_PRODUTO='009'
) EM_LINHA


sp_helptext qtde_tamanho

sp_helptext qtde_tamanho_ve
 
sp_helptext qtde_tamanho_op

sp_helptext qtde_tamanho_fase

sp_helptext Qtde_Tamanho_SETOR_OFICINA

sp_helptext qtde_tamanho_faccao

sp_helptext qtde_tamanho_ep

sp_helptext Qtde_mes_VENDA

CREATE FUNCTION Qtde_Tamanho (@produto varchar(10),@cor_produto varchar(10),@tamanho char(2))  
RETURNS int  
WITH EXECUTE AS CALLER  
AS  
BEGIN  
     DECLARE @Retorno int  
     IF (LTRIM(@tamanho)='1')  
         SET @Retorno = (SELECT ES1 as qtde_tamanho from estoque_produtos   
                         where produto=@produto and cor_produto=@cor_produto and filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='2')  
         SET @Retorno = (SELECT ES2 as qtde_tamanho from estoque_produtos   
                         where produto=@produto and cor_produto=@cor_produto and filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='3')  
         SET @Retorno = (SELECT ES3 as qtde_tamanho from estoque_produtos   
                         where produto=@produto and cor_produto=@cor_produto and filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='4')  
         SET @Retorno = (SELECT ES4 as qtde_tamanho from estoque_produtos   
                         where produto=@produto and cor_produto=@cor_produto and filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='5')  
         SET @Retorno = (SELECT ES5 as qtde_tamanho from estoque_produtos   
                         where produto=@produto and cor_produto=@cor_produto and filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='6')  
         SET @Retorno = (SELECT ES6 as qtde_tamanho from estoque_produtos   
                         where produto=@produto and cor_produto=@cor_produto and filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='7')  
         SET @Retorno = (SELECT ES7 as qtde_tamanho from estoque_produtos   
                         where produto=@produto and cor_produto=@cor_produto and filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='8')  
         SET @Retorno = (SELECT ES8 as qtde_tamanho from estoque_produtos   
                         where produto=@produto and cor_produto=@cor_produto and filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='9')  
         SET @Retorno = (SELECT ES9 as qtde_tamanho from estoque_produtos   
                         where produto=@produto and cor_produto=@cor_produto and filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='10')  
         SET @Retorno = (SELECT ES10 as qtde_tamanho from estoque_produtos   
                         where produto=@produto and cor_produto=@cor_produto and filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='11')  
         SET @Retorno = (SELECT ES11 as qtde_tamanho from estoque_produtos   
                         where produto=@produto and cor_produto=@cor_produto and filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='12')  
         SET @Retorno = (SELECT ES12 as qtde_tamanho from estoque_produtos   
                         where produto=@produto and cor_produto=@cor_produto and filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='13')  
         SET @Retorno = (SELECT ES13 as qtde_tamanho from estoque_produtos   
                         where produto=@produto and cor_produto=@cor_produto and filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='14')  
         SET @Retorno = (SELECT ES14 as qtde_tamanho from estoque_produtos   
                         where produto=@produto and cor_produto=@cor_produto and filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='15')  
         SET @Retorno = (SELECT ES15 as qtde_tamanho from estoque_produtos   
                         where produto=@produto and cor_produto=@cor_produto and filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='16')  
         SET @Retorno = (SELECT ES16 as qtde_tamanho from estoque_produtos   
                         where produto=@produto and cor_produto=@cor_produto and filial='D.R. LINGERIE')  
     RETURN(@Retorno)  
END;  


CREATE FUNCTION Qtde_Tamanho_VE (@produto varchar(10),@cor_produto varchar(10),@tamanho char(2),@dta_ini char(10), @dta_fin char(10))    
RETURNS int    
WITH EXECUTE AS CALLER    
AS    
BEGIN    
     DECLARE @Retorno int    
     IF (LTRIM(@tamanho)='1')    
      SET @Retorno = (select sum(a.ve1) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and     
         b.tabela_filha = 'VENDAS_PRODUTO' and b.aprovacao = 'A' and a.limite_entrega between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')    
     IF (LTRIM(@tamanho)='2')    
      SET @Retorno = (select sum(a.ve2) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and     
         b.tabela_filha = 'VENDAS_PRODUTO' and b.aprovacao = 'A' and a.limite_entrega between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')    
     IF (LTRIM(@tamanho)='3')    
      SET @Retorno = (select sum(a.ve3) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and     
         b.tabela_filha = 'VENDAS_PRODUTO' and b.aprovacao = 'A' and a.limite_entrega between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')    
     IF (LTRIM(@tamanho)='4')    
      SET @Retorno = (select sum(a.ve4) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and     
         b.tabela_filha = 'VENDAS_PRODUTO' and b.aprovacao = 'A' and a.limite_entrega between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')    
     IF (LTRIM(@tamanho)='5')    
      SET @Retorno = (select sum(a.ve5) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and     
         b.tabela_filha = 'VENDAS_PRODUTO' and b.aprovacao = 'A' and a.limite_entrega between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')    
     IF (LTRIM(@tamanho)='6')    
      SET @Retorno = (select sum(a.ve6) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and     
         b.tabela_filha = 'VENDAS_PRODUTO' and b.aprovacao = 'A' and a.limite_entrega between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')    
     IF (LTRIM(@tamanho)='7')    
      SET @Retorno = (select sum(a.ve7) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and     
         b.tabela_filha = 'VENDAS_PRODUTO' and b.aprovacao = 'A' and a.limite_entrega between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')    
     IF (LTRIM(@tamanho)='8')    
      SET @Retorno = (select sum(a.ve8) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and     
         b.tabela_filha = 'VENDAS_PRODUTO' and b.aprovacao = 'A' and a.limite_entrega between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')    
     IF (LTRIM(@tamanho)='9')    
      SET @Retorno = (select sum(a.ve9) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and     
         b.tabela_filha = 'VENDAS_PRODUTO' and b.aprovacao = 'A' and a.limite_entrega between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')    
     IF (LTRIM(@tamanho)='10')    
      SET @Retorno = (select sum(a.ve10) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and     
         b.tabela_filha = 'VENDAS_PRODUTO' and b.aprovacao = 'A' and a.limite_entrega between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')    
     IF (LTRIM(@tamanho)='11')    
      SET @Retorno = (select sum(a.ve11) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and     
         b.tabela_filha = 'VENDAS_PRODUTO' and b.aprovacao = 'A' and a.entrega between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')    
     IF (LTRIM(@tamanho)='12')    
      SET @Retorno = (select sum(a.ve12) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and     
         b.tabela_filha = 'VENDAS_PRODUTO' and b.aprovacao = 'A' and a.limite_entrega between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')    
     IF (LTRIM(@tamanho)='13')    
      SET @Retorno = (select sum(a.ve13) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and     
         b.tabela_filha = 'VENDAS_PRODUTO' and b.aprovacao = 'A' and a.limite_entrega between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')    
     IF (LTRIM(@tamanho)='14')    
      SET @Retorno = (select sum(a.ve14) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and     
         b.tabela_filha = 'VENDAS_PRODUTO' and b.aprovacao = 'A' and a.entrega between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')    
     IF (LTRIM(@tamanho)='15')    
      SET @Retorno = (select sum(a.ve15) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and     
         b.tabela_filha = 'VENDAS_PRODUTO' and b.aprovacao = 'A' and a.limite_entrega between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')    
     IF (LTRIM(@tamanho)='16')    
      SET @Retorno = (select sum(a.ve16) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and     
         b.tabela_filha = 'VENDAS_PRODUTO' and b.aprovacao = 'A' and a.limite_entrega between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')    
     RETURN(@Retorno)    
END; 

CREATE FUNCTION Qtde_Tamanho_OP (@produto varchar(10),@cor_produto varchar(10),@tamanho char(2))  
RETURNS int  
WITH EXECUTE AS CALLER  
AS  
BEGIN  
     DECLARE @Retorno int  
     IF (LTRIM(@tamanho)='1')  
         SET @Retorno = (SELECT SUM(P1) as qtde_tamanho from producao_ordem_cor a  
                         join producao_ordem b on b.ordem_producao=a.ordem_producao    
                         where a.produto=@produto and a.cor_produto=@cor_produto and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='2')  
         SET @Retorno = (SELECT SUM(P2) as qtde_tamanho from producao_ordem_cor a  
                         join producao_ordem b on b.ordem_producao=a.ordem_producao    
                         where a.produto=@produto and a.cor_produto=@cor_produto and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='3')  
         SET @Retorno = (SELECT SUM(P3) as qtde_tamanho from producao_ordem_cor a  
                         join producao_ordem b on b.ordem_producao=a.ordem_producao    
                         where a.produto=@produto and a.cor_produto=@cor_produto and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='4')  
         SET @Retorno = (SELECT SUM(P4) as qtde_tamanho from producao_ordem_cor a  
                         join producao_ordem b on b.ordem_producao=a.ordem_producao    
                         where a.produto=@produto and a.cor_produto=@cor_produto and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='5')  
         SET @Retorno = (SELECT SUM(P5) as qtde_tamanho from producao_ordem_cor a  
                         join producao_ordem b on b.ordem_producao=a.ordem_producao    
                         where a.produto=@produto and a.cor_produto=@cor_produto and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='6')  
         SET @Retorno = (SELECT SUM(P6) as qtde_tamanho from producao_ordem_cor a  
                         join producao_ordem b on b.ordem_producao=a.ordem_producao    
                         where a.produto=@produto and a.cor_produto=@cor_produto and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='7')  
         SET @Retorno = (SELECT SUM(P7) as qtde_tamanho from producao_ordem_cor a  
                         join producao_ordem b on b.ordem_producao=a.ordem_producao    
                         where a.produto=@produto and a.cor_produto=@cor_produto and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='8')  
         SET @Retorno = (SELECT SUM(P8) as qtde_tamanho from producao_ordem_cor a  
                         join producao_ordem b on b.ordem_producao=a.ordem_producao    
                         where a.produto=@produto and a.cor_produto=@cor_produto and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='9')  
         SET @Retorno = (SELECT SUM(P9) as qtde_tamanho from producao_ordem_cor a  
                         join producao_ordem b on b.ordem_producao=a.ordem_producao    
                         where a.produto=@produto and a.cor_produto=@cor_produto and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='10')  
         SET @Retorno = (SELECT SUM(P10) as qtde_tamanho from producao_ordem_cor a  
                         join producao_ordem b on b.ordem_producao=a.ordem_producao    
                         where a.produto=@produto and a.cor_produto=@cor_produto and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='11')  
         SET @Retorno = (SELECT SUM(P11) as qtde_tamanho from producao_ordem_cor a  
                         join producao_ordem b on b.ordem_producao=a.ordem_producao    
                         where a.produto=@produto and a.cor_produto=@cor_produto and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='12')  
         SET @Retorno = (SELECT SUM(P12) as qtde_tamanho from producao_ordem_cor a  
                         join producao_ordem b on b.ordem_producao=a.ordem_producao    
                         where a.produto=@produto and a.cor_produto=@cor_produto and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='13')  
         SET @Retorno = (SELECT SUM(P13) as qtde_tamanho from producao_ordem_cor a  
                         join producao_ordem b on b.ordem_producao=a.ordem_producao    
                         where a.produto=@produto and a.cor_produto=@cor_produto and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='14')  
         SET @Retorno = (SELECT SUM(P14) as qtde_tamanho from producao_ordem_cor a  
                         join producao_ordem b on b.ordem_producao=a.ordem_producao    
                         where a.produto=@produto and a.cor_produto=@cor_produto and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='15')  
         SET @Retorno = (SELECT SUM(P15) as qtde_tamanho from producao_ordem_cor a  
                         join producao_ordem b on b.ordem_producao=a.ordem_producao    
                         where a.produto=@produto and a.cor_produto=@cor_produto and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='16')  
         SET @Retorno = (SELECT SUM(P16) as qtde_tamanho from producao_ordem_cor a  
                         join producao_ordem b on b.ordem_producao=a.ordem_producao    
                         where a.produto=@produto and a.cor_produto=@cor_produto and b.filial='D.R. LINGERIE')  
     RETURN(@Retorno)  
END;  


CREATE FUNCTION Qtde_Tamanho_FASE (@produto varchar(10),@cor_produto varchar(10),@tamanho char(2),@fase_producao1 varchar(30),@fase_producao2 varchar(30),@fase_producao3 varchar(30))  
RETURNS int  
WITH EXECUTE AS CALLER  
AS  
BEGIN  
     DECLARE @Retorno int  
     IF (LTRIM(@tamanho)='1')  
         SET @Retorno = (select sum(a.s1) as qtde_tamanho    
                                    from producao_tarefas_saldo a     
                                    join producao_tarefas b on b.ordem_producao = a.ordem_producao and b.tarefa = a.tarefa   
                                    where a.produto=@produto and a.cor_produto=@cor_produto and (b.fase_producao like @fase_producao1 or b.fase_producao=@fase_producao2 or b.fase_producao=@fase_producao3) and b.qtde_em_processo>0)   
     IF (LTRIM(@tamanho)='2')  
         SET @Retorno = (select sum(a.s2) as qtde_tamanho    
                                    from producao_tarefas_saldo a     
                                    join producao_tarefas b on b.ordem_producao = a.ordem_producao and b.tarefa = a.tarefa   
                                    where a.produto=@produto and a.cor_produto=@cor_produto and (b.fase_producao like @fase_producao1 or b.fase_producao=@fase_producao2 or b.fase_producao=@fase_producao3) and b.qtde_em_processo>0)   
     IF (LTRIM(@tamanho)='3')  
         SET @Retorno = (select sum(a.s3) as qtde_tamanho    
                                    from producao_tarefas_saldo a     
                                    join producao_tarefas b on b.ordem_producao = a.ordem_producao and b.tarefa = a.tarefa   
                                    where a.produto=@produto and a.cor_produto=@cor_produto and (b.fase_producao like @fase_producao1 or b.fase_producao=@fase_producao2 or b.fase_producao=@fase_producao3) and b.qtde_em_processo>0)   
     IF (LTRIM(@tamanho)='4')  
         SET @Retorno = (select sum(a.s4) as qtde_tamanho    
                                    from producao_tarefas_saldo a     
                                    join producao_tarefas b on b.ordem_producao = a.ordem_producao and b.tarefa = a.tarefa   
                                    where a.produto=@produto and a.cor_produto=@cor_produto and (b.fase_producao like @fase_producao1 or b.fase_producao=@fase_producao2 or b.fase_producao=@fase_producao3) and b.qtde_em_processo>0)   
     IF (LTRIM(@tamanho)='5')  
         SET @Retorno = (select sum(a.s5) as qtde_tamanho    
                                    from producao_tarefas_saldo a     
                                    join producao_tarefas b on b.ordem_producao = a.ordem_producao and b.tarefa = a.tarefa   
                                    where a.produto=@produto and a.cor_produto=@cor_produto and (b.fase_producao like @fase_producao1 or b.fase_producao=@fase_producao2 or b.fase_producao=@fase_producao3) and b.qtde_em_processo>0)   
     IF (LTRIM(@tamanho)='6')  
         SET @Retorno = (select sum(a.s6) as qtde_tamanho    
                                    from producao_tarefas_saldo a     
                                    join producao_tarefas b on b.ordem_producao = a.ordem_producao and b.tarefa = a.tarefa   
                                    where a.produto=@produto and a.cor_produto=@cor_produto and (b.fase_producao like @fase_producao1 or b.fase_producao=@fase_producao2 or b.fase_producao=@fase_producao3) and b.qtde_em_processo>0)   
     IF (LTRIM(@tamanho)='7')  
         SET @Retorno = (select sum(a.s7) as qtde_tamanho    
                                    from producao_tarefas_saldo a     
                                    join producao_tarefas b on b.ordem_producao = a.ordem_producao and b.tarefa = a.tarefa   
                                    where a.produto=@produto and a.cor_produto=@cor_produto and (b.fase_producao like @fase_producao1 or b.fase_producao=@fase_producao2 or b.fase_producao=@fase_producao3) and b.qtde_em_processo>0)   
     IF (LTRIM(@tamanho)='8')  
         SET @Retorno = (select sum(a.s8) as qtde_tamanho    
                           from producao_tarefas_saldo a     
                                    join producao_tarefas b on b.ordem_producao = a.ordem_producao and b.tarefa = a.tarefa   
                                    where a.produto=@produto and a.cor_produto=@cor_produto and (b.fase_producao like @fase_producao1 or b.fase_producao=@fase_producao2 or b.fase_producao=@fase_producao3) and b.qtde_em_processo>0)   
     IF (LTRIM(@tamanho)='9')  
         SET @Retorno = (select sum(a.s9) as qtde_tamanho    
                                    from producao_tarefas_saldo a     
                                    join producao_tarefas b on b.ordem_producao = a.ordem_producao and b.tarefa = a.tarefa   
                                    where a.produto=@produto and a.cor_produto=@cor_produto and (b.fase_producao like @fase_producao1 or b.fase_producao=@fase_producao2 or b.fase_producao=@fase_producao3) and b.qtde_em_processo>0)   
     IF (LTRIM(@tamanho)='10')  
         SET @Retorno = (select sum(a.s10) as qtde_tamanho    
                                    from producao_tarefas_saldo a     
                                    join producao_tarefas b on b.ordem_producao = a.ordem_producao and b.tarefa = a.tarefa   
                                    where a.produto=@produto and a.cor_produto=@cor_produto and (b.fase_producao like @fase_producao1 or b.fase_producao=@fase_producao2 or b.fase_producao=@fase_producao3) and b.qtde_em_processo>0)   
     IF (LTRIM(@tamanho)='11')  
         SET @Retorno = (select sum(a.s11) as qtde_tamanho    
                                    from producao_tarefas_saldo a     
                                    join producao_tarefas b on b.ordem_producao = a.ordem_producao and b.tarefa = a.tarefa   
                                    where a.produto=@produto and a.cor_produto=@cor_produto and (b.fase_producao like @fase_producao1 or b.fase_producao=@fase_producao2 or b.fase_producao=@fase_producao3) and b.qtde_em_processo>0)   
     IF (LTRIM(@tamanho)='12')  
         SET @Retorno = (select sum(a.s12) as qtde_tamanho    
                                    from producao_tarefas_saldo a     
                                    join producao_tarefas b on b.ordem_producao = a.ordem_producao and b.tarefa = a.tarefa   
                                    where a.produto=@produto and a.cor_produto=@cor_produto and (b.fase_producao like @fase_producao1 or b.fase_producao=@fase_producao2 or b.fase_producao=@fase_producao3) and b.qtde_em_processo>0)   
     IF (LTRIM(@tamanho)='13')  
         SET @Retorno = (select sum(a.s13) as qtde_tamanho    
                                    from producao_tarefas_saldo a     
                                    join producao_tarefas b on b.ordem_producao = a.ordem_producao and b.tarefa = a.tarefa   
                                    where a.produto=@produto and a.cor_produto=@cor_produto and (b.fase_producao like @fase_producao1 or b.fase_producao=@fase_producao2 or b.fase_producao=@fase_producao3) and b.qtde_em_processo>0)   
     IF (LTRIM(@tamanho)='14')  
         SET @Retorno = (select sum(a.s14) as qtde_tamanho    
                                    from producao_tarefas_saldo a     
                                    join producao_tarefas b on b.ordem_producao = a.ordem_producao and b.tarefa = a.tarefa   
                                    where a.produto=@produto and a.cor_produto=@cor_produto and (b.fase_producao like @fase_producao1 or b.fase_producao=@fase_producao2 or b.fase_producao=@fase_producao3) and b.qtde_em_processo>0)   
     IF (LTRIM(@tamanho)='15')  
         SET @Retorno = (select sum(a.s15) as qtde_tamanho    
                                    from producao_tarefas_saldo a     
                                    join producao_tarefas b on b.ordem_producao = a.ordem_producao and b.tarefa = a.tarefa   
                                    where a.produto=@produto and a.cor_produto=@cor_produto and (b.fase_producao like @fase_producao1 or b.fase_producao=@fase_producao2 or b.fase_producao=@fase_producao3) and b.qtde_em_processo>0)   
     IF (LTRIM(@tamanho)='16')  
         SET @Retorno = (select sum(a.s16) as qtde_tamanho    
                                    from producao_tarefas_saldo a     
                                    join producao_tarefas b on b.ordem_producao = a.ordem_producao and b.tarefa = a.tarefa   
                                    where a.produto=@produto and a.cor_produto=@cor_produto and (b.fase_producao like @fase_producao1 or b.fase_producao=@fase_producao2 or b.fase_producao=@fase_producao3) and b.qtde_em_processo>0)   
     RETURN(@Retorno)  
END;  


CREATE FUNCTION Qtde_Tamanho_SETOR_OFICINA (@produto varchar(10),@cor_produto varchar(10),@tamanho char(2),@setor_producao varchar(25))  
RETURNS int  
WITH EXECUTE AS CALLER  
AS  
BEGIN  
     DECLARE @Retorno int  
     IF (LTRIM(@tamanho)='1')  
   SET @Retorno = (select sum(a.s1) as qtde_tamanho   
         from producao_tarefas_saldo a     
         join producao_tarefas b on b.ordem_producao = a.ordem_producao and a.tarefa=b.tarefa            
         where a.produto=@produto and a.cor_produto=@cor_produto   
         and b.setor_producao=@setor_producao and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='2')  
   SET @Retorno = (select sum(a.s2) as qtde_tamanho   
         from producao_tarefas_saldo a     
         join producao_tarefas b on b.ordem_producao = a.ordem_producao and a.tarefa=b.tarefa            
         where a.produto=@produto and a.cor_produto=@cor_produto   
         and b.setor_producao=@setor_producao and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='3')  
   SET @Retorno = (select sum(a.s3) as qtde_tamanho   
         from producao_tarefas_saldo a     
         join producao_tarefas b on b.ordem_producao = a.ordem_producao and a.tarefa=b.tarefa            
         where a.produto=@produto and a.cor_produto=@cor_produto   
         and b.setor_producao=@setor_producao and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='4')  
   SET @Retorno = (select sum(a.s4) as qtde_tamanho   
         from producao_tarefas_saldo a     
         join producao_tarefas b on b.ordem_producao = a.ordem_producao and a.tarefa=b.tarefa            
         where a.produto=@produto and a.cor_produto=@cor_produto   
         and b.setor_producao=@setor_producao and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='5')  
   SET @Retorno = (select sum(a.s5) as qtde_tamanho   
         from producao_tarefas_saldo a     
         join producao_tarefas b on b.ordem_producao = a.ordem_producao and a.tarefa=b.tarefa            
         where a.produto=@produto and a.cor_produto=@cor_produto   
         and b.setor_producao=@setor_producao and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='6')  
   SET @Retorno = (select sum(a.s6) as qtde_tamanho   
         from producao_tarefas_saldo a     
         join producao_tarefas b on b.ordem_producao = a.ordem_producao and a.tarefa=b.tarefa            
         where a.produto=@produto and a.cor_produto=@cor_produto   
         and b.setor_producao=@setor_producao and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='7')  
   SET @Retorno = (select sum(a.s7) as qtde_tamanho   
         from producao_tarefas_saldo a     
         join producao_tarefas b on b.ordem_producao = a.ordem_producao and a.tarefa=b.tarefa            
         where a.produto=@produto and a.cor_produto=@cor_produto   
         and b.setor_producao=@setor_producao and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='8')  
   SET @Retorno = (select sum(a.s8) as qtde_tamanho   
         from producao_tarefas_saldo a     
         join producao_tarefas b on b.ordem_producao = a.ordem_producao and a.tarefa=b.tarefa            
         where a.produto=@produto and a.cor_produto=@cor_produto   
         and b.setor_producao=@setor_producao and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='9')  
   SET @Retorno = (select sum(a.s9) as qtde_tamanho   
         from producao_tarefas_saldo a     
         join producao_tarefas b on b.ordem_producao = a.ordem_producao and a.tarefa=b.tarefa            
         where a.produto=@produto and a.cor_produto=@cor_produto   
         and b.setor_producao=@setor_producao and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='10')  
   SET @Retorno = (select sum(a.s10) as qtde_tamanho   
         from producao_tarefas_saldo a     
         join producao_tarefas b on b.ordem_producao = a.ordem_producao and a.tarefa=b.tarefa            
         where a.produto=@produto and a.cor_produto=@cor_produto   
         and b.setor_producao=@setor_producao and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='11')  
   SET @Retorno = (select sum(a.s11) as qtde_tamanho   
         from producao_tarefas_saldo a     
         join producao_tarefas b on b.ordem_producao = a.ordem_producao and a.tarefa=b.tarefa            
         where a.produto=@produto and a.cor_produto=@cor_produto   
         and b.setor_producao=@setor_producao and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='12')  
   SET @Retorno = (select sum(a.s12) as qtde_tamanho   
         from producao_tarefas_saldo a     
         join producao_tarefas b on b.ordem_producao = a.ordem_producao and a.tarefa=b.tarefa            
         where a.produto=@produto and a.cor_produto=@cor_produto   
         and b.setor_producao=@setor_producao and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='13')  
   SET @Retorno = (select sum(a.s13) as qtde_tamanho   
         from producao_tarefas_saldo a     
         join producao_tarefas b on b.ordem_producao = a.ordem_producao and a.tarefa=b.tarefa            
         where a.produto=@produto and a.cor_produto=@cor_produto   
         and b.setor_producao=@setor_producao and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='14')  
   SET @Retorno = (select sum(a.s14) as qtde_tamanho   
         from producao_tarefas_saldo a     
         join producao_tarefas b on b.ordem_producao = a.ordem_producao and a.tarefa=b.tarefa            
         where a.produto=@produto and a.cor_produto=@cor_produto   
         and b.setor_producao=@setor_producao and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='15')  
   SET @Retorno = (select sum(a.s15) as qtde_tamanho   
         from producao_tarefas_saldo a     
         join producao_tarefas b on b.ordem_producao = a.ordem_producao and a.tarefa=b.tarefa            
         where a.produto=@produto and a.cor_produto=@cor_produto   
         and b.setor_producao=@setor_producao and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='16')  
   SET @Retorno = (select sum(a.s16) as qtde_tamanho   
         from producao_tarefas_saldo a     
         join producao_tarefas b on b.ordem_producao = a.ordem_producao and a.tarefa=b.tarefa            
         where a.produto=@produto and a.cor_produto=@cor_produto   
         and b.setor_producao=@setor_producao and b.qtde_em_processo>0)  
     RETURN(@Retorno)  
END;  


CREATE FUNCTION Qtde_Tamanho_FACCAO (@produto varchar(10),@cor_produto varchar(10),@tamanho char(2),@tipo_recurso varchar(30))  
RETURNS int  
WITH EXECUTE AS CALLER  
AS  
BEGIN  
     DECLARE @Retorno int  
     IF (LTRIM(@tamanho)='1')  
   SET @Retorno = (select sum(a.p1) as qtde_tamanho from producao_ordem_cor a   
                     join producao_tarefas b on b.ordem_producao = a.ordem_producao  
                                    join producao_recursos c on c.recurso_produtivo=b.recurso_produtivo  
                                    where a.produto=@produto and a.cor_produto=@cor_produto    
                                    and c.tipo_recurso=@tipo_recurso and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='2')  
   SET @Retorno = (select sum(a.p2) as qtde_tamanho from producao_ordem_cor a   
                     join producao_tarefas b on b.ordem_producao = a.ordem_producao  
                                    join producao_recursos c on c.recurso_produtivo=b.recurso_produtivo  
                                    where a.produto=@produto and a.cor_produto=@cor_produto    
                                    and c.tipo_recurso=@tipo_recurso and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='3')  
   SET @Retorno = (select sum(a.p3) as qtde_tamanho from producao_ordem_cor a   
                     join producao_tarefas b on b.ordem_producao = a.ordem_producao  
                                    join producao_recursos c on c.recurso_produtivo=b.recurso_produtivo  
                                    where a.produto=@produto and a.cor_produto=@cor_produto    
                                    and c.tipo_recurso=@tipo_recurso and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='4')  
   SET @Retorno = (select sum(a.p4) as qtde_tamanho from producao_ordem_cor a   
                     join producao_tarefas b on b.ordem_producao = a.ordem_producao  
                                    join producao_recursos c on c.recurso_produtivo=b.recurso_produtivo  
                                    where a.produto=@produto and a.cor_produto=@cor_produto    
                                    and c.tipo_recurso=@tipo_recurso and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='5')  
   SET @Retorno = (select sum(a.p5) as qtde_tamanho from producao_ordem_cor a   
                     join producao_tarefas b on b.ordem_producao = a.ordem_producao  
                                    join producao_recursos c on c.recurso_produtivo=b.recurso_produtivo  
                                    where a.produto=@produto and a.cor_produto=@cor_produto    
                                    and c.tipo_recurso=@tipo_recurso and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='6')  
   SET @Retorno = (select sum(a.p6) as qtde_tamanho from producao_ordem_cor a   
                     join producao_tarefas b on b.ordem_producao = a.ordem_producao  
                                    join producao_recursos c on c.recurso_produtivo=b.recurso_produtivo  
                                    where a.produto=@produto and a.cor_produto=@cor_produto    
                                    and c.tipo_recurso=@tipo_recurso and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='7')  
   SET @Retorno = (select sum(a.p7) as qtde_tamanho from producao_ordem_cor a   
                     join producao_tarefas b on b.ordem_producao = a.ordem_producao  
                                    join producao_recursos c on c.recurso_produtivo=b.recurso_produtivo  
                                    where a.produto=@produto and a.cor_produto=@cor_produto    
                                    and c.tipo_recurso=@tipo_recurso and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='8')  
   SET @Retorno = (select sum(a.p8) as qtde_tamanho from producao_ordem_cor a   
                     join producao_tarefas b on b.ordem_producao = a.ordem_producao  
                                    join producao_recursos c on c.recurso_produtivo=b.recurso_produtivo  
                                    where a.produto=@produto and a.cor_produto=@cor_produto    
                                    and c.tipo_recurso=@tipo_recurso and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='9')  
   SET @Retorno = (select sum(a.p9) as qtde_tamanho from producao_ordem_cor a   
                     join producao_tarefas b on b.ordem_producao = a.ordem_producao  
                                    join producao_recursos c on c.recurso_produtivo=b.recurso_produtivo  
                                    where a.produto=@produto and a.cor_produto=@cor_produto    
                                    and c.tipo_recurso=@tipo_recurso and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='10')  
   SET @Retorno = (select sum(a.p10) as qtde_tamanho from producao_ordem_cor a   
                     join producao_tarefas b on b.ordem_producao = a.ordem_producao  
                                    join producao_recursos c on c.recurso_produtivo=b.recurso_produtivo  
                                    where a.produto=@produto and a.cor_produto=@cor_produto    
                                    and c.tipo_recurso=@tipo_recurso and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='11')  
   SET @Retorno = (select sum(a.p11) as qtde_tamanho from producao_ordem_cor a   
                     join producao_tarefas b on b.ordem_producao = a.ordem_producao  
                                    join producao_recursos c on c.recurso_produtivo=b.recurso_produtivo  
                                    where a.produto=@produto and a.cor_produto=@cor_produto    
                                    and c.tipo_recurso=@tipo_recurso and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='12')  
   SET @Retorno = (select sum(a.p12) as qtde_tamanho from producao_ordem_cor a   
                     join producao_tarefas b on b.ordem_producao = a.ordem_producao  
                                    join producao_recursos c on c.recurso_produtivo=b.recurso_produtivo  
                                    where a.produto=@produto and a.cor_produto=@cor_produto    
                                    and c.tipo_recurso=@tipo_recurso and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='13')  
   SET @Retorno = (select sum(a.p13) as qtde_tamanho from producao_ordem_cor a   
                     join producao_tarefas b on b.ordem_producao = a.ordem_producao  
                                    join producao_recursos c on c.recurso_produtivo=b.recurso_produtivo  
                                    where a.produto=@produto and a.cor_produto=@cor_produto    
                                    and c.tipo_recurso=@tipo_recurso and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='14')  
   SET @Retorno = (select sum(a.p14) as qtde_tamanho from producao_ordem_cor a   
                     join producao_tarefas b on b.ordem_producao = a.ordem_producao  
                                    join producao_recursos c on c.recurso_produtivo=b.recurso_produtivo  
                                    where a.produto=@produto and a.cor_produto=@cor_produto    
                                    and c.tipo_recurso=@tipo_recurso and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='15')  
   SET @Retorno = (select sum(a.p15) as qtde_tamanho from producao_ordem_cor a   
                     join producao_tarefas b on b.ordem_producao = a.ordem_producao  
                                    join producao_recursos c on c.recurso_produtivo=b.recurso_produtivo  
                                    where a.produto=@produto and a.cor_produto=@cor_produto    
                                    and c.tipo_recurso=@tipo_recurso and b.qtde_em_processo>0)  
     IF (LTRIM(@tamanho)='16')  
   SET @Retorno = (select sum(a.p16) as qtde_tamanho from producao_ordem_cor a   
                     join producao_tarefas b on b.ordem_producao = a.ordem_producao  
                                    join producao_recursos c on c.recurso_produtivo=b.recurso_produtivo  
                                    where a.produto=@produto and a.cor_produto=@cor_produto    
                      and c.tipo_recurso=@tipo_recurso and b.qtde_em_processo>0)  
     RETURN(@Retorno)  
END;  


CREATE FUNCTION Qtde_Tamanho_EP (@produto varchar(10),@cor_produto varchar(10),@tamanho char(2),@dta_ini datetime, @dta_fin datetime)  
RETURNS int  
WITH EXECUTE AS CALLER  
AS  
BEGIN  
     DECLARE @Retorno int  
     IF (LTRIM(@tamanho)='1')  
         SET @Retorno =(select sum(a.vo1) as qtde_tamanho from vendas_produto a  
           join vendas b on b.pedido=a.pedido  
           where a.produto=@produto and a.cor_produto=@cor_produto and b.emissao between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='2')  
         SET @Retorno =(select sum(a.vo2) as qtde_tamanho from vendas_produto a  
           join vendas b on b.pedido=a.pedido  
           where a.produto=@produto and a.cor_produto=@cor_produto and b.emissao between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='3')  
         SET @Retorno =(select sum(a.vo3) as qtde_tamanho from vendas_produto a  
           join vendas b on b.pedido=a.pedido  
           where a.produto=@produto and a.cor_produto=@cor_produto and b.emissao between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='4')  
         SET @Retorno =(select sum(a.vo4) as qtde_tamanho from vendas_produto a  
           join vendas b on b.pedido=a.pedido  
           where a.produto=@produto and a.cor_produto=@cor_produto and b.emissao between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='5')  
         SET @Retorno =(select sum(a.vo5) as qtde_tamanho from vendas_produto a  
           join vendas b on b.pedido=a.pedido  
           where a.produto=@produto and a.cor_produto=@cor_produto and b.emissao between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='6')  
         SET @Retorno =(select sum(a.vo6) as qtde_tamanho from vendas_produto a  
           join vendas b on b.pedido=a.pedido  
           where a.produto=@produto and a.cor_produto=@cor_produto and b.emissao between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='7')  
         SET @Retorno =(select sum(a.vo7) as qtde_tamanho from vendas_produto a  
           join vendas b on b.pedido=a.pedido  
           where a.produto=@produto and a.cor_produto=@cor_produto and b.emissao between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='8')  
         SET @Retorno =(select sum(a.vo8) as qtde_tamanho from vendas_produto a  
           join vendas b on b.pedido=a.pedido  
           where a.produto=@produto and a.cor_produto=@cor_produto and b.emissao between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='9')  
         SET @Retorno =(select sum(a.vo9) as qtde_tamanho from vendas_produto a  
           join vendas b on b.pedido=a.pedido  
           where a.produto=@produto and a.cor_produto=@cor_produto and b.emissao between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='10')  
         SET @Retorno =(select sum(a.vo10) as qtde_tamanho from vendas_produto a  
           join vendas b on b.pedido=a.pedido  
           where a.produto=@produto and a.cor_produto=@cor_produto and b.emissao between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='11')  
         SET @Retorno =(select sum(a.vo11) as qtde_tamanho from vendas_produto a  
           join vendas b on b.pedido=a.pedido  
           where a.produto=@produto and a.cor_produto=@cor_produto and b.emissao between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='12')  
         SET @Retorno =(select sum(a.vo12) as qtde_tamanho from vendas_produto a  
           join vendas b on b.pedido=a.pedido  
           where a.produto=@produto and a.cor_produto=@cor_produto and b.emissao between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='13')  
         SET @Retorno =(select sum(a.vo13) as qtde_tamanho from vendas_produto a  
           join vendas b on b.pedido=a.pedido  
         where a.produto=@produto and a.cor_produto=@cor_produto and b.emissao between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='14')  
         SET @Retorno =(select sum(a.vo14) as qtde_tamanho from vendas_produto a  
           join vendas b on b.pedido=a.pedido  
           where a.produto=@produto and a.cor_produto=@cor_produto and b.emissao between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='15')  
         SET @Retorno =(select sum(a.vo15) as qtde_tamanho from vendas_produto a  
           join vendas b on b.pedido=a.pedido  
           where a.produto=@produto and a.cor_produto=@cor_produto and b.emissao between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')  
     IF (LTRIM(@tamanho)='16')  
         SET @Retorno =(select sum(a.vo16) as qtde_tamanho from vendas_produto a  
           join vendas b on b.pedido=a.pedido  
           where a.produto=@produto and a.cor_produto=@cor_produto and b.emissao between @dta_ini and @dta_fin and b.filial='D.R. LINGERIE')  
     RETURN(@Retorno)  
END;  

CREATE FUNCTION Qtde_Mes_VENDA (@produto varchar(10),@cor_produto varchar(10),@tamanho char(2),@dta_ini datetime, @dta_fin datetime)  
RETURNS int  
WITH EXECUTE AS CALLER  
AS  
BEGIN  
     DECLARE @Retorno int  
     IF (LTRIM(@tamanho)='1')  
         SET @Retorno = (select count(vendas_mes.mes) as qtde_mes_venda from (  
         select a.produto,a.cor_produto,month(b.emissao) as mes,sum(a.vo1) as vo1  
         from vendas_produto a  join vendas b on b.pedido = a.pedido  
         where b.emissao between @dta_ini and @dta_fin and a.vo1 <> 0  and   
         b.filial ='D.R. LINGERIE'  and a.produto=@produto and a.cor_produto=@cor_produto    
         group by a.produto,a.cor_produto,month(b.emissao)  
         ) as vendas_mes  
         group by vendas_mes.produto,vendas_mes.cor_produto)  
     IF (LTRIM(@tamanho)='2')  
         SET @Retorno = (select count(vendas_mes.mes) as qtde_mes_venda from (  
         select a.produto,a.cor_produto,month(b.emissao) as mes,sum(a.vo2) as vo2  
         from vendas_produto a  join vendas b on b.pedido = a.pedido  
         where b.emissao between @dta_ini and @dta_fin and a.vo2 <> 0  and   
         b.filial ='D.R. LINGERIE'  and a.produto=@produto and a.cor_produto=@cor_produto    
         group by a.produto,a.cor_produto,month(b.emissao)  
         ) as vendas_mes  
         group by vendas_mes.produto,vendas_mes.cor_produto)  
     IF (LTRIM(@tamanho)='3')  
         SET @Retorno = (select count(vendas_mes.mes) as qtde_mes_venda from (  
         select a.produto,a.cor_produto,month(b.emissao) as mes,sum(a.vo3) as vo3  
         from vendas_produto a  join vendas b on b.pedido = a.pedido  
         where b.emissao between @dta_ini and @dta_fin and a.vo3 <> 0  and   
         b.filial ='D.R. LINGERIE'  and a.produto=@produto and a.cor_produto=@cor_produto    
         group by a.produto,a.cor_produto,month(b.emissao)  
         ) as vendas_mes  
         group by vendas_mes.produto,vendas_mes.cor_produto)  
     IF (LTRIM(@tamanho)='4')  
         SET @Retorno = (select count(vendas_mes.mes) as qtde_mes_venda from (  
         select a.produto,a.cor_produto,month(b.emissao) as mes,sum(a.vo4) as vo4  
         from vendas_produto a  join vendas b on b.pedido = a.pedido  
         where b.emissao between @dta_ini and @dta_fin and a.vo4 <> 0  and   
         b.filial ='D.R. LINGERIE'  and a.produto=@produto and a.cor_produto=@cor_produto    
         group by a.produto,a.cor_produto,month(b.emissao)  
         ) as vendas_mes  
         group by vendas_mes.produto,vendas_mes.cor_produto)  
     IF (LTRIM(@tamanho)='5')  
         SET @Retorno = (select count(vendas_mes.mes) as qtde_mes_venda from (  
         select a.produto,a.cor_produto,month(b.emissao) as mes,sum(a.vo5) as vo5  
         from vendas_produto a  join vendas b on b.pedido = a.pedido  
         where b.emissao between @dta_ini and @dta_fin and a.vo5 <> 0  and   
         b.filial ='D.R. LINGERIE'  and a.produto=@produto and a.cor_produto=@cor_produto    
         group by a.produto,a.cor_produto,month(b.emissao)  
         ) as vendas_mes  
         group by vendas_mes.produto,vendas_mes.cor_produto)  
     IF (LTRIM(@tamanho)='6')  
         SET @Retorno = (select count(vendas_mes.mes) as qtde_mes_venda from (  
         select a.produto,a.cor_produto,month(b.emissao) as mes,sum(a.vo6) as vo6  
         from vendas_produto a  join vendas b on b.pedido = a.pedido  
         where b.emissao between @dta_ini and @dta_fin and a.vo6 <> 0  and   
         b.filial ='D.R. LINGERIE'  and a.produto=@produto and a.cor_produto=@cor_produto    
         group by a.produto,a.cor_produto,month(b.emissao)  
         ) as vendas_mes  
         group by vendas_mes.produto,vendas_mes.cor_produto)  
     IF (LTRIM(@tamanho)='7')  
         SET @Retorno = (select count(vendas_mes.mes) as qtde_mes_venda from (  
         select a.produto,a.cor_produto,month(b.emissao) as mes,sum(a.vo7) as vo7  
         from vendas_produto a  join vendas b on b.pedido = a.pedido  
         where b.emissao between @dta_ini and @dta_fin and a.vo7 <> 0  and   
         b.filial ='D.R. LINGERIE'  and a.produto=@produto and a.cor_produto=@cor_produto    
         group by a.produto,a.cor_produto,month(b.emissao)  
         ) as vendas_mes  
         group by vendas_mes.produto,vendas_mes.cor_produto)  
     IF (LTRIM(@tamanho)='8')  
         SET @Retorno = (select count(vendas_mes.mes) as qtde_mes_venda from (  
         select a.produto,a.cor_produto,month(b.emissao) as mes,sum(a.vo8) as vo8  
         from vendas_produto a  join vendas b on b.pedido = a.pedido  
         where b.emissao between @dta_ini and @dta_fin and a.vo8 <> 0  and   
         b.filial ='D.R. LINGERIE'  and a.produto=@produto and a.cor_produto=@cor_produto    
         group by a.produto,a.cor_produto,month(b.emissao)  
         ) as vendas_mes  
         group by vendas_mes.produto,vendas_mes.cor_produto)  
     IF (LTRIM(@tamanho)='9')  
         SET @Retorno = (select count(vendas_mes.mes) as qtde_mes_venda from (  
         select a.produto,a.cor_produto,month(b.emissao) as mes,sum(a.vo9) as vo9  
         from vendas_produto a  join vendas b on b.pedido = a.pedido  
         where b.emissao between @dta_ini and @dta_fin and a.vo9 <> 0  and   
         b.filial ='D.R. LINGERIE'  and a.produto=@produto and a.cor_produto=@cor_produto    
         group by a.produto,a.cor_produto,month(b.emissao)  
         ) as vendas_mes  
         group by vendas_mes.produto,vendas_mes.cor_produto)  
     IF (LTRIM(@tamanho)='10')  
         SET @Retorno = (select count(vendas_mes.mes) as qtde_mes_venda from (  
         select a.produto,a.cor_produto,month(b.emissao) as mes,sum(a.vo10) as vo10  
         from vendas_produto a  join vendas b on b.pedido = a.pedido  
         where b.emissao between @dta_ini and @dta_fin and a.vo10 <> 0  and   
         b.filial ='D.R. LINGERIE'  and a.produto=@produto and a.cor_produto=@cor_produto    
         group by a.produto,a.cor_produto,month(b.emissao)  
         ) as vendas_mes  
         group by vendas_mes.produto,vendas_mes.cor_produto)  
     IF (LTRIM(@tamanho)='11')  
         SET @Retorno = (select count(vendas_mes.mes) as qtde_mes_venda from (  
         select a.produto,a.cor_produto,month(b.emissao) as mes,sum(a.vo11) as vo11  
         from vendas_produto a  join vendas b on b.pedido = a.pedido  
         where b.emissao between @dta_ini and @dta_fin and a.vo11 <> 0  and   
         b.filial ='D.R. LINGERIE'  and a.produto=@produto and a.cor_produto=@cor_produto    
         group by a.produto,a.cor_produto,month(b.emissao)  
         ) as vendas_mes  
         group by vendas_mes.produto,vendas_mes.cor_produto)  
     IF (LTRIM(@tamanho)='12')  
         SET @Retorno = (select count(vendas_mes.mes) as qtde_mes_venda from (  
         select a.produto,a.cor_produto,month(b.emissao) as mes,sum(a.vo12) as vo12  
         from vendas_produto a  join vendas b on b.pedido = a.pedido  
         where b.emissao between @dta_ini and @dta_fin and a.vo12 <> 0  and   
         b.filial ='D.R. LINGERIE'  and a.produto=@produto and a.cor_produto=@cor_produto    
         group by a.produto,a.cor_produto,month(b.emissao)  
         ) as vendas_mes  
         group by vendas_mes.produto,vendas_mes.cor_produto)  
     IF (LTRIM(@tamanho)='13')  
         SET @Retorno = (select count(vendas_mes.mes) as qtde_mes_venda from (  
         select a.produto,a.cor_produto,month(b.emissao) as mes,sum(a.vo13) as vo13  
         from vendas_produto a  join vendas b on b.pedido = a.pedido  
         where b.emissao between @dta_ini and @dta_fin and a.vo13 <> 0  and   
         b.filial ='D.R. LINGERIE'  and a.produto=@produto and a.cor_produto=@cor_produto    
         group by a.produto,a.cor_produto,month(b.emissao)  
         ) as vendas_mes  
         group by vendas_mes.produto,vendas_mes.cor_produto)  
     IF (LTRIM(@tamanho)='14')  
         SET @Retorno = (select count(vendas_mes.mes) as qtde_mes_venda from (  
         select a.produto,a.cor_produto,month(b.emissao) as mes,sum(a.vo14) as vo14  
         from vendas_produto a  join vendas b on b.pedido = a.pedido  
         where b.emissao between @dta_ini and @dta_fin and a.vo14 <> 0  and   
         b.filial ='D.R. LINGERIE'  and a.produto=@produto and a.cor_produto=@cor_produto    
         group by a.produto,a.cor_produto,month(b.emissao)  
         ) as vendas_mes  
         group by vendas_mes.produto,vendas_mes.cor_produto)  
     IF (LTRIM(@tamanho)='15')  
         SET @Retorno = (select count(vendas_mes.mes) as qtde_mes_venda from (  
         select a.produto,a.cor_produto,month(b.emissao) as mes,sum(a.vo15) as vo15  
         from vendas_produto a  join vendas b on b.pedido = a.pedido  
         where b.emissao between @dta_ini and @dta_fin and a.vo15 <> 0  and   
         b.filial ='D.R. LINGERIE'  and a.produto=@produto and a.cor_produto=@cor_produto    
         group by a.produto,a.cor_produto,month(b.emissao)  
         ) as vendas_mes  
         group by vendas_mes.produto,vendas_mes.cor_produto)  
     IF (LTRIM(@tamanho)='16')  
         SET @Retorno = (select count(vendas_mes.mes) as qtde_mes_venda from (  
         select a.produto,a.cor_produto,month(b.emissao) as mes,sum(a.vo16) as vo16  
         from vendas_produto a  join vendas b on b.pedido = a.pedido  
         where b.emissao between @dta_ini and @dta_fin and a.vo16 <> 0  and   
         b.filial ='D.R. LINGERIE'  and a.produto=@produto and a.cor_produto=@cor_produto    
         group by a.produto,a.cor_produto,month(b.emissao)  
         ) as vendas_mes  
         group by vendas_mes.produto,vendas_mes.cor_produto)  
     RETURN(@Retorno)  
END;  