SELECT * FROM W_MONITORA_EMAIL
WHERE DATAENVIO >='20170118' AND SITUACAO = '2 - Falhou'


SELECT * FROM W_MONITORA_EMAIL
WHERE destinatario='financeiro1@drling.com.br' DATAENVIO >='20170118' AND SITUACAO = '2 - Falhou'