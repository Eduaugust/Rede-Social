const userService = require('../service/userService');

exports.register = async (req, res) => {
    const data = {
        email: req.body?.email, 
        password: req.body?.password,
        name:  req.body?.name,
        userType:  req.body?.userType,
        number:  req.body?.number,
        adj:  [],
        type:  [],
    }
    const response = await userService.register(data)
    if (response.type === 'Success'){
        return res.status(response.status).json(response.data.response);
    } else{
        return res.status(response.status).json(response)
    }
}

exports.auth = async (req, res) => {
    const data = {
        email: req.body?.email, 
        password: req.body?.password,
    }
    const response = await userService.auth(data)
    if (response.type === 'Success'){
        return res.status(response.status).json(response.data);
    } else{
        return res.status(response.status).json(response)
    }
}

exports.connect = async (req, res) => {
    const data = {
        id: req.body?.id, 
        type: req.body?.type,
        targetId: req.body?.targetId,
    }
    const response = await userService.connect(data)
    if (response.type === 'Success'){
        return res.status(response.status).json(response.data);
    } else{
        return res.status(response.status).json(response)
    }
}

exports.getGraph = async (req, res) => {
    const response = await userService.getGraph(req.params.id)
    if (response.type === 'Success'){
        return res.status(response.status).json(response.data);
    } else{
        return res.status(response.status).json(response)
    }
}

exports.getAll = async (req, res) => {
    const response = await userService.getAll(req.params.id)
    if (response.type === 'Success'){
        return res.status(response.status).json(response.data);
    } else{
        return res.status(response.status).json(response)
    }
}

exports.getAdj = async (req, res) => {
    const response = await userService.getAdj(req.params.id)
    if (response.type === 'Success'){
        return res.status(response.status).json(response.data);
    } else{
        return res.status(response.status).json(response)
    }
}

exports.getUser = async (req, res) => {
    const response = await userService.getUser(req.params.id)
    if (response.type === 'Success'){
        return res.status(response.status).json(response.data);
    } else{
        return res.status(response.status).json(response)
    }
}

exports.delete = async (req, res) => {
    const response = await userService.delete(req.params.idSource, req.params.idTarget)
    if (response.type === 'Success'){
        return res.status(response.status).json(response.data);
    } else{
        return res.status(response.status).json(response)
    }
}

exports.updateVisible = async (req, res) => {
    const response = await userService.updateVisible(req.params.id, req.body)
    if (response.type === 'Success'){
        return res.status(response.status).json(response.data);
    } else{
        return res.status(response.status).json(response)
    }
}