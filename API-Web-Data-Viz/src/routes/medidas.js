  const express = require("express");
  const router = express.Router();
  const medidaController = require("../controllers/medidaController");

  router.get("/listarLinhas/:idEmpresa", medidaController.listarLinhas);
  router.get("/fluxo/:idEmpresa/:idLinha/:periodo", medidaController.getFluxo);
  router.get("/mediaFluxo/:idEmpresa", medidaController.getMediaFluxo);


  module.exports = router;
