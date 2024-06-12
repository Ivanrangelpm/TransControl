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

function getFluxoHoje(idEmpresa, idLinha) {
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
            AND DATE(d.horarioAtivacao) = '2024-06-13'
        GROUP BY
            s.idSensor, o.idOnibus, HOUR(d.horarioAtivacao);
    `;
    return database.executar(query);
}

function getFluxoDiaSemana(idEmpresa, idLinha) {
    const query = `
        SELECT
            DAYNAME(d.horarioAtivacao) AS Dia_Semana,
            COUNT(*) AS Total_Pessoas
        FROM
            dados AS d
            JOIN Sensor AS s ON d.fkSensor = s.idSensor
            JOIN Onibus AS o ON s.fkOnibusSensor = o.idOnibus 
            JOIN Empresa AS e ON o.fkEmpresaOnibus = e.idEmpresa
            JOIN linhaOnibus AS l ON o.fkLinha = l.idLinha
        WHERE
            e.idEmpresa = ${idEmpresa}
            AND l.idLinha = ${idLinha}
            and week(d.horarioAtivacao) = week(curdate())
        GROUP BY
            DAYNAME(d.horarioAtivacao);
    `;
    return database.executar(query);
}

function getFluxoSemanaMes(idEmpresa, idLinha) {
    const query = `
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
            e.idEmpresa = ${idEmpresa}
            AND l.idLinha = ${idLinha}
            AND MONTH(d.horarioAtivacao) = MONTH(CURDATE())
        GROUP BY
            FLOOR((DAYOFMONTH(d.horarioAtivacao)-1)/7)+1 , s.idSensor, o.idOnibus, e.idEmpresa, l.nome
        ORDER BY
            Semana_Do_Mes;
    `;
    return database.executar(query);
}

function getFluxoMesAno(idEmpresa, idLinha) {
    const query = `
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
            e.idEmpresa = ${idEmpresa}
            AND l.idLinha = ${idLinha}
        GROUP BY
            s.idSensor, o.idOnibus, e.idEmpresa, l.nome, MONTH(d.horarioAtivacao), MONTHNAME(d.horarioAtivacao)
        ORDER BY 
            MONTH(d.horarioAtivacao);
    `;
    return database.executar(query);
}

module.exports = {
    listarLinhas,
    getFluxoHoje,
    getFluxoDiaSemana,
    getFluxoSemanaMes,
    getFluxoMesAno
};
