USE clinica_medica_db;

-- Inserção de ESPECIALIDADES
INSERT INTO ESPECIALIDADE (nome, descricao, valor_consulta) VALUES
('Cardiologia', 'Especialidade médica que se ocupa do diagnóstico e tratamento das doenças que acometem o coração', 200.00),
('Dermatologia', 'Especialidade médica que se ocupa do diagnóstico e tratamento das doenças da pele', 180.00),
('Pediatria', 'Especialidade médica dedicada à assistência à criança e ao adolescente', 150.00),
('Ginecologia', 'Especialidade médica que trata de doenças do sistema reprodutor feminino', 170.00),
('Ortopedia', 'Especialidade médica que cuida do aparelho locomotor', 190.00),
('Neurologia', 'Especialidade médica que trata dos distúrbios estruturais do sistema nervoso', 220.00),
('Psiquiatria', 'Especialidade da medicina que lida com a prevenção, diagnóstico e tratamento de transtornos mentais', 200.00),
('Oftalmologia', 'Especialidade médica que investiga e trata as doenças relacionadas aos olhos', 160.00);

-- Inserção de MÉDICOS
INSERT INTO MEDICO (nome, crm, telefone, email) VALUES
('Dr. João Silva', 'CRM12345', '(11) 99999-1111', 'joao.silva@clinica.com'),
('Dra. Maria Santos', 'CRM12346', '(11) 99999-2222', 'maria.santos@clinica.com'),
('Dr. Pedro Costa', 'CRM12347', '(11) 99999-3333', 'pedro.costa@clinica.com'),
('Dra. Ana Oliveira', 'CRM12348', '(11) 99999-4444', 'ana.oliveira@clinica.com'),
('Dr. Carlos Lima', 'CRM12349', '(11) 99999-5555', 'carlos.lima@clinica.com'),
('Dra. Fernanda Rocha', 'CRM12350', '(11) 99999-6666', 'fernanda.rocha@clinica.com'),
('Dr. Roberto Alves', 'CRM12351', '(11) 99999-7777', 'roberto.alves@clinica.com'),
('Dra. Juliana Pereira', 'CRM12352', '(11) 99999-8888', 'juliana.pereira@clinica.com');

-- Inserção de PACIENTES
INSERT INTO PACIENTE (nome, cpf, data_nascimento, telefone, endereco, email, convenio, numero_convenio) VALUES
('José da Silva', '123.456.789-01', '1980-05-15', '(11) 98888-1111', 'Rua A, 123, São Paulo, SP', 'jose.silva@email.com', 'Unimed', 'UN123456'),
('Maria Oliveira', '123.456.789-02', '1975-08-22', '(11) 98888-2222', 'Rua B, 456, São Paulo, SP', 'maria.oliveira@email.com', 'Bradesco Saúde', 'BR789012'),
('Pedro Santos', '123.456.789-03', '1990-12-10', '(11) 98888-3333', 'Rua C, 789, São Paulo, SP', 'pedro.santos@email.com', NULL, NULL),
('Ana Costa', '123.456.789-04', '1985-03-18', '(11) 98888-4444', 'Rua D, 321, São Paulo, SP', 'ana.costa@email.com', 'SulAmérica', 'SA456789'),
('Carlos Pereira', '123.456.789-05', '1970-11-25', '(11) 98888-5555', 'Rua E, 654, São Paulo, SP', 'carlos.pereira@email.com', 'Amil', 'AM123789'),
('Fernanda Lima', '123.456.789-06', '1995-07-08', '(11) 98888-6666', 'Rua F, 987, São Paulo, SP', 'fernanda.lima@email.com', NULL, NULL),
('Roberto Silva', '123.456.789-07', '1988-01-30', '(11) 98888-7777', 'Rua G, 147, São Paulo, SP', 'roberto.silva@email.com', 'Unimed', 'UN987654'),
('Juliana Rocha', '123.456.789-08', '1992-09-14', '(11) 98888-8888', 'Rua H, 258, São Paulo, SP', 'juliana.rocha@email.com', 'Bradesco Saúde', 'BR456123');

