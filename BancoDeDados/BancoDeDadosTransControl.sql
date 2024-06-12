DROP DATABASE IF exists TransControl;
CREATE DATABASE TransControl;

USE TransControl;
-- TABELA 1 (LINHA DO ONIBUS)

CREATE TABLE linhaOnibus(
idLinha int primary key auto_increment,
nome varchar (45),
destinoInicial varchar (45),
destinoFinal varchar (45)
) auto_increment = 1;	

insert into linhaOnibus values
(default, '100', 'Bairro Campestre', 'Terminal Santo André'),
(default, '200', 'Centreville', 'Terminal Ana Maria'),
(default, '300', 'Terminal Santo André', 'Terminal Sao Mateus');

insert into linhaOnibus values
(default, '400', 'Bairro Pampa', 'Terminal Pampa');

DESCRIBE linhaOnibus;
SELECT * FROM linhaOnibus;

-- TABELA 2 ( endereço )

CREATE TABLE endereco (
idEndereco int primary key auto_increment,
cep char (9),
logradouro varchar (60),
bairro varchar(45),
numero varchar (12)
) auto_increment = 20;

insert into endereco values
(default, '05220-431', 'Vitoria Regia', 'Consolação', '980'),
(default, '04427-433', 'Alagoas', 'Brigadeiro', '1423'),
(default, '09743-546', 'Mena', 'Picanço', '624' );

DESCRIBE endereco;
SELECT * FROM endereco;

-- TABELA 3 (Empresa)

CREATE TABLE Empresa (
idEmpresa int primary key,
razaoSocial varchar(255) NOT NULL,
nomeFantasia varchar(255),
email varchar(40) NOT NULL,
cnpj char(14) unique NOT NULL,
telefone char(14) NOT NULL,
senha varchar(20) NOT NULL,
fkEnderecoEmpresa int,
CONSTRAINT fkEnderecoEmpresa foreign key (fkEnderecoEmpresa) references endereco(idEndereco)
) ;

INSERT INTO Empresa VALUES
    (1, 'Empresa Metropolitana de Transportes Urbanos de São Paulo', 'EMTU', 'imprensa@emtu.sp.gov.br', '58518069000191', '08007240555', '12345678', 20),
    (2, 'BB Transporte e Turismo', 'BBTT', 'turismo@benficabbtt.com.br', '48748230000160', '41992730', '12345678', 21),
    (3, 'Viacao Osasco Ltda', 'Viacao Osasco', 'viacao@osaco.com.br', '45645462000366', '35924261', '12345678', 22);

DESCRIBE Empresa;
SELECT * FROM Empresa;


-- TABELA 4 (FUNCIONARIO)

create table usuario(
id int primary key auto_increment,
nome varchar (45) not null,
email varchar(45) unique not null,
senha varchar(20) not null,
fkEmpresa int,
CONSTRAINT fkEmpresa foreign key (fkEmpresa) references Empresa(idEmpresa)
) auto_increment= 40;

SELECT * FROM usuario;

-- TABELA 5 (ONIBUS)

CREATE TABLE Onibus(
	idOnibus int primary key auto_increment NOT NULL,
    capacidade int NOT NULL,
    modeloOnibus varchar (45),
	placa char(7),
	peso int, -- Em KG
    fkLinha int,
    fkEmpresaOnibus int,
    CONSTRAINT fkLinha foreign key (fkLinha) references linhaOnibus(idLinha),
    CONSTRAINT fkEmpresaOnibus foreign key (fkEmpresaOnibus) references Empresa(idEmpresa)
) auto_increment = 50;

INSERT INTO Onibus VALUES
    (default, 120, 'Onibus Articulado ','JPV8440', 26000, 1, 1 ),
    (default, 20, 'Micro-Onibus' ,'BRA5679', 4000, 2, 1), 
    (default, 70, 'Onibus convencional','JTW9010', 16000, 3, 1); 

insert into Onibus values
(default, 220, 'Teste' ,'BRA5699', 1000, 4, 1);

insert into Onibus values
(default, 320, 'TEste' ,'BRA5699', 1020, 4, 2);
    
DESCRIBE Onibus;
SELECT * FROM Onibus;

-- TABELA 6 (HISTORICO)

