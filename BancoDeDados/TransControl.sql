-- TABELAS SPRINT 1
-- CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE TransControl;
USE TransControl;


-- TABELA 1 (CADASTRO)

CREATE TABLE Cadastro (
idEmpresa int primary key auto_increment,
razaoSocial varchar(255) NOT NULL,
nomeFantasia varchar(255),
email varchar(40) NOT NULL,
logradouro varchar(30) NOT NULL,
CNPJ char(14) unique NOT NULL,
telefone char(14) NOT NULL,
senha varchar(20) NOT NULL
);

-- Inserção de dados na tabela Cadastro
INSERT INTO Cadastro VALUES
    (default, 'Empresa Metropolitana de Transportes Urbanos de São Paulo', 'EMTU', 'imprensa@emtu.sp.gov.br', 'R. Boa Vista, 150 - Centro Histórico de São Paulo, São Paulo', '58518069000191', '08007240555', '12345678'),
    (default, 'BB Transporte e Turismo', 'BBTT', 'turismo@benficabbtt.com.br', 'Avenida Sargento Jose Siqueira, 427 - Jardim Paraiso, Barueri - SP', '48748230000160', '41992730', '12345678'),
    (default, 'Viacao Osasco Ltda', 'Viacao Osasco', 'viacao@osaco.com.br', 'Av. Valter Boveri, 501A CEP: 06053-120 Jardim Novo Osasco - SP', '45645462000366', '35924261', '12345678');

DESCRIBE Cadastro;
SELECT * FROM Cadastro;




--	TABELA 2 (MODELO DO ONIBUS)

CREATE TABLE ModeloOnibus(
	idOnibus int primary key auto_increment NOT NULL,
	qtdPortas int NOT NULL,
    capacidade int NOT NULL,
	placa char(7),
	peso int, -- Em KG
    CONSTRAINT chkPortas CHECK(qtdPortas >= 2 AND qtdPortas <= 8)
);				

-- Inserção de dados na tabela ModeloOnibus
INSERT INTO ModeloOnibus VALUES
    (default, 3, 120, 'JPV8440', 26000), -- Onibus Articulado
    (default, 3, 20, 'BRA5679', 4000), -- Micro-Onibus
    (default, 3, 70, 'JTW9010', 16000); -- Onibus convencional

DESCRIBE ModeloOnibus;
SELECT * FROM ModeloOnibus;




-- TABELA 3 (SENSORES)

CREATE TABLE sensor(
	idSensor int primary key auto_increment,
	portaSensor int NOT NULL,
     CONSTRAINT chkPorta CHECK(portaSensor = 'SAIDA' OR portaSensor = 'ENTRADA')
);

-- Inserção de dados na tabela sensor
INSERT INTO sensor VALUES
    (default, 'ENTRADA'),
    (default, 'SAIDA'),
    (default, 'SAIDA');

DESCRIBE sensor;
SELECT * FROM sensor;




-- TABELA 4 (DADOS)

CREATE TABLE dados(
	idDado int primary key auto_increment,
    ativacao tinyint,
	horarioAtivacao datetime DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chkDado CHECK(ativacao = 0 OR ativacao = 1)
    );

-- Inserção de dados na tabela dados
INSERT INTO dados VALUES
    (default, 1, default),
    (default, 0, default),
    (default, 1, default);

DESCRIBE dados;
SELECT * FROM dados;