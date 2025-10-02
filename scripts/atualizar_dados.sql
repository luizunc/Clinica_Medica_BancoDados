USE clinica_medica_db;

-- 1. Atualizar telefone de um paciente
UPDATE PACIENTE SET telefone = '(11) 99999-0000' WHERE id_paciente = 1;

-- 2. Atualizar status de consulta para realizada
UPDATE CONSULTA SET status = 'realizada' WHERE id_consulta = 1;

-- 3. Cancelar uma consulta
UPDATE CONSULTA SET status = 'cancelada', observacoes = 'Cancelada pelo paciente' WHERE id_consulta = 5;

-- 4. Atualizar resultado de exame
UPDATE EXAME SET data_realizacao = CURRENT_DATE, resultado = 'Exame normal', status = 'realizado' WHERE id_exame = 2;

-- 5. Realizar pagamento
UPDATE PAGAMENTO SET status = 'pago', data_pagamento = CURRENT_DATE WHERE id_pagamento = 4;

-- 6. Adicionar nova especialidade
INSERT INTO ESPECIALIDADE (nome, descricao, valor_consulta) VALUES ('Urologia', 'Especialidade que trata do trato urinário', 210.00);

-- 7. Cadastrar novo médico
INSERT INTO MEDICO (nome, crm, telefone, email) VALUES ('Dr. Ricardo Mendes', 'CRM12353', '(11) 99999-9999', 'ricardo.mendes@clinica.com');

-- 8. Associar médico à especialidade
INSERT INTO MEDICO_ESPECIALIDADE (id_medico, id_especialidade, data_certificacao) VALUES (9, 9, CURRENT_DATE);

-- 9. Agendar nova consulta
INSERT INTO CONSULTA (data_consulta, hora_consulta, valor_consulta, id_paciente, id_medico, id_especialidade) VALUES ('2024-12-10', '10:00:00', 210.00, 1, 9, 9);

-- 10. Criar pagamento para nova consulta
INSERT INTO PAGAMENTO (valor_pago, forma_pagamento, status, id_consulta) VALUES (210.00, 'convenio', 'pendente', LAST_INSERT_ID());

-- 11. Solicitar novo exame
INSERT INTO EXAME (nome_exame, valor_exame, id_consulta) VALUES ('Ultrassom Abdominal', 150.00, 4);

-- 12. Emitir nova receita
INSERT INTO RECEITA (medicamentos, dosagem, instrucoes, validade, id_consulta) VALUES ('Paracetamol 750mg', '1 comprimido de 8/8 horas', 'Tomar após as refeições', DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY), 1);

-- 13. Atualizar endereço de paciente
UPDATE PACIENTE SET endereco = 'Rua Nova, 999, São Paulo, SP' WHERE id_paciente = 2;

-- 14. Inativar médico
UPDATE MEDICO SET status = 'inativo' WHERE id_medico = 7;

-- 15. Atualizar valor de consulta por especialidade
UPDATE ESPECIALIDADE SET valor_consulta = 250.00 WHERE nome = 'Neurologia';

-- 16. Cancelar exame
UPDATE EXAME SET status = 'cancelado' WHERE id_exame = 2;

-- 17. Atualizar forma de pagamento
UPDATE PAGAMENTO SET forma_pagamento = 'pix' WHERE id_pagamento = 5;

-- 18. Adicionar observação em consulta
UPDATE CONSULTA SET observacoes = 'Paciente apresentou melhora significativa' WHERE id_consulta = 4;

-- 19. Cadastrar novo paciente
INSERT INTO PACIENTE (nome, cpf, data_nascimento, telefone, endereco, email) VALUES ('Lucas Ferreira', '123.456.789-09', '1987-04-12', '(11) 98888-9999', 'Rua I, 369, São Paulo, SP', 'lucas.ferreira@email.com');

-- 20. Reagendar consulta
UPDATE CONSULTA SET data_consulta = '2024-12-15', hora_consulta = '14:00:00' WHERE id_consulta = 8;

-- 21. Atualizar email do médico
UPDATE MEDICO SET email = 'joao.silva.novo@clinica.com' WHERE id_medico = 1;

-- 22. Marcar pagamento como cancelado
UPDATE PAGAMENTO SET status = 'cancelado' WHERE id_pagamento = 7;

-- 23. Atualizar convênio do paciente
UPDATE PACIENTE SET convenio = 'Porto Seguro', numero_convenio = 'PS789456' WHERE id_paciente = 3;

-- 24. Finalizar exame com resultado
UPDATE EXAME SET status = 'realizado', data_realizacao = CURRENT_DATE, resultado = 'Dentro dos parâmetros normais' WHERE id_exame = 4;

-- 25. Remover especialidade de médico
DELETE FROM MEDICO_ESPECIALIDADE WHERE id_medico = 2 AND id_especialidade = 8;

-- Verificações finais
SELECT 'Pacientes ativos:' AS info, COUNT(*) AS total FROM PACIENTE WHERE status = 'ativo'
UNION ALL
SELECT 'Consultas agendadas:', COUNT(*) FROM CONSULTA WHERE status = 'agendada'
UNION ALL
SELECT 'Pagamentos pendentes:', COUNT(*) FROM PAGAMENTO WHERE status = 'pendente'
UNION ALL
SELECT 'Exames realizados:', COUNT(*) FROM EXAME WHERE status = 'realizado';

SELECT 'Atualizações executadas com sucesso!' AS status;