create table historico (
idHistorico int primary key auto_increment,
dtHora datetime, 
linhaDestino varchar (45),
fkOnibusHistorico int,
CONSTRAINT fkOnibusHistorico foreign key (fkOnibusHistorico) references Onibus (idOnibus)
) auto_increment= 60;

insert into historico values
(default, '2024-03-24 18:02:45', 'B19', 50),
(default, '2024-03-24 07:30:09', 'I02', 51),
(default, '2024-03-24 12:40:57', '285', 52);

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
)auto_increment= 70;

insert into Alerta values
(default, '2024-03-24 18:02:45', 'Vazio' ,102, 52),
(default, '2024-03-24 07:30:09', 'Lotação', 511,51),
(default, '2024-03-24 12:40:57', 'Lotação',654, 50);

DESCRIBE Alerta;
SELECT * FROM Alerta;

-- TABELA 8 (SENSOR)

CREATE TABLE Sensor(
	idSensor int primary key auto_increment,
    fkOnibusSensor int,
	CONSTRAINT fkOnibusSensor foreign key (fkOnibusSensor) references Onibus(idOnibus)
) auto_increment= 80;

INSERT INTO Sensor VALUES
	(default, 50),
    (default, 51),
    (default, 52);
    
DESCRIBE Sensor;
SELECT * FROM Sensor;

-- TABELA 9 (DADOS)

CREATE TABLE dados(
	idDado int primary key auto_increment,
    ativacao int,
	horarioAtivacao datetime DEFAULT CURRENT_TIMESTAMP,
    fkSensor int,
    CONSTRAINT fkSensor foreign key (fkSensor) references Sensor (idSensor)
    ) auto_increment = 90;
    
    
insert into dados values
	(default, round(rand() * 1000, 0) ,'2024-06-09 00:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-09 01:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-09 02:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-09 03:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-09 04:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-09 05:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-09 06:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-09 07:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-09 08:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-09 09:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-09 10:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-09 11:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-09 12:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-09 13:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-09 14:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-09 15:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-09 16:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-09 17:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-09 18:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-09 19:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-09 20:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-09 21:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-09 22:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-09 23:00:00', 80);
    
insert into dados values
	(default, round(rand() * 1000, 0),'2024-06-10 01:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-10 02:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-10 03:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-10 04:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-10 05:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-10 06:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-10 07:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-10 08:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-10 09:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-10 10:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-10 11:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-10 12:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-10 13:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-10 14:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-10 15:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-10 16:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-10 17:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-10 18:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-10 19:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-10 20:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-10 21:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-10 22:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-10 23:00:00', 80);

insert into dados values
	(default, round(rand() * 1000, 0),'2024-06-11 01:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-11 02:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-11 03:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-11 04:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-11 05:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-11 06:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-11 07:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-11 08:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-11 09:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-11 10:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-11 11:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-11 12:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-11 13:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-11 14:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-11 15:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-11 16:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-11 17:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-11 18:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-11 19:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-11 20:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-11 21:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-11 22:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-11 23:00:00', 80);



insert into dados values
	(default, round(rand() * 1000, 0),'2024-06-12 01:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-12 02:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-12 03:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-12 04:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-12 05:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-12 06:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-12 07:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-12 08:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-12 09:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-12 10:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-12 11:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-12 12:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-12 13:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-12 14:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-12 15:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-12 16:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-12 17:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-12 18:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-12 19:00:00', 80),
	(default, round(rand() * 1000, 0) ,'2024-06-12 20:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-12 21:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-12 22:00:00', 80),
	(default, round(rand() * 1000, 0),'2024-06-12 23:00:00', 80);
    
insert into dados values
	(default, round(rand() * 1000, 0) ,'2024-06-09 00:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 01:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 02:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 03:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 04:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 05:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 06:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 07:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 08:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 09:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 10:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 11:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 12:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 13:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 14:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 15:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 16:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 17:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 18:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 19:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 20:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 21:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 22:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 23:00:00', 81);

insert into dados values
	(default, round(rand() * 1000, 0) ,'2024-06-10 01:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 02:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 03:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 04:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 05:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 06:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 07:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 08:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 09:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 10:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 11:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 12:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 13:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 14:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 15:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 16:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 17:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 18:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 19:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 20:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 21:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 22:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 23:00:00', 81);
    
