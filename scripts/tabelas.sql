USE clinica_medica_db;

-- 1. Listar todos os pacientes ativos
SELECT nome, cpf, telefone, convenio FROM PACIENTE WHERE status = 'ativo';

-- 2. Listar todos os médicos e suas especialidades
SELECT m.nome AS medico, m.crm, e.nome AS especialidade FROM MEDICO m 
JOIN MEDICO_ESPECIALIDADE me ON m.id_medico = me.id_medico 
JOIN ESPECIALIDADE e ON me.id_especialidade = e.id_especialidade;

-- 3. Agenda médica do dia
SELECT m.nome AS medico, p.nome AS paciente, c.data_consulta, c.hora_consulta, c.status 
FROM CONSULTA c 
JOIN MEDICO m ON c.id_medico = m.id_medico 
JOIN PACIENTE p ON c.id_paciente = p.id_paciente 
WHERE c.data_consulta = CURRENT_DATE;

-- 4. Consultas agendadas
SELECT p.nome AS paciente, m.nome AS medico, e.nome AS especialidade, c.data_consulta, c.hora_consulta 
FROM CONSULTA c 
JOIN PACIENTE p ON c.id_paciente = p.id_paciente 
JOIN MEDICO m ON c.id_medico = m.id_medico 
JOIN ESPECIALIDADE e ON c.id_especialidade = e.id_especialidade 
WHERE c.status = 'agendada';

-- 5. Histórico de consultas de um paciente
SELECT c.data_consulta, m.nome AS medico, e.nome AS especialidade, c.status, c.observacoes 
FROM CONSULTA c 
JOIN MEDICO m ON c.id_medico = m.id_medico 
JOIN ESPECIALIDADE e ON c.id_especialidade = e.id_especialidade 
WHERE c.id_paciente = 1 ORDER BY c.data_consulta DESC;

-- 6. Exames solicitados
SELECT p.nome AS paciente, ex.nome_exame, ex.data_solicitacao, ex.status 
FROM EXAME ex 
JOIN CONSULTA c ON ex.id_consulta = c.id_consulta 
JOIN PACIENTE p ON c.id_paciente = p.id_paciente;

-- 7. Receitas emitidas
SELECT p.nome AS paciente, r.medicamentos, r.dosagem, r.data_emissao, r.validade 
FROM RECEITA r 
JOIN CONSULTA c ON r.id_consulta = c.id_consulta 
JOIN PACIENTE p ON c.id_paciente = p.id_paciente;

-- 8. Pagamentos pendentes
SELECT p.nome AS paciente, pg.valor_pago, pg.forma_pagamento, pg.status 
FROM PAGAMENTO pg 
JOIN CONSULTA c ON pg.id_consulta = c.id_consulta 
JOIN PACIENTE p ON c.id_paciente = p.id_paciente 
WHERE pg.status = 'pendente';

-- 9. Receita da clínica por mês
SELECT DATE_FORMAT(data_pagamento, '%Y-%m') AS mes, SUM(valor_pago) AS receita_total 
FROM PAGAMENTO WHERE status = 'pago' GROUP BY DATE_FORMAT(data_pagamento, '%Y-%m');

-- 10. Consultas por especialidade
SELECT e.nome AS especialidade, COUNT(c.id_consulta) AS total_consultas 
FROM CONSULTA c 
JOIN ESPECIALIDADE e ON c.id_especialidade = e.id_especialidade 
GROUP BY e.nome ORDER BY total_consultas DESC;

-- 11. Médicos mais procurados
SELECT m.nome AS medico, COUNT(c.id_consulta) AS total_consultas 
FROM CONSULTA c 
JOIN MEDICO m ON c.id_medico = m.id_medico 
GROUP BY m.nome ORDER BY total_consultas DESC;

-- 12. Pacientes com convênio
SELECT nome, convenio, numero_convenio FROM PACIENTE WHERE convenio IS NOT NULL;

-- 13. Consultas realizadas no último mês
SELECT p.nome AS paciente, m.nome AS medico, c.data_consulta 
FROM CONSULTA c 
JOIN PACIENTE p ON c.id_paciente = p.id_paciente 
JOIN MEDICO m ON c.id_medico = m.id_medico 
WHERE c.status = 'realizada' AND c.data_consulta >= DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH);

-- 14. Exames realizados
SELECT p.nome AS paciente, ex.nome_exame, ex.data_realizacao, ex.resultado 
FROM EXAME ex 
JOIN CONSULTA c ON ex.id_consulta = c.id_consulta 
JOIN PACIENTE p ON c.id_paciente = p.id_paciente 
WHERE ex.status = 'realizado';

-- 15. Agenda de um médico específico
SELECT p.nome AS paciente, c.data_consulta, c.hora_consulta, c.status 
FROM CONSULTA c 
JOIN PACIENTE p ON c.id_paciente = p.id_paciente 
WHERE c.id_medico = 1 ORDER BY c.data_consulta, c.hora_consulta;

-- 16. Receitas válidas
SELECT p.nome AS paciente, r.medicamentos, r.validade 
FROM RECEITA r 
JOIN CONSULTA c ON r.id_consulta = c.id_consulta 
JOIN PACIENTE p ON c.id_paciente = p.id_paciente 
WHERE r.validade >= CURRENT_DATE;

-- 17. Estatísticas gerais
SELECT 
    (SELECT COUNT(*) FROM PACIENTE WHERE status = 'ativo') AS pacientes_ativos,
    (SELECT COUNT(*) FROM MEDICO WHERE status = 'ativo') AS medicos_ativos,
    (SELECT COUNT(*) FROM CONSULTA WHERE status = 'agendada') AS consultas_agendadas,
    (SELECT COUNT(*) FROM EXAME WHERE status = 'solicitado') AS exames_pendentes;

-- 18. Pagamentos por forma de pagamento
SELECT forma_pagamento, COUNT(*) AS quantidade, SUM(valor_pago) AS total 
FROM PAGAMENTO WHERE status = 'pago' GROUP BY forma_pagamento;

-- 19. Consultas canceladas
SELECT p.nome AS paciente, m.nome AS medico, c.data_consulta, c.observacoes 
FROM CONSULTA c 
JOIN PACIENTE p ON c.id_paciente = p.id_paciente 
JOIN MEDICO m ON c.id_medico = m.id_medico 
WHERE c.status = 'cancelada';

-- 20. Próximas consultas (próximos 7 dias)
SELECT p.nome AS paciente, m.nome AS medico, c.data_consulta, c.hora_consulta 
FROM CONSULTA c 
JOIN PACIENTE p ON c.id_paciente = p.id_paciente 
JOIN MEDICO m ON c.id_medico = m.id_medico 
WHERE c.status = 'agendada' AND c.data_consulta BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY);

SELECT 'Consultas executadas com sucesso!' AS status;
