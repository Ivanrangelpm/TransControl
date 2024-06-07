const express = require("express");
const router = express.Router();
const medidaController = require("../controllers/medidaController");

router.get("/listarLinhas/:idEmpresa", medidaController.listarLinhas);
router.get("/fluxo/:idEmpresa/:idLinha", medidaController.getFluxo);

module.exports = router;
