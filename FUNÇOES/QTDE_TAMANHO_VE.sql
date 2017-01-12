create FUNCTION Qtde_Tamanho_VE (@produto varchar(10),@cor_produto varchar(10),@tamanho char(2),@dta_ini CHAR(10), @dta_fin CHAR(10))    
RETURNS int    
WITH EXECUTE AS CALLER    
AS    
BEGIN    
     DECLARE @Retorno int    
     IF (LTRIM(@tamanho)='1')    
      SET @Retorno = (select sum(a.ve1) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and b.aprovacao <> 'R' and
         b.tabela_filha = 'VENDAS_PRODUTO' and a.entrega between @dta_ini and @dta_fin and b.filial='DR VAREJO')    
     IF (LTRIM(@tamanho)='2')    
      SET @Retorno = (select sum(a.ve2) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and b.aprovacao <> 'R' and    
         b.tabela_filha = 'VENDAS_PRODUTO' and a.entrega between @dta_ini and @dta_fin and b.filial='DR VAREJO')    
     IF (LTRIM(@tamanho)='3')    
      SET @Retorno = (select sum(a.ve3) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and b.aprovacao <> 'R' and
         b.tabela_filha = 'VENDAS_PRODUTO' and a.entrega between @dta_ini and @dta_fin and b.filial='DR VAREJO')    
     IF (LTRIM(@tamanho)='4')    
      SET @Retorno = (select sum(a.ve4) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and b.aprovacao <> 'R' and
         b.tabela_filha = 'VENDAS_PRODUTO' and a.entrega between @dta_ini and @dta_fin and b.filial='DR VAREJO')    
     IF (LTRIM(@tamanho)='5')    
      SET @Retorno = (select sum(a.ve5) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and b.aprovacao <> 'R' and
         b.tabela_filha = 'VENDAS_PRODUTO' and a.entrega between @dta_ini and @dta_fin and b.filial='DR VAREJO')    
     IF (LTRIM(@tamanho)='6')    
      SET @Retorno = (select sum(a.ve6) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and b.aprovacao <> 'R' and
         b.tabela_filha = 'VENDAS_PRODUTO' and a.entrega between @dta_ini and @dta_fin and b.filial='DR VAREJO')    
     IF (LTRIM(@tamanho)='7')    
      SET @Retorno = (select sum(a.ve7) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and b.aprovacao <> 'R' and
         b.tabela_filha = 'VENDAS_PRODUTO' and a.entrega between @dta_ini and @dta_fin and b.filial='DR VAREJO')    
     IF (LTRIM(@tamanho)='8')    
      SET @Retorno = (select sum(a.ve8) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and b.aprovacao <> 'R' and
         b.tabela_filha = 'VENDAS_PRODUTO' and a.entrega between @dta_ini and @dta_fin and b.filial='DR VAREJO')    
     IF (LTRIM(@tamanho)='9')    
      SET @Retorno = (select sum(a.ve9) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and b.aprovacao <> 'R' and
         b.tabela_filha = 'VENDAS_PRODUTO' and a.entrega between @dta_ini and @dta_fin and b.filial='DR VAREJO')    
     IF (LTRIM(@tamanho)='10')    
      SET @Retorno = (select sum(a.ve10) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and b.aprovacao <> 'R' and
         b.tabela_filha = 'VENDAS_PRODUTO' and a.entrega between @dta_ini and @dta_fin and b.filial='DR VAREJO')    
     IF (LTRIM(@tamanho)='11')    
      SET @Retorno = (select sum(a.ve11) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and b.aprovacao <> 'R' and
         b.tabela_filha = 'VENDAS_PRODUTO' and a.entrega between @dta_ini and @dta_fin and b.filial='DR VAREJO')    
     IF (LTRIM(@tamanho)='12')    
      SET @Retorno = (select sum(a.ve12) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and b.aprovacao <> 'R' and
         b.tabela_filha = 'VENDAS_PRODUTO' and a.entrega between @dta_ini and @dta_fin and b.filial='DR VAREJO')    
     IF (LTRIM(@tamanho)='13')    
      SET @Retorno = (select sum(a.ve13) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and b.aprovacao <> 'R' and
         b.tabela_filha = 'VENDAS_PRODUTO' and a.entrega between @dta_ini and @dta_fin and b.filial='DR VAREJO')    
     IF (LTRIM(@tamanho)='14')    
      SET @Retorno = (select sum(a.ve14) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and b.aprovacao <> 'R' and
         b.tabela_filha = 'VENDAS_PRODUTO' and a.entrega between @dta_ini and @dta_fin and b.filial='DR VAREJO')    
     IF (LTRIM(@tamanho)='15')    
      SET @Retorno = (select sum(a.ve15) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and b.aprovacao <> 'R' and
         b.tabela_filha = 'VENDAS_PRODUTO' and a.entrega between @dta_ini and @dta_fin and b.filial='DR VAREJO')    
     IF (LTRIM(@tamanho)='16')    
      SET @Retorno = (select sum(a.ve16) as qtde_tamanho from vendas_produto a    
         join vendas b on b.pedido=a.pedido    
         where a.produto=@produto and a.cor_produto=@cor_produto and b.aprovacao <> 'R' and
         b.tabela_filha = 'VENDAS_PRODUTO' and a.entrega between @dta_ini and @dta_fin and b.filial='DR VAREJO')    
     RETURN(@Retorno)    
END;    



