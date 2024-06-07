const medidaModel = require("../models/medidaModel");

function listarLinhas(req, res) {
    const idEmpresa = req.params.idEmpresa;
    medidaModel.listarLinhas(idEmpresa)
        .then(resultado => res.status(200).json(resultado))
        .catch(erro => {
            console.log("Houve um erro ao listar as linhas.", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

function getFluxo(req, res) {
    const idEmpresa = req.params.idEmpresa;
    const idLinha = req.params.idLinha;
    medidaModel.getFluxo(idEmpresa, idLinha)
        .then(resultado => res.status(200).json(resultado))
        .catch(erro => {
            console.log("Houve um erro ao buscar o fluxo.", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    listarLinhas,
    getFluxo
};