insert into dados values
	(default, round(rand() * 1000, 0) ,'2024-06-11 01:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 02:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 03:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 04:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 05:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 06:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 07:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 08:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 09:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 10:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 11:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 12:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 13:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 14:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 15:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 16:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 17:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 18:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 19:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 20:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 21:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 22:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 23:00:00', 81);

select * from dados where fkSensor = 81;

-- Repita a estrutura abaixo para cada dia
insert into dados values
	(default, round(rand() * 1000, 0) ,'2024-06-12 01:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 02:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 03:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 04:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 05:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 06:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 07:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 08:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 09:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 10:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 11:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 12:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 13:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 14:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 15:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 16:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 17:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 18:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 19:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 20:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 21:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 22:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 23:00:00', 81);


insert into dados values
	(default, round(rand() * 1000, 0) ,'2024-06-09 00:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 01:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 02:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 03:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 04:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 05:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 06:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 07:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 08:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 09:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 10:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 11:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 12:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 13:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 14:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 15:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 16:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 17:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 18:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 19:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 20:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 21:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 22:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-09 23:00:00', 81);

insert into dados values
	(default, round(rand() * 1000, 0) ,'2024-06-10 01:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 02:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 03:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 04:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 05:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 06:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 07:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 08:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 09:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 10:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 11:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 12:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 13:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 14:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 15:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 16:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 17:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 18:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 19:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 20:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 21:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 22:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-10 23:00:00', 81);
    
insert into dados values
	(default, round(rand() * 1000, 0) ,'2024-06-11 01:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 02:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 03:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 04:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 05:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 06:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 07:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 08:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 09:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 10:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 11:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 12:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 13:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 14:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 15:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 16:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 17:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 18:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 19:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 20:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 21:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 22:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-11 23:00:00', 81);

select * from dados where fkSensor = 81;

-- Repita a estrutura abaixo para cada dia
insert into dados values
	(default, round(rand() * 1000, 0) ,'2024-06-12 01:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 02:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 03:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 04:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 05:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 06:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 07:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 08:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 09:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 10:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 11:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 12:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 13:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 14:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 15:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 16:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 17:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 18:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 19:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 20:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 21:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 22:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-12 23:00:00', 81);

insert into dados values
	(default, round(rand() * 1000, 0) ,'2024-06-09 00:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 01:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 02:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 03:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 04:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 05:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 06:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 07:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 08:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 09:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 10:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 11:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 12:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 13:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 14:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 15:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 16:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 17:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 18:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 19:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 20:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 21:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 22:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-09 23:00:00', 82);

insert into dados values
	(default, round(rand() * 1000, 0) ,'2024-06-10 01:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 02:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 03:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 04:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 05:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 06:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 07:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 08:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 09:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 10:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 11:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 12:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 13:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 14:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 15:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 16:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 17:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 18:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 19:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 20:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 21:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 22:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-10 23:00:00', 82);
    
insert into dados values
	(default, round(rand() * 1000, 0) ,'2024-06-11 01:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 02:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 03:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 04:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 05:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 06:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 07:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 08:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 09:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 10:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 11:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 12:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 13:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 14:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 15:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 16:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 17:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 18:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 19:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 20:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 21:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 22:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-11 23:00:00', 82);

-- Repita a estrutura abaixo para cada dia
insert into dados values
	(default, round(rand() * 1000, 0) ,'2024-06-12 01:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 02:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 03:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 04:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 05:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 06:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 07:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 08:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 09:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 10:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 11:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 12:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 13:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 14:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 15:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 16:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 17:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 18:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 19:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 20:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 21:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 22:00:00', 82),
	(default, round(rand() * 1000, 0) ,'2024-06-12 23:00:00', 82);


insert into dados values
	(default, round(rand() * 10000), '2024-01-30', 81),
	(default, round(rand() * 10000), '2024-02-28', 81),
	(default, round(rand() * 10000), '2024-03-30', 81),
	(default, round(rand() * 10000), '2024-04-30', 81),
	(default, round(rand() * 10000), '2024-05-30', 81);
    
insert into dados values
	(default, round(rand() * 10000), '2024-01-30', 80),
	(default, round(rand() * 10000), '2024-02-28', 80),
	(default, round(rand() * 10000), '2024-03-30', 80),
	(default, round(rand() * 10000), '2024-04-30', 80),
	(default, round(rand() * 10000), '2024-05-30', 80);

