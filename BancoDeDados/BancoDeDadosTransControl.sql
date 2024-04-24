CREATE DATABASE TransControl;
USE TransControl;


-- TABELA 1 (LINHA DO ONIBUS)

CREATE TABLE linhaOnibus(
idLinha int primary key auto_increment,
nome varchar (45),
destinoInicial varchar (45),
destinoFinal varchar (45)
);	

insert into linhaOnibus values
(default, 'B19', 'Bairro Campestre', 'Terminal Santo André'),
(default, 'I02', 'Centreville', 'Terminal Ana Maria'),
(default, '285', 'Terminal Santo André', 'Terminal Sao Mateus');

DESCRIBE linhaOnibus;
SELECT * FROM linhaOnibus;

-- TABELA 2 ( endereço )

CREATE TABLE endereco (
idEndereco int primary key auto_increment,
cep char (9),
logradouro varchar (60),
bairro varchar(45),
numero varchar (12)
);

insert into endereco values
(default, '05220-431', 'Vitoria Regia', 'Consolação', '980'),
(default, '04427-433', 'Alagoas', 'Brigadeiro', '1423');

DESCRIBE endereco;
SELECT * FROM endereco;

-- TABELA 3 (Empresa)

CREATE TABLE Empresa (
idEmpresa int primary key auto_increment,
razaoSocial varchar(255) NOT NULL,
nomeFantasia varchar(255),
email varchar(40) NOT NULL,
CNPJ char(14) unique NOT NULL,
telefone char(14) NOT NULL,
senha varchar(20) NOT NULL,
fkEnderecoEmpresa int,
CONSTRAINT fkEnderecoEmpresa foreign key (fkEnderecoEmpresa) references endereco(idEndereco)
);

INSERT INTO Empresa VALUES
    (default, 'Empresa Metropolitana de Transportes Urbanos de São Paulo', 'EMTU', 'imprensa@emtu.sp.gov.br', '58518069000191', '08007240555', '12345678', 1),
    (default, 'BB Transporte e Turismo', 'BBTT', 'turismo@benficabbtt.com.br', '48748230000160', '41992730', '12345678', 2),
    (default, 'Viacao Osasco Ltda', 'Viacao Osasco', 'viacao@osaco.com.br', '45645462000366', '35924261', '12345678', 1);

DESCRIBE Empresa;
SELECT * FROM Empresa;

-- TABELA 4 (FUNCIONARIO)

create table funcionario(
idFuncionario int primary key auto_increment,
nome varchar (45) not null,
email varchar(45) unique not null,
senha varchar(20) not null,
fkEmpresa int,
CONSTRAINT fkEmpresa foreign key (fkEmpresa) references Empresa(idEmpresa)
);

insert into funcionario values
(default, 'Luiz André Martins', 'luizandre@gmail.com', '989210', 13),
(default, 'luana Maria Moraes', 'luanamoraes@gmail.com', 'laranja123', 14),
(default, 'José Mario da Silva', 'josémario@gmail.com', '251922', 15);

DESCRIBE funcionario;
SELECT * FROM funcionario;

-- TABELA 5 (ONIBUS)

CREATE TABLE Onibus(
	idOnibus int primary key auto_increment NOT NULL,
	qtdPortas int NOT NULL,
    CONSTRAINT chkPortas CHECK(qtdPortas >= 2 AND qtdPortas <= 8),
    capacidade int NOT NULL,
    modeloOnibus varchar (45),
	placa char(7),
	peso int, -- Em KG
    fkLinha int,
    CONSTRAINT fklinha foreign key (fkLinha) references linhaOnibus(idLinha)
);

INSERT INTO Onibus VALUES
    (default, 3, 120, 'Onibus Articulado ','JPV8440', 26000, 1 ),
    (default, 2, 20, 'Micro-Onibus' ,'BRA5679', 4000, 2), 
    (default, 3, 70, 'Onibus convencional','JTW9010', 16000, 3); 
    
DESCRIBE Onibus;
SELECT * FROM Onibus;

-- TABELA 6 (HISTORICO)

create table historico (
idHistorico int primary key auto_increment,
dtHora datetime, 
linhaDestino varchar (45),
fkOnibusHistorico int,
CONSTRAINT fkOnibusHistorico foreign key (fkOnibusHistorico) references Onibus (idOnibus)
);

insert into historico values
(default, '2024-03-24 18:02:45', 'B19', 1),
(default, '2024-03-24 07:30:09', 'I02', 2),
(default, '2024-03-24 12:40:57', '285', 3);

DESCRIBE historico;
SELECT * FROM historico;

-- TABELA 7 (ALERTA)

create table Alerta (
idAlerta int primary key auto_increment,
dtHora datetime,
tipo varchar (50),
CONSTRAINT chktipo CHECK(tipo in("Vazio", "Lotação")),
lotacao int,
fkOnibusAlerta int,
CONSTRAINT fkOnibusAlerta foreign key (fkOnibusAlerta) references Onibus(idOnibus)
);

insert into Alerta values
(default, '2024-03-24 18:02:45', 'Vazio' ,102, 1),
(default, '2024-03-24 07:30:09', 'Lotação', 511,2),
(default, '2024-03-24 12:40:57', 'Lotação',654, 3);

DESCRIBE Alerta;
SELECT * FROM Alerta;

-- TABELA 8 (8)

CREATE TABLE Sensor(
	idSensor int primary key auto_increment,
	portaSensor varchar(7) NOT NULL,
    CONSTRAINT chkPorta CHECK(portaSensor = 'SAIDA' OR portaSensor = 'ENTRADA'),
    fkOnibusSensor int,
	CONSTRAINT fkOnibusSensor foreign key (fkOnibusSensor) references Onibus(idOnibus)
);

INSERT INTO Sensor VALUES
    (default, 'ENTRADA',1),
    (default, 'SAIDA',2),
    (default, 'SAIDA',3);
    

DESCRIBE Sensor;
SELECT * FROM Sensor;

-- TABELA 9 (DADOS)

CREATE TABLE dados(
	idDado int primary key auto_increment,
    ativacao tinyint,
	horarioAtivacao datetime DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chkDado CHECK(ativacao = 0 OR ativacao = 1),
    fkSensor int,
    CONSTRAINT fkSensor foreign key (fkSensor) references Sensor(idSensor)
    );

INSERT INTO dados VALUES
    (default, 1, default,1),
    (default, 0, default,2),
    (default, 1, default,3);

DESCRIBE dados;
SELECT * FROM dados;

-- RELACIONAMENTO DAS TABELAS 

