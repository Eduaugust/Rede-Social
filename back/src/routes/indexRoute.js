const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
    res.send("Bem-vindo - Demetec API");})

module.exports = router;