insert into dados values
	(default, round(rand() * 10000), '2024-01-30', 82),
	(default, round(rand() * 10000), '2024-02-28', 82),
	(default, round(rand() * 10000), '2024-03-30', 82),
	(default, round(rand() * 10000), '2024-04-30', 82),
	(default, round(rand() * 10000), '2024-05-30', 82);



-- RELACIONAMENTO DAS TABELAS 

-- ONIBUS, LINHAS E EMPRESA 

SELECT * FROM linhaOnibus as Linha join Onibus as onibus on onibus.fkLinha = Linha.idLinha;

SELECT linhaOnibus.nome as Linha , Onibus.modeloOnibus from linhaOnibus
join Onibus on Onibus.fkLinha = linhaOnibus.idLinha;

SELECT linhaOnibus.nome as Linha , Onibus.modeloOnibus as Onibus, Empresa.NomeFantasia as Empresa from linhaOnibus
join Onibus on Onibus.fkLinha = linhaOnibus.idLinha
join Empresa on Empresa.idEmpresa = Onibus.fkEmpresaOnibus;


-- EMPRESA E ENDEREÇO

SELECT * FROM Empresa join endereco on Empresa.fkEnderecoEmpresa = endereco.idEndereco;

SELECT Empresa.NomeFantasia as NomeEmpresa , endereco.* from Empresa 
join endereco on endereco.idEndereco = Empresa.fkEnderecoEmpresa;

-- ONIBUS E HISTORICO (LINHA)

SELECT * FROM Onibus join historico on historico.fkOnibusHistorico = Onibus.idOnibus;

SELECT Onibus.modeloOnibus as Modelo, historico.* from Onibus 
join historico on historico.fkOnibusHistorico = Onibus.idOnibus;

SELECT Onibus.modeloOnibus as Modelo, historico.* , linhaOnibus.nome as Linha from Onibus 
join historico on historico.fkOnibusHistorico = Onibus.idOnibus
join linhaOnibus on Onibus.fkLinha = linhaOnibus.idLinha;

-- ONIBUS E ALERTA (LINHA)

SELECT * FROM Onibus join Alerta on Alerta.fkOnibusAlerta = Onibus.idOnibus;

SELECT Onibus.modeloOnibus as Modelo, Alerta.* from Onibus 
join Alerta on Alerta.fkOnibusAlerta = Onibus.idOnibus;

SELECT Onibus.modeloOnibus as Modelo, Alerta.*, linhaOnibus.nome as Linha from Onibus 
join Alerta on Alerta.fkOnibusAlerta = Onibus.idOnibus
join linhaOnibus on Onibus.fkLinha = linhaOnibus.idLinha;

--  ONIBUS E SENSOR (LINHA)

SELECT * FROM Onibus join Sensor on Sensor.fkOnibusSensor = Onibus.idOnibus;

SELECT Onibus.modeloOnibus as Modelo, Sensor.* from Onibus 
join Sensor on Sensor.fkOnibusSensor = Onibus.idOnibus;

SELECT Onibus.modeloOnibus as Modelo, Sensor.*, linhaOnibus.nome as Linha, dados.* from Onibus 
join Sensor on Sensor.fkOnibusSensor = Onibus.idOnibus
join linhaOnibus on Onibus.fkLinha = linhaOnibus.idLinha
join dados on Sensor.idSensor= dados.fkSensor;
  
    select
	s.idSensor,
    o.idOnibus,
    e.idEmpresa,
    l.nome,
    hour(d.horarioAtivacao) as Hora,
    count(*) as Total_Pessoas
from
    dados as d
    join Sensor as s on d.fkSensor = s.idSensor
    join Onibus as o on s.fkOnibusSensor = o.idOnibus 
    join Empresa as e on o.fkEmpresaOnibus = e.idEmpresa
    join linhaOnibus as l on o.fkLinha = l.idLinha
where
    o.idOnibus = 50
    and date(d.horarioAtivacao) = '2024-06-13'
group by
    hour(d.horarioAtivacao),s.idSensor, o.idOnibus, e.idEmpresa, l.nome; 
    

select
	s.idSensor,
    o.idOnibus,
    e.idEmpresa,
    l.nome,
    hour(d.horarioAtivacao) as Hora,
    count(*) as Total_Pessoas