-- Relacionamento MEDICO_ESPECIALIDADE
INSERT INTO MEDICO_ESPECIALIDADE (id_medico, id_especialidade, data_certificacao) VALUES
(1, 1, '2015-01-15'), -- Dr. João Silva - Cardiologia
(2, 2, '2016-03-20'), -- Dra. Maria Santos - Dermatologia
(3, 3, '2017-05-10'), -- Dr. Pedro Costa - Pediatria
(4, 4, '2018-07-25'), -- Dra. Ana Oliveira - Ginecologia
(5, 5, '2019-02-14'), -- Dr. Carlos Lima - Ortopedia
(6, 6, '2020-04-18'), -- Dra. Fernanda Rocha - Neurologia
(7, 7, '2021-06-22'), -- Dr. Roberto Alves - Psiquiatria
(8, 8, '2022-08-30'), -- Dra. Juliana Pereira - Oftalmologia
(1, 6, '2020-11-10'), -- Dr. João Silva - Neurologia (segunda especialidade)
(2, 8, '2021-09-15'); -- Dra. Maria Santos - Oftalmologia (segunda especialidade)

-- Inserção de CONSULTAS
INSERT INTO CONSULTA (data_consulta, hora_consulta, status, observacoes, valor_consulta, id_paciente, id_medico, id_especialidade) VALUES
('2024-12-01', '09:00:00', 'agendada', 'Consulta de rotina', 200.00, 1, 1, 1),
('2024-12-01', '10:00:00', 'agendada', 'Avaliação dermatológica', 180.00, 2, 2, 2),
('2024-12-02', '14:00:00', 'realizada', 'Consulta pediátrica - vacinação', 150.00, 3, 3, 3),
('2024-12-02', '15:30:00', 'realizada', 'Exame ginecológico preventivo', 170.00, 4, 4, 4),
('2024-12-03', '08:30:00', 'agendada', 'Dor no joelho', 190.00, 5, 5, 5),
('2024-11-28', '16:00:00', 'realizada', 'Consulta neurológica', 220.00, 6, 6, 6),
('2024-11-29', '11:00:00', 'cancelada', 'Paciente cancelou', 200.00, 7, 7, 7),
('2024-12-04', '13:00:00', 'agendada', 'Exame oftalmológico', 160.00, 8, 8, 8);

-- Inserção de EXAMES
INSERT INTO EXAME (nome_exame, data_solicitacao, data_realizacao, resultado, valor_exame, status, id_consulta) VALUES
('Hemograma Completo', '2024-12-02', '2024-12-03', 'Valores normais', 80.00, 'realizado', 4),
('Ultrassom Pélvico', '2024-12-02', NULL, NULL, 120.00, 'solicitado', 4),
('Ressonância Magnética', '2024-11-28', '2024-11-30', 'Sem alterações significativas', 350.00, 'realizado', 6);

-- Inserção de RECEITAS
INSERT INTO RECEITA (data_emissao, medicamentos, dosagem, instrucoes, validade, id_consulta) VALUES
('2024-12-02', 'Dipirona 500mg', '1 comprimido de 6/6 horas', 'Tomar em caso de dor ou febre', '2025-01-02', 3),
('2024-12-02', 'Ácido Fólico 5mg', '1 comprimido ao dia', 'Tomar pela manhã, em jejum', '2025-01-02', 4),
('2024-11-28', 'Rivotril 2mg', '1/2 comprimido à noite', 'Tomar antes de dormir', '2024-12-28', 6);

-- Inserção de PAGAMENTOS
INSERT INTO PAGAMENTO (data_pagamento, valor_pago, forma_pagamento, status, descricao, id_consulta, id_exame) VALUES
('2024-12-02', 150.00, 'convenio', 'pago', 'Pagamento consulta pediátrica', 3, NULL),
('2024-12-02', 170.00, 'cartao', 'pago', 'Pagamento consulta ginecológica', 4, NULL),
('2024-11-28', 220.00, 'pix', 'pago', 'Pagamento consulta neurológica', 6, NULL),
(NULL, 200.00, 'convenio', 'pendente', 'Pagamento consulta cardiológica', 1, NULL),
(NULL, 180.00, 'convenio', 'pendente', 'Pagamento consulta dermatológica', 2, NULL),
('2024-12-03', 80.00, 'dinheiro', 'pago', 'Pagamento hemograma', NULL, 1),
('2024-11-30', 350.00, 'cartao', 'pago', 'Pagamento ressonância', NULL, 3);

SELECT 'Dados inseridos com sucesso!' AS status;
