const express = require('express');
const userController = require('../controller/userController');

const router = express.Router();

router.post('/auth', userController.auth)

router.post('/register', userController.register)

router.post('/connect', userController.connect)

router.get('/graph/:id', userController.getGraph)

router.get('/login/:id', userController.getUser)

router.get('/:id', userController.getAll)

router.get('/adj/:id', userController.getAdj)

router.delete('/:idSource/:idTarget', userController.delete)

router.put('/:id', userController.updateVisible)

module.exports = router;