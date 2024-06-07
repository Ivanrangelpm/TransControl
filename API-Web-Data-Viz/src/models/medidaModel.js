const database = require("../database/config");

function listarLinhas(idEmpresa) {
    const query = `
        SELECT o.idOnibus, l.idLinha, l.nome
        FROM Onibus o
        JOIN linhaOnibus l ON o.fkLinha = l.idLinha
        WHERE o.fkEmpresaOnibus = ${idEmpresa}
    `;
    return database.executar(query);
}

function getFluxo(idEmpresa, idLinha) {
    const query = `
    SELECT
        e.idEmpresa,
        l.nome,
        s.idSensor,
        o.idOnibus,
        HOUR(d.horarioAtivacao) AS Hora,
        COUNT(*) AS Total_Pessoas
    FROM
        dados AS d
        JOIN Sensor AS s ON d.fkSensor = s.idSensor
        JOIN Onibus AS o ON s.fkOnibusSensor = o.idOnibus
        JOIN linhaOnibus AS l ON o.fkLinha = l.idLinha
        JOIN Empresa AS e ON o.fkEmpresaOnibus = e.idEmpresa
    WHERE
        e.idEmpresa = ${idEmpresa}
        AND l.idLinha = ${idLinha}
        AND DATE(d.horarioAtivacao) = CURDATE()
    GROUP BY
        s.idSensor, o.idOnibus, HOUR(d.horarioAtivacao);
    `;
    return database.executar(query);
}

module.exports = {
    listarLinhas,
    getFluxo
};
