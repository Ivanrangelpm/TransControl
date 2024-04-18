CREATE DATABASE TransControl;
USE TransControl;


-- TABELA 1 (EMPRESA)

CREATE TABLE Empresa (
idEmpresa int primary key auto_increment,
razaoSocial varchar(255) NOT NULL,
nomeFantasia varchar(255),
email varchar(40) NOT NULL,
logradouro varchar(150) NOT NULL,
CNPJ char(14) unique NOT NULL,
telefone char(14) NOT NULL,
senha varchar(20) NOT NULL,
chaveUnica int unique not null
);

-- Inserção de dados na tabela Empresa
INSERT INTO Empresa VALUES
    (default, 'Empresa Metropolitana de Transportes Urbanos de São Paulo', 'EMTU', 'imprensa@emtu.sp.gov.br', 'R. Boa Vista, 150 - Centro Histórico de São Paulo, São Paulo', 58518069000191, 08007240555, 12345678, 123),
    (default, 'BB Transporte e Turismo', 'BBTT', 'turismo@benficabbtt.com.br', 'Avenida Sargento Jose Siqueira, 427 - Jardim Paraiso, Barueri - SP', '48748230000160', 41992730, 12345678, 321),
    (default, 'Viacao Osasco Ltda', 'Viacao Osasco', 'viacao@osaco.com.br', 'Av. Valter Boveri, 501A CEP: 06053-120 Jardim Novo Osasco - SP', 45645462000366, 35924261, 12345678, 456);

DESCRIBE Empresa;
SELECT * FROM Empresa;

-- TABELA 2 (FUNCIONARIO)

create table funcionario(
idFuncionario int primary key auto_increment,
nome varchar (45) not null,
email varchar(45) unique not null,
senha varchar(20) not null,
fkEmpresa int,
constraint fkEmpresaFunc foreign key (fkEmpresa) references Empresa(chaveUnica)
);

insert into funcionario values
(default, 'Luiz André Martins', 'luizandre@gmail.com', '989210', 123),
(default, 'luana Maria Moraes', 'luanamoraes@gmail.com', 'laranja123', 321),
(default, 'José Mario da Silva', 'josémario@gmail.com', '251922', 456);

DESCRIBE funcionario;
SELECT * FROM funcionario;

select * from Empresa join funcionario on fkEmpresa = chaveUnica;



-- TABELA 3 (LINHA ONIBUS)

create table linhaOnibus(
idLinha int primary key auto_increment,
nome varchar (45),
destinoInicial varchar (45),
destinoFinal varchar (45)
);	

insert into linhaOnibus values
(default, 'B19', 'Bairro Campestre', 'Terminal Santo André'),
(default, 'I02', 'Centreville', 'Terminal Ana Maria');

DESCRIBE linhaOnibus;
SELECT * FROM linhaOnibus;

CREATE TABLE ModeloOnibus(
	idOnibus int primary key auto_increment NOT NULL,
	qtdPortas int NOT NULL,
    capacidade int NOT NULL,
	placa char(7),
	peso int, -- Em KG
    fkLinha int,
    constraint fklinhaOnibus foreign key (fkLinha) references linhaOnibus(idLinha),
    CONSTRAINT chkPortas CHECK(qtdPortas >= 2 AND qtdPortas <= 8)
);

insert into ModeloOnibus values
(default, 3, 60, 'BD64SB7', '300', '1' ),

create table linhaOnibus(
idLinha int primary key auto_increment,
nome varchar (45),
destinoInicial varchar (45),
destinoFinal varchar (45)
);	

-- Inserção de dados na tabela ModeloOnibus
INSERT INTO ModeloOnibus VALUES
    (default, 3, 120, 'JPV8440', 26000), -- Onibus Articulado
    (default, 3, 20, 'BRA5679', 4000), -- Micro-Onibus
    (default, 3, 70, 'JTW9010', 16000); -- Onibus convencional

DESCRIBE ModeloOnibus;
SELECT * FROM ModeloOnibus;

-- TABELA 3 (SENSORES)

CREATE TABLE Sensor(
	idSensor int primary key auto_increment,
	portaSensor varchar(7) NOT NULL,
    fkModeloOnibus int,
     CONSTRAINT chkPorta CHECK(portaSensor = 'SAIDA' OR portaSensor = 'ENTRADA'),
     CONSTRAINT fkModeloOnibus foreign key (fkModeloOnibus) references ModeloOnibus(idOnibus)
);

-- Inserção de dados na tabela sensor
INSERT INTO Sensor VALUES
    (default, 'ENTRADA',1),
    (default, 'SAIDA',1),
    (default, 'SAIDA',1);
    
select * from ModeloOnibus join Sensor
	on idOnibus = fkModeloOnibus;

DESCRIBE sensor;
SELECT * FROM Sensor;



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