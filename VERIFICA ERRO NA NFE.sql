SELECT A.NF_SAIDA,A.CHAVE_NFE,B.DATA_MAX,C.MENSAGEM,C.STATUS_PROCESSO FROM FATURAMENTO A
JOIN (
SELECT A.NF_SAIDA,CHAVE_NFE,DATA_MAX=MAX(D.DATA_FIM) 
FROM FATURAMENTO A 
JOIN EDI_ARQUIVO B ON A.CHAVE_NFE=B.EDI_REFERENCIA_ARQUIVO
JOIN EDI_ARQUIVO_LOG C ON B.ID_EDI_ARQUIVO=C.ID_EDI_ARQUIVO
JOIN PROCESSOS_SISTEMA_ATIVIDADES D ON C.ID_PROCESSO=D.ID_PROCESSO AND C.ITEM_PROCESSO=D.ITEM_PROCESSO
JOIN PROCESSOS_SISTEMA E ON D.ID_PROCESSO=E.ID_PROCESSO 
GROUP BY A.NF_SAIDA,CHAVE_NFE
) B ON  B.NF_SAIDA=A.NF_SAIDA AND B.CHAVE_NFE=A.CHAVE_NFE
JOIN PROCESSOS_SISTEMA_ATIVIDADES C ON C.DATA_FIM=B.DATA_MAX
WHERE CONVERT(CHAR(10),DATA_MAX,103) = CONVERT(CHAR(10),GETDATE(),103) AND C.MENSAGEM LIKE '%ERROR%'
ORDER BY NF_SAIDA

EXEC SP_NFE_COM_ERROS_EMAIL_HTML

alter PROCEDURE SP_NFE_COM_ERROS_EMAIL_HTML AS              

BEGIN              
DECLARE @tableHTML  NVARCHAR(MAX) ;              
DECLARE @p_recipients as nvarchar(max) ; 
DECLARE @validcnt int ;             
        
SELECT  @validcnt = count(*)
		FROM FATURAMENTO A
		JOIN (
		SELECT A.NF_SAIDA,CHAVE_NFE,DATA_MAX=MAX(D.DATA_FIM) 
		FROM FATURAMENTO A 
		JOIN EDI_ARQUIVO B ON A.CHAVE_NFE=B.EDI_REFERENCIA_ARQUIVO
		JOIN EDI_ARQUIVO_LOG C ON B.ID_EDI_ARQUIVO=C.ID_EDI_ARQUIVO
		JOIN PROCESSOS_SISTEMA_ATIVIDADES D ON C.ID_PROCESSO=D.ID_PROCESSO AND C.ITEM_PROCESSO=D.ITEM_PROCESSO
		JOIN PROCESSOS_SISTEMA E ON D.ID_PROCESSO=E.ID_PROCESSO 
		GROUP BY A.NF_SAIDA,CHAVE_NFE
		) B ON  B.NF_SAIDA=A.NF_SAIDA AND B.CHAVE_NFE=A.CHAVE_NFE
		JOIN PROCESSOS_SISTEMA_ATIVIDADES C ON C.DATA_FIM=B.DATA_MAX
		WHERE CONVERT(CHAR(10),DATA_MAX,103) = CONVERT(CHAR(10),GETDATE(),103) AND C.MENSAGEM LIKE '%ERROR%'

IF @validcnt > 0              
	BEGIN            
		SET @p_recipients = N''          
		              
		SET @tableHTML =              
			N'<H1>Rela��o de NFe com erro retornado pelo monitor do Visual Linx</H1>' +              
			N'<table border="1">' +              
			N'<tr style="background-color: #000080; color: #FFFFFF;"><th>NFe</th><th>Chave NFe</th><th>Data</th><th>Mensagem</th>' +              
			N'<th>Status</th></tr>' +              
			CAST ( ( 
					 SELECT 
					 td=A.NF_SAIDA,'',
					 td=A.CHAVE_NFE,'',
					 td=B.DATA_MAX,'',
					 td=C.MENSAGEM,'',
					 td=C.STATUS_PROCESSO
					 FROM FATURAMENTO A
		 			 JOIN (
					 SELECT A.NF_SAIDA,CHAVE_NFE,DATA_MAX=MAX(D.DATA_FIM) 
					 FROM FATURAMENTO A 
					 JOIN EDI_ARQUIVO B ON A.CHAVE_NFE=B.EDI_REFERENCIA_ARQUIVO
					 JOIN EDI_ARQUIVO_LOG C ON B.ID_EDI_ARQUIVO=C.ID_EDI_ARQUIVO
					 JOIN PROCESSOS_SISTEMA_ATIVIDADES D ON C.ID_PROCESSO=D.ID_PROCESSO AND C.ITEM_PROCESSO=D.ITEM_PROCESSO
					 JOIN PROCESSOS_SISTEMA E ON D.ID_PROCESSO=E.ID_PROCESSO 
					 GROUP BY A.NF_SAIDA,CHAVE_NFE
					 ) B ON  B.NF_SAIDA=A.NF_SAIDA AND B.CHAVE_NFE=A.CHAVE_NFE
					 JOIN PROCESSOS_SISTEMA_ATIVIDADES C ON C.DATA_FIM=B.DATA_MAX
					 WHERE CONVERT(CHAR(10),DATA_MAX,103) = CONVERT(CHAR(10),GETDATE(),103) AND C.MENSAGEM LIKE '%ERROR%'
					 ORDER BY a.NF_SAIDA
		            
					 FOR XML PATH('tr'), TYPE               
			) AS NVARCHAR(MAX) ) +              
			N'</table>' ;              
		              
		EXEC msdb.dbo.sp_send_dbmail        
			@recipients=@p_recipients,              
			@copy_recipients=N'',               
			@blind_copy_recipients=N'paulino.ti@delriointernational.com',              
			@profile_name = 'ti',              
			@subject = 'Email Autom�tico:Rela��o de NFe com erro retornado pelo monitor do Visual Linx',              
			@body = @tableHTML,              
			@body_format = 'HTML' ; 
	END
END



