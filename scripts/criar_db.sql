DROP DATABASE IF EXISTS clinica_medica_db;
CREATE DATABASE clinica_medica_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE clinica_medica_db;

-- Tabela PACIENTE
CREATE TABLE PACIENTE (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(15),
    endereco TEXT,
    email VARCHAR(100),
    convenio VARCHAR(100),
    numero_convenio VARCHAR(50),
    data_cadastro DATE NOT NULL DEFAULT (CURRENT_DATE),
    status ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo'
);

-- Tabela ESPECIALIDADE
CREATE TABLE ESPECIALIDADE (
    id_especialidade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    valor_consulta DECIMAL(10,2) NOT NULL
);

-- Tabela MEDICO
CREATE TABLE MEDICO (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(15),
    email VARCHAR(100),
    data_cadastro DATE NOT NULL DEFAULT (CURRENT_DATE),
    status ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo'
);

-- Tabela MEDICO_ESPECIALIDADE
CREATE TABLE MEDICO_ESPECIALIDADE (
    id_medico INT,
    id_especialidade INT,
    data_certificacao DATE,
    PRIMARY KEY (id_medico, id_especialidade),
    FOREIGN KEY (id_medico) REFERENCES MEDICO(id_medico),
    FOREIGN KEY (id_especialidade) REFERENCES ESPECIALIDADE(id_especialidade)
);

-- Tabela CONSULTA
CREATE TABLE CONSULTA (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    data_consulta DATE NOT NULL,
    hora_consulta TIME NOT NULL,
    status ENUM('agendada', 'realizada', 'cancelada') NOT NULL DEFAULT 'agendada',
    observacoes TEXT,
    valor_consulta DECIMAL(10,2) NOT NULL,
    data_agendamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_especialidade INT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES PACIENTE(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES MEDICO(id_medico),
    FOREIGN KEY (id_especialidade) REFERENCES ESPECIALIDADE(id_especialidade)
);

-- Tabela EXAME
CREATE TABLE EXAME (
    id_exame INT AUTO_INCREMENT PRIMARY KEY,
    nome_exame VARCHAR(200) NOT NULL,
    data_solicitacao DATE NOT NULL DEFAULT (CURRENT_DATE),
    data_realizacao DATE,
    resultado TEXT,
    observacoes TEXT,
    valor_exame DECIMAL(10,2) NOT NULL,
    status ENUM('solicitado', 'realizado', 'cancelado') NOT NULL DEFAULT 'solicitado',
    id_consulta INT NOT NULL,
    FOREIGN KEY (id_consulta) REFERENCES CONSULTA(id_consulta)
);

-- Tabela RECEITA
CREATE TABLE RECEITA (
    id_receita INT AUTO_INCREMENT PRIMARY KEY,
    data_emissao DATE NOT NULL DEFAULT (CURRENT_DATE),
    medicamentos TEXT NOT NULL,
    dosagem TEXT NOT NULL,
    instrucoes TEXT,
    validade DATE NOT NULL,
    id_consulta INT NOT NULL,
    FOREIGN KEY (id_consulta) REFERENCES CONSULTA(id_consulta)
);

-- Tabela PAGAMENTO
CREATE TABLE PAGAMENTO (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    data_pagamento DATE,
    valor_pago DECIMAL(10,2) NOT NULL,
    forma_pagamento ENUM('dinheiro', 'cartao', 'pix', 'convenio') NOT NULL,
    status ENUM('pendente', 'pago', 'cancelado') NOT NULL DEFAULT 'pendente',
    descricao TEXT,
    id_consulta INT,
    id_exame INT,
    FOREIGN KEY (id_consulta) REFERENCES CONSULTA(id_consulta),
    FOREIGN KEY (id_exame) REFERENCES EXAME(id_exame)
);

-- Views básicas
CREATE VIEW vw_agenda_medica AS
SELECT c.id_consulta, m.nome AS medico, p.nome AS paciente, e.nome AS especialidade, c.data_consulta, c.hora_consulta, c.status
FROM CONSULTA c JOIN MEDICO m ON c.id_medico = m.id_medico JOIN PACIENTE p ON c.id_paciente = p.id_paciente JOIN ESPECIALIDADE e ON c.id_especialidade = e.id_especialidade;

CREATE VIEW vw_receita_clinica AS
SELECT DATE_FORMAT(data_pagamento, '%Y-%m') AS periodo, SUM(valor_pago) AS receita_total
FROM PAGAMENTO WHERE status = 'pago' GROUP BY DATE_FORMAT(data_pagamento, '%Y-%m');

SELECT 'Banco de dados clinica_medica_db criado com sucesso!' AS status;
