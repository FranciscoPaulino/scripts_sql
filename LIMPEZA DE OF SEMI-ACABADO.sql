update M_ORDEM_FABRICACAO
set status ='E'
where YEAR(M_ORDEM_FABRICACAO.EMISSAO) < 2015 AND status <> 'E'




/* lx007001spk  CursorAdapter: cur_v_m_ordem_fabricacao_00(Alias: v_m_ordem_fabricacao_00)  */
SELECT * FROM M_ORDEM_FABRICACAO
JOIN FILIAIS FILIAIS  ON M_ORDEM_FABRICACAO.FILIAL = FILIAIS.FILIAL  
LEFT JOIN MATERIAIS MATERIAIS ON M_ORDEM_FABRICACAO.MATERIAL = MATERIAIS.MATERIAL  
LEFT JOIN PRODUCAO_FUNCAO ON M_ORDEM_FABRICACAO.FUNCAO_PRODUTIVA = PRODUCAO_FUNCAO.FUNCAO_PRODUTIVA 
WHERE status <> 'E' and YEAR(M_ORDEM_FABRICACAO.EMISSAO) < 2015
