### Transformação do Modelo Conceitual para Lógico

O modelo conceitual foi transformado em modelo lógico relacional. Entidades se tornaram tabelas, atributos se tornaram colunas, e relacionamentos foram implementados através de chaves estrangeiras.

### Tabelas do Sistema
```

#### 1. PACIENTE
    id_paciente: INTEGER [PK],
    nome: VARCHAR(100) [NOT NULL],
    cpf: VARCHAR(14) [UNIQUE, NOT NULL],
    data_nascimento: DATE [NOT NULL],
    telefone: VARCHAR(15),
    endereco: TEXT,
    email: VARCHAR(100),
    convenio: VARCHAR(100),
    numero_convenio: VARCHAR(50),
    data_cadastro: DATE [NOT NULL],
    status: ENUM('ativo', 'inativo') [DEFAULT 'ativo']
)
```

#### 2. ESPECIALIDADE
```
ESPECIALIDADE (
    id_especialidade: INTEGER [PK],
    nome: VARCHAR(100) [UNIQUE, NOT NULL],
    descricao: TEXT,
    valor_consulta: DECIMAL(10,2) [NOT NULL]
)
```

#### 3. MEDICO
```
MEDICO (
    id_medico: INTEGER [PK],
    nome: VARCHAR(100) [NOT NULL],
    crm: VARCHAR(20) [UNIQUE, NOT NULL],
    telefone: VARCHAR(15),
    email: VARCHAR(100),
    data_cadastro: DATE [NOT NULL],
    status: ENUM('ativo', 'inativo') [DEFAULT 'ativo']
)
```

#### 4. MEDICO_ESPECIALIDADE (Tabela Associativa)
```
MEDICO_ESPECIALIDADE (
    id_medico: INTEGER [PK, FK -> MEDICO.id_medico],
    id_especialidade: INTEGER [PK, FK -> ESPECIALIDADE.id_especialidade],
    data_certificacao: DATE
)
```

#### 5. CONSULTA
```
CONSULTA (
    id_consulta: INTEGER [PK],
    data_consulta: DATE [NOT NULL],
    hora_consulta: TIME [NOT NULL],
    status: ENUM('agendada', 'realizada', 'cancelada') [DEFAULT 'agendada'],
    observacoes: TEXT,
    valor_consulta: DECIMAL(10,2) [NOT NULL],
    data_agendamento: DATETIME [NOT NULL],
    id_paciente: INTEGER [FK -> PACIENTE.id_paciente],
    id_medico: INTEGER [FK -> MEDICO.id_medico],
    id_especialidade: INTEGER [FK -> ESPECIALIDADE.id_especialidade]
)
```

#### 6. EXAME
```
EXAME (
    id_exame: INTEGER [PK],
    nome_exame: VARCHAR(200) [NOT NULL],
    data_solicitacao: DATE [NOT NULL],
    data_realizacao: DATE,
    resultado: TEXT,
    observacoes: TEXT,
    valor_exame: DECIMAL(10,2) [NOT NULL],
    status: ENUM('solicitado', 'realizado', 'cancelado') [DEFAULT 'solicitado'],
    id_consulta: INTEGER [FK -> CONSULTA.id_consulta]
)
```

#### 7. RECEITA
```
RECEITA (
    id_receita: INTEGER [PK],
    data_emissao: DATE [NOT NULL],
    medicamentos: TEXT [NOT NULL],
    dosagem: TEXT [NOT NULL],
    instrucoes: TEXT,
    validade: DATE [NOT NULL],
    id_consulta: INTEGER [FK -> CONSULTA.id_consulta]
)
```

#### 8. PAGAMENTO
```
PAGAMENTO (
    id_pagamento: INTEGER [PK],
    data_pagamento: DATE,
    valor_pago: DECIMAL(10,2) [NOT NULL],
    forma_pagamento: ENUM('dinheiro', 'cartao', 'pix', 'convenio') [NOT NULL],
    status: ENUM('pendente', 'pago', 'cancelado') [DEFAULT 'pendente'],
    descricao: TEXT,
    id_consulta: INTEGER [FK -> CONSULTA.id_consulta],
    id_exame: INTEGER [FK -> EXAME.id_exame]
)
```

### Relacionamentos e Chaves Estrangeiras

#### Relacionamentos 1:N
1. **PACIENTE → CONSULTA**
   - `CONSULTA.id_paciente` referencia `PACIENTE.id_paciente`

2. **MEDICO → CONSULTA**
   - `CONSULTA.id_medico` referencia `MEDICO.id_medico`

3. **ESPECIALIDADE → CONSULTA**
   - `CONSULTA.id_especialidade` referencia `ESPECIALIDADE.id_especialidade`

4. **CONSULTA → EXAME**
   - `EXAME.id_consulta` referencia `CONSULTA.id_consulta`

5. **CONSULTA → RECEITA**
   - `RECEITA.id_consulta` referencia `CONSULTA.id_consulta`

6. **CONSULTA → PAGAMENTO**
   - `PAGAMENTO.id_consulta` referencia `CONSULTA.id_consulta`

7. **EXAME → PAGAMENTO**
   - `PAGAMENTO.id_exame` referencia `EXAME.id_exame`

#### Relacionamentos N:M
1. **MEDICO ↔ ESPECIALIDADE** (através da tabela MEDICO_ESPECIALIDADE)
   - `MEDICO_ESPECIALIDADE.id_medico` referencia `MEDICO.id_medico`
   - `MEDICO_ESPECIALIDADE.id_especialidade` referencia `ESPECIALIDADE.id_especialidade`

