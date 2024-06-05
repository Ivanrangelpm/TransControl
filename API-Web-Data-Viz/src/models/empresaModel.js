var database = require("../database/config");

function buscarPorId(id) {
  var instrucaoSql = `SELECT * FROM Empresa WHERE idEmpresa = '${id}'`;

  return database.executar(instrucaoSql);
}

function buscarPorRazaoSocial(razaoSocial) {
  var instrucaoSql = `SELECT * FROM Empresa WHERE razaoSocial = '${razaoSocial}'`;

  return database.executar(instrucaoSql);
}

function listar() {
  var instrucaoSql = `SELECT * FROM Empresa`;

  return database.executar(instrucaoSql);
}

function buscarPorCnpj(cnpj) {
  var instrucaoSql = `SELECT * FROM Empresa WHERE cnpj = '${cnpj}'`;

  return database.executar(instrucaoSql);
}

function cadastrar(razaoSocial, cnpj) {
  var instrucaoSql = `INSERT INTO Empresa (razao_social, cnpj) VALUES ('${razaoSocial}', '${cnpj}')`;

  return database.executar(instrucaoSql);
}

module.exports = { buscarPorCnpj, buscarPorRazaoSocial, buscarPorId, cadastrar, listar };