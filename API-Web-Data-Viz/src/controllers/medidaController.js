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
    const periodo = req.params.periodo;

    let fluxoFunction;

    switch (periodo) {
        case 'hoje':
            fluxoFunction = medidaModel.getFluxoHoje;
            break;
        case 'dia_semana':
            fluxoFunction = medidaModel.getFluxoDiaSemana;
            break;
        case 'semana_mes':
            fluxoFunction = medidaModel.getFluxoSemanaMes;
            break;
        case 'mes_ano':
            fluxoFunction = medidaModel.getFluxoMesAno;
            break;
        default:
            res.status(400).json({ error: 'Período inválido' });
            return;
    }

    fluxoFunction(idEmpresa, idLinha)
        .then(resultado => res.status(200).json(resultado))
        .catch(erro => {
            console.log("Houve um erro ao buscar o fluxo.", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

function getMediaFluxo(req, res) {
    const idEmpresa = req.params.idEmpresa;
    const idLinha = req.params.idLinha;
    const periodo = req.params.periodo;

    let mediaFluxoFunction;

    switch (periodo) {
        case 'hoje':
            mediaFluxoFunction = medidaModel.getMediaFluxoHoje;
            break;
        case 'dia_semana':
            mediaFluxoFunction = medidaModel.getMediaFluxoDiaSemana;
            break;
        case 'semana_mes':
            mediaFluxoFunction = medidaModel.getMediaFluxoSemanaMes;
            break;
        case 'mes_ano':
            mediaFluxoFunction = medidaModel.getMediaFluxoMesAno;
            break;
        default:
            res.status(400).json({ error: 'Período inválido' });
            return;
    }

    mediaFluxoFunction(idEmpresa, idLinha)
        .then(resultado => res.status(200).json(resultado))
        .catch(erro => {
            console.log("Houve um erro ao buscar a média de fluxo.", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    listarLinhas,
    getFluxo,
    getMediaFluxo  
};