from
    dados as d
    join Sensor as s on d.fkSensor = s.idSensor
    join Onibus as o on s.fkOnibusSensor = o.idOnibus 
    join Empresa as e on o.fkEmpresaOnibus = e.idEmpresa
    join linhaOnibus as l on o.fkLinha = l.idLinha
where
    o.idOnibus = 52
    and date(d.horarioAtivacao) = curdate()
group by
    hour(d.horarioAtivacao),s.idSensor, o.idOnibus, e.idEmpresa, l.nome; 
    
select * from linhaOnibus;

select
	s.idSensor,
    o.idOnibus,
    e.idEmpresa,
    l.nome,
    dayname(d.horarioAtivacao) as Dia_Semana,
    count(*) as Total_Pessoas
from
    dados as d
	join Sensor as s on d.fkSensor = s.idSensor
    join Onibus as o on s.fkOnibusSensor = o.idOnibus 
    join Empresa as e on o.fkEmpresaOnibus = e.idEmpresa
    join linhaOnibus as l on o.fkLinha = l.idLinha
where
    o.idOnibus = 52
    and week(d.horarioAtivacao) = week(curdate())
group by
    dayname(d.horarioAtivacao), s.idSensor, o.idOnibus, e.idEmpresa, l.nome;
    
     SELECT
            s.idSensor,
            o.idOnibus,
            e.idEmpresa,
            l.nome,
            FLOOR((DAYOFMONTH(d.horarioAtivacao)-1)/7)+1 AS Semana_Do_Mes,
            COUNT(*) AS Total_Pessoas
        FROM
            dados AS d
            JOIN Sensor AS s ON d.fkSensor = s.idSensor
            JOIN Onibus AS o ON s.fkOnibusSensor = o.idOnibus
            JOIN Empresa AS e ON o.fkEmpresaOnibus = e.idEmpresa
            JOIN linhaOnibus AS l ON o.fkLinha = l.idLinha
        WHERE
            e.idEmpresa = 1
            AND l.idLinha = 1
            AND MONTH(d.horarioAtivacao) = MONTH(CURDATE())
        GROUP BY
            FLOOR((DAYOFMONTH(d.horarioAtivacao)-1)/7)+1 , s.idSensor, o.idOnibus, e.idEmpresa, l.nome
        ORDER BY
            Semana_Do_Mes;
            
select * from Empresa;
select * from linhaOnibus;
select * from Onibus;
select * from sensor;

 SELECT
            s.idSensor,
            o.idOnibus,
            e.idEmpresa,
            l.nome,
            MONTHNAME(d.horarioAtivacao) AS Mes_Ano,
            COUNT(*) AS Total_Pessoas
        FROM
            dados AS d
            JOIN Sensor AS s ON d.fkSensor = s.idSensor
            JOIN Onibus AS o ON s.fkOnibusSensor = o.idOnibus 
            JOIN Empresa AS e ON o.fkEmpresaOnibus = e.idEmpresa
            JOIN linhaOnibus AS l ON o.fkLinha = l.idLinha
        WHERE
			o.idOnibus = 50
        GROUP BY
            s.idSensor, o.idOnibus, e.idEmpresa, l.nome, MONTH(d.horarioAtivacao), MONTHNAME(d.horarioAtivacao)
        ORDER BY 
            MONTH(d.horarioAtivacao);

    
SELECT sum(ativacao),fkSensor from dados group by fkSensor;

SELECT s.idSensor, s.portaSensor, sum(d.ativacao) as ativacao from Sensor as s, dados as d 
group by s.idSensor, s.portaSensor;


insert into dados values
	(default, round(rand() * 1000, 0) ,'2024-06-15 01:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 02:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 03:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 04:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 05:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 06:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 07:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 08:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 09:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 10:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 11:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 12:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 13:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 14:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 15:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 16:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 17:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 18:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 19:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 20:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 21:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 22:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-15 23:00:00', 81);

	insert into dados values
	(default, round(rand() * 1000, 0) ,'2024-06-22 01:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 02:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 03:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 04:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 05:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 06:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 07:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 08:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 09:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 10:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 11:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 12:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 13:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 14:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 15:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 16:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 17:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 18:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 19:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 20:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 21:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 22:00:00', 81),
	(default, round(rand() * 1000, 0) ,'2024-06-22 23:00:00', 81);