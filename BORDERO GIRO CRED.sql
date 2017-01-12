SELECT A.cgc_cpf,	A.razao_social,	fatura,	id_parcela,	vencimento,	desconto_venc,
data_desconto_venc,	vencimento_real,	valor_original,	saldo_principal_devido,	
total_desconto_concedido,	A.cobranca_uf,	A.cobranca_cidade,	A.cobranca_bairro,	
condicao_pgto,	desc_cond_pgto,	A.cobranca_cep,	A.uf,CHAVE_NFE, B.ENDERECO,B.NUMERO,B.DDD1, B.TELEFONE1
FROM W_CTB_A_RECEBER_PARCELA A
JOIN CADASTRO_CLI_FOR B ON B.COD_CLIFOR=A.COD_CLIFOR
WHERE SERIE='2' AND
RTRIM(FATURA)+RTRIM(ID_PARCELA) IN(
'041010C',
'041010D',
'041010E',
'040999A',
'040997A',
'040985B',
'040985C',
'041129C',
'041129D',
'041123C',
'041123D',
'041156C',
'041156D',
'041156E',
'041146B',
'041146C',
'040894A',
'041034A',
'041221C',
'041221D',
'041221E',
'041022A',
'041021A',
'041177A',
'041177B',
'041177C',
'041176A',
'041176B',
'041176C',
'041175B',
'041175C',
'041175D',
'041169B',
'041169C',
'041323C',
'041323D',
'041323E',
'041162B',
'041162C',
'041162D',
'041336B',
'041336C',
'041306C',
'041306D',
'041336D',
'041336E',
'041306E',
'041303B',
'041303C',
'041303D',
'041301C',
'041301D',
'041301E',
'041293D',
'041341C',
'041341D',
'041341E',
'041339B',
'041339C',
'041339D',
'041281B',
'041281C',
'041281D',
'041362B',
'041362C',
'041276B',
'041276C',
'041276D',
'041373A',
'041371A',
'041371B',
'041371C',
'041384B',
'041384C',
'041384D',
'041260C',
'041260D',
'040868A',
'040867A',
'040888A',
'041033A',
'041028A',
'040949A',
'041539A',
'041539B',
'041539C',
'041539D',
'041391B',
'041391C',
'041258C',
'041258D',
'041258E',
'041381A',
'041454B',
'041454C',
'041454D',
'041454E',
'041250B',
'041250C',
'041250D',
'041578A',
'041418B',
'041418C',
'041418D',
'041418E',
'041244B',
'041244C',
'041565C',
'041565D',
'041565E',
'041565F',
'041565G',
'041565H',
'041565I',
'041565J',
'041564C',
'041564D',
'041564E',
'041564F',
'041564G',
'041564H',
'041564I',
'041564J',
'041562B',
'041562C',
'041562D',
'041562E',
'041559A',
'041406A',
'041402C',
'041402D',
'041402E',
'041401A',
'041401B',
'041568A',
'041568B',
'041568C',
'041568D',
'041401C',
'041401D',
'041227C',
'041227D',
'041227E',
'041211B',
'041211C',
'041584B',
'041584C',
'041584D',
'041584E',
'041190C',
'041190D',
'041190E',
'041185B',
'041185C',
'041185D',
'041181B',
'041181C',
'041181D',
'041450A',
'041450B',
'041450C',
'041450D',
'041463B',
'041463C',
'041480A',
'041479A',
'041477A',
'041476A',
'041475A',
'041487A',
'041487B',
'041487C',
'041495A',
'041495B',
'041495C',
'041495D',
'041502A',
'041502B',
'041502C',
'041502D',
'041523B',
'041523C',
'041523D',
'041526B',
'041526C',
'041526D',
'041526E',
'041518B',
'041518C',
'041518D',
'041518E',
'041532A',
'041532B',
'041532C',
'041532D',
'041532E',
'040847C',
'041043A',
'041042B',
'041042C',
'041042D',
'041104B',
'040809B',
'040809C',
'040809D',
'041063C',
'041063D',
'040824A',
'040995A',
'041104C',
'041104D',
'041098B',
'041098C',
'041069C',
'041067B',
'041067C',
'040834B',
'040834C')
ORDER BY FATURA




