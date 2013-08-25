----------------------tipos----------------------------------

DROP TYPE tp_pessoa FORCE;
DROP TYPE tp_endereco FORCE;
DROP TYPE tp_paciente FORCE;
DROP TYPE tp_medico FORCE;
DROP TYPE tp_acompanhante FORCE;
DROP TYPE tp_servidor_geral FORCE;
DROP TYPE tp_ficha_clinica FORCE;
DROP TYPE tp_ficha_atendimento FORCE;
DROP TYPE tp_enfermaria FORCE;
DROP TYPE tp_consulta FORCE;
DROP TYPE va_telefone FORCE;
DROP TYPE tp_nt_acompanhante FORCE;

CREATE OR REPLACE TYPE va_telefone AS VARRAY(5) OF VARCHAR2(10);
/ 

CREATE OR REPLACE TYPE tp_endereco AS OBJECT
(
    logradouro VARCHAR2(50),
    bairro VARCHAR2(20),
	numero NUMBER,
    complemento VARCHAR2(10), 
	uf VARCHAR2(2)
);
/ 

CREATE OR REPLACE TYPE tp_pessoa AS OBJECT(
	cpf VARCHAR2(11),
    nome VARCHAR2(50),
	data_nascimento DATE,
	sexo CHAR,
    endereco tp_endereco, 
    telefones va_telefone
) NOT FINAL NOT INSTANTIABLE;
/ 

CREATE OR REPLACE TYPE tp_acompanhante UNDER tp_pessoa
(
   vinculo_afetivo VARCHAR2(20)
);
/ 

CREATE OR REPLACE TYPE tp_nt_acompanhante AS TABLE OF tp_acompanhante;
/

CREATE OR REPLACE TYPE tp_paciente UNDER tp_pessoa
(  
lista_acompanhates tp_nt_acompanhante
);
/ 

CREATE OR REPLACE TYPE tp_medico UNDER tp_pessoa
(
	crm VARCHAR2(12),
	ativo VARCHAR(1),
	supervisor REF tp_medico,
	foto BLOB
);
/ 

CREATE OR REPLACE TYPE tp_servidor_geral UNDER tp_pessoa
(
   matricula VARCHAR2(12),
   ativo VARCHAR2(1)
);
/ 


CREATE OR REPLACE TYPE tp_ficha_clinica AS OBJECT
(
   id_ficha_clinica NUMBER,
   grau NUMBER,
   status VARCHAR(1) 
);
/ 

CREATE OR REPLACE TYPE tp_ficha_atendimento AS OBJECT
(
	data_hora_entrada DATE,
	servidor REF tp_servidor_geral,
	paciente REF tp_paciente,
	id_ficha_clinica REF tp_ficha_clinica
);
/ 

CREATE OR REPLACE TYPE tp_enfermaria AS OBJECT
(
	id_enfermaria NUMBER,
	qtd_leitos NUMBER,
	leitos_ocupados NUMBER
);
/ 

CREATE OR REPLACE TYPE tp_consulta AS OBJECT
(
	data_entrada DATE,
	data_alta DATE,
	previsao_alta DATE,
	diagnostico VARCHAR2(150),
	paciente REF tp_paciente,
	medico REF tp_medico,
	enfermaria REF tp_enfermaria
);
/ 

----------------------tabelas----------------------------------

DROP TABLE tb_paciente CASCADE CONSTRAINTS;
DROP TABLE tb_medico CASCADE CONSTRAINTS;
DROP TABLE tb_acompanhante CASCADE CONSTRAINTS;
DROP TABLE tb_servidor_geral CASCADE CONSTRAINTS;
DROP TABLE tb_ficha_clinica CASCADE CONSTRAINTS;
DROP TABLE tb_ficha_atendimento CASCADE CONSTRAINTS;
DROP TABLE tb_enfermaria CASCADE CONSTRAINTS;
DROP TABLE tb_consulta CASCADE CONSTRAINTS;
DROP TABLE tb_gera_ficha CASCADE CONSTRAINTS;

CREATE TABLE tb_paciente OF tp_paciente
(
    cpf PRIMARY KEY
)NESTED TABLE lista_acompanhantes STORE AS tp_nt_acompanhante; 

CREATE TABLE tb_medico OF tp_medico
(
    crm PRIMARY KEY,
	supervisor WITH ROWID REFERENCES tb_medico 
);

CREATE TABLE tb_servidor_geral OF tp_servidor_geral
(
    matricula PRIMARY KEY
);

CREATE TABLE tb_ficha_clinica OF tp_ficha_clinica
(
    id_ficha_clinica PRIMARY KEY
);


CREATE TABLE tb_ficha_atendimento OF tp_ficha_atendimento
(
	data_hora_entrada PRIMARY KEY,
	paciente WITH ROWID REFERENCES tb_paciente,
	id_ficha_clinica WITH ROWID REFERENCES tb_ficha_clinica,
	servidor WITH ROWID REFERENCES tb_servidor_geral
);

CREATE TABLE tb_enfermaria OF tp_enfermaria
(
	id_enfermaria PRIMARY KEY
);

CREATE TABLE tb_consulta OF tp_consulta
(
	data_entrada PRIMARY KEY,
	paciente WITH ROWID REFERENCES tb_paciente,
	medico WITH ROWID REFERENCES tb_medico,
	enfermaria WITH ROWID REFERENCES tb_enfermaria
);