// Gerar dados aleatórios para os gráficos
const fluxoDiarioData = Array.from({ length: 7 }, () => Math.floor(Math.random() * 5000) + 1000);
const fluxoSemanalData = Array.from({ length: 7 }, () => Math.floor(Math.random() * 30000) + 10000);
const fluxoMensalData = Array.from({ length: 4 }, () => Math.floor(Math.random() * 80000) + 20000);
const metaDiaria = 2000;
const metaSemanal = 15000;
const metaMensal = 45000;

// Verificar se os dados estão abaixo da meta
const verificarAlerta = (data, meta) => {
    return data.some(valor => valor < meta);
};

// Quantificar gráficos em alerta
let alertas = 0;

if (verificarAlerta(fluxoDiarioData, metaDiaria)) alertas++;
if (verificarAlerta(fluxoSemanalData, metaSemanal)) alertas++;
if (verificarAlerta(fluxoMensalData, metaMensal)) alertas++;

// Função para criar gráficos de linha com metas
const criarGraficoLinha = (elementoId, labels, data, meta, label) => {
    const contexto = document.getElementById(elementoId).getContext('2d');

    new Chart(contexto, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: label,
                data: data,
                borderColor: '#ffd902',
                backgroundColor: '#ffe135',
                pointRadius: 5,
                pointBackgroundColor: '#ffd902',
                pointBorderColor: '#fff',
                pointHoverRadius: 7,
                pointHoverBackgroundColor: '#fff',
                pointHoverBorderColor: '#ffd902',
                pointHitRadius: 10,
                pointBorderWidth: 2
            }, {
                label: 'Meta',
                data: Array(data.length).fill(meta),
                borderColor: '#ff0000',
                borderWidth: 2,
                pointRadius: 0,
                type: 'line'
            }]
        },
        options: {
            scales: {
                x: {
                    beginAtZero: true
                },
                y: {
                    beginAtZero: true
                }
            }
        }
    });
};

// Atualizar os dados nos gráficos
criarGraficoLinha('fluxoDiario', ['6:00', '10:00', '12:00', '15:00', '19:00', '21:00', '00:00'], fluxoDiarioData, metaDiaria, 'Fluxo Diário');
criarGraficoLinha('fluxoSemanal', ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'], fluxoSemanalData, metaSemanal, 'Fluxo Semanal');
criarGraficoLinha('fluxoMensal', ['Semana 1', 'Semana 2', 'Semana 3', 'Semana 4'], fluxoMensalData, metaMensal, 'Fluxo Mensal');

// Criar gráfico de pizza para alertas
const contextoGraficoAlertas = document.getElementById('graficoAlertas').getContext('2d');
new Chart(contextoGraficoAlertas, {
    type: 'pie',
    data: {
        labels: ['Em Alerta', 'Normal'],
        datasets: [{
            label: 'Alertas',
            data: [alertas, 3 - alertas],
            backgroundColor: ['#ff0000', '#00ff00']
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: {
                position: 'top'
            },
            tooltip: {
                callbacks: {
                    label: function (tooltipItem) {
                        return tooltipItem.label + ': ' + tooltipItem.raw;
                    }
                }
            }
        }
    }
});

// Função para o botão do usuário
function opcaoHeader() {
    var options = document.getElementById("options");
    options.style.display = options.style.display === "block" ? "none" : "block";
}

// JavaScript para o dropdown "Linhas"
document.addEventListener('DOMContentLoaded', (event) => {
    const linhasButton = document.getElementById('linhasButton');
    const linhasDropdown = document.getElementById('linhasDropdown');
    const nextButtons = document.querySelectorAll('.botaoSidebar');

    linhasButton.addEventListener('click', () => {
        if (linhasDropdown.classList.contains('show')) {
            linhasDropdown.classList.remove('show');
            nextButtons.forEach(button => {
                if (button !== linhasButton) {
                    button.style.marginTop = '0';
                }
            });
        } else {
            linhasDropdown.classList.add('show');
            nextButtons.forEach(button => {
                if (button !== linhasButton && button.previousElementSibling === linhasDropdown.parentElement) {
                    button.style.marginTop = `${linhasDropdown.scrollHeight}px`;
                }
            });
        }
    });
});
