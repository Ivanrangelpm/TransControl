// var ambiente_processo = 'producao';
var ambiente_processo = 'desenvolvimento';

var caminho_env = ambiente_processo === 'producao' ? '.env' : '.env.dev';
// Acima, temos o uso do operador ternário para definir o caminho do arquivo .env
// A sintaxe do operador ternário é: condição ? valor_se_verdadeiro : valor_se_falso

require("dotenv").config({ path: caminho_env });

var express = require("express");
var cors = require("cors");
var path = require("path");
var PORTA_APP = process.env.APP_PORT;
var HOST_APP = process.env.APP_HOST;

var app = express();

var indexRouter = require("./src/routes/index");
var usuarioRouter = require("./src/routes/usuarios");
var avisosRouter = require("./src/routes/avisos");
var medidasRouter = require("./src/routes/medidas");
var aquariosRouter = require("./src/routes/aquarios");
var empresasRouter = require("./src/routes/empresas");

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "public")));

app.use(cors());

app.use("/", indexRouter);
app.use("/usuarios", usuarioRouter);
app.use("/avisos", avisosRouter);
app.use("/medidas", medidasRouter);
app.use("/aquarios", aquariosRouter);
app.use("/empresas", empresasRouter);

app.listen(PORTA_APP, function () {
    console.log(`
    88888888888                                 .d8888b.                    888                    888 
        888                                    d88P  Y88b                   888                    888 
        888                                    888    888                   888                    888 
        888  888d888 8888b.  88888b.  .d8888b  888         .d88b.  88888b.  888888 888d888 .d88b.  888 
        888  888P"      "88b 888 "88b 88K      888        d88""88b 888 "88b 888    888P"  d88""88b 888 
        888  888    .d888888 888  888 "Y8888b. 888    888 888  888 888  888 888    888    888  888 888 
        888  888    888  888 888  888      X88 Y88b  d88P Y88..88P 888  888 Y88b.  888    Y88..88P 888 
        888  888    "Y888888 888  888  88888P'  "Y8888P"   "Y88P"  888  888  "Y888 888     "Y88P"  888 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
                                                                                               
    Servidor do seu site já está rodando! Acesse o caminho a seguir para visualizar .: http://${HOST_APP}:${PORTA_APP} :. \n\n
    Você está rodando sua aplicação em ambiente de .:${process.env.AMBIENTE_PROCESSO}:. \n\n
    \tSe .:desenvolvimento:. você está se conectando ao banco local. \n
    \tSe .:producao:. você está se conectando ao banco remoto. \n\n
    \t\tPara alterar o ambiente, comente ou descomente as linhas 1 ou 2 no arquivo 'app.js'\n\n`);
});
