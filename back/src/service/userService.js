const userData = require('../data/userData');
const { ResponseDTO } = require('../dtos/response')
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');

exports.register = async (data) => {
    try {

        const getByEmail = await userData.getByEmail(data.email);
        if(getByEmail){
            return new ResponseDTO('Error', 403 , 'Usuário já existente', null)  
        }

        data.password = await bcryptjs.hash(data.password, 10);
        const newUser = await userData.register(data)
        delete newUser.response.password
        return new ResponseDTO('Success', 200, '', newUser)  
    } catch (e) {
        return new ResponseDTO('Error', 500, 'Error acessing database', e.stack)    
    }    
}

exports.auth = async (data) => {
    try {
        const user = await userData.getByEmail(data.email)
        if(user==null){
            return new ResponseDTO('Error', 403 , 'Usuário não existe', null)  
        }
        const passwordMatches = await bcryptjs.compare(data.password, user.password)
        if(!passwordMatches){
            return new ResponseDTO('Error', 401, 'Senha errada.')
        }
        delete user.password;
            
        const token = jwt.sign(
            user, 
            'Segredinho Hiper Secretooo. Shhhh!!', 
            { expiresIn: '1d' }
        );
        return new ResponseDTO('Success', 200, '', user)  
    } catch (e) {
        return new ResponseDTO('Error', 500, 'Error acessing database', e.stack)    
    }    
}

exports.connect = async (data) => {
    try {

        userConnects = await userData.getConnect(data.id)
        if (userConnects.adj.includes(data.targetId))
            return new ResponseDTO('Error', 400, 'Você e essa pessoa já são conectadas')

        if (data.type == 'Conhecido' || data.type == 'Cliente'){
            const connect = await userData.connect(data.id, data.targetId, data.type);
            return new ResponseDTO('Success', 200, '', )  
        }
        userConnects = await userData.getConnect(data.targetId)
        if (userConnects.adj.includes(data.id))
            return new ResponseDTO('Error', 400, 'A pessoa já te conhece')    

        // type == "amizade" or type == "familia"
        const connect1 = await userData.connect(data.id, data.targetId, data.type);
        const connect2 = await userData.connect(data.targetId, data.id, data.type);
        
        return new ResponseDTO('Success', 200, '', )  
    } catch (e) {
        return new ResponseDTO('Error', 500, 'Error acessing database', e.stack)    
    }    
}

exports.getGraph = async (id) => {
    try {
        allNodes = await userData.getAllNodes()
        connects = []
        visitados = []
        lista = [id]
        while (lista.length != 0){
            atual = lista.shift()
            if (visitados.includes(atual)){
                continue
            }
            visitados.push(atual)
            userConnects = await userData.getConnect(atual)
            userConnects['source'] = atual
            connects.push(userConnects)
            lista.push(...userConnects.adj)
        }
        return new ResponseDTO('Success', 200, '', {connects, allNodes})  
    } catch (e) {
        return new ResponseDTO('Error', 500, 'Error acessing database', e.stack)    
    }    
}

exports.getUser = async (id) => {
    try {
        response = await userData.getUser(id)
        return new ResponseDTO('Success', 200, '', response)  
    } catch (e) {
        return new ResponseDTO('Error', 500, 'Error acessing database', e.stack)    
    }    
}

exports.getAll = async (id) => {
    try {
        userConnects = await userData.getConnect(id)
        arr = userConnects.adj
        arr.push(parseInt(id))
        allUser = await userData.getAll(arr)
        
        teste = allUser.map((element, index) => {
            element.emailVisible? null : allUser[index].email = ''
            element.numberVisible? null : allUser[index].number = ''
            element.nameVisible? null : allUser[index].name = ''
        })
        return new ResponseDTO('Success', 200, '', allUser)  
    } catch (e) {
        return new ResponseDTO('Error', 500, 'Error acessing database', e.stack)    
    }    
}

exports.getAdj = async (id) => {
    try {
        userConnects = await userData.getConnect(id)
        allUser = await userData.getAdj(userConnects.adj)
        for (let index = 0; index < allUser.length; index++) {
            allUser[index].relationType = userConnects.type[index]
            
        }
        
        return new ResponseDTO('Success', 200, '', allUser)  
    } catch (e) {
        return new ResponseDTO('Error', 500, 'Error acessing database', e.stack)    
    }    
}

exports.delete = async (source, target) => {
    try {
        userConnects = await userData.getConnect(source)
        arr_adj = userConnects.adj
        arr_type = userConnects.type
        console.log(arr_adj, arr_type)
        index = arr_adj.indexOf(parseInt(target))
        tipo = arr_type.splice(index, 1)
        arr_adj.splice(index, 1)
        console.log(arr_adj, arr_type)
        console.log(arr_adj, arr_type)
        ;
        update = await userData.delete(source, arr_adj, arr_type)

        if (!(tipo == 'Cliente' || tipo == 'Conhecido')){

            console.log(22)
            userConnects = await userData.getConnect(target)
            arr_adj = userConnects.adj
            arr_type = userConnects.type
            console.log(arr_adj, arr_type)
            index = arr_adj.indexOf(parseInt(source))
            tipo = arr_type.splice(index, 1)
            arr_adj.splice(index, 1)
            console.log(arr_adj, arr_type)


            update = await userData.delete(target, arr_adj, arr_type)
        }

        return new ResponseDTO('Success', 200, '')  
    } catch (e) {
        return new ResponseDTO('Error', 500, 'Error acessing database', e.stack)    
    }    
}

exports.updateVisible = async (id, data) => {
    try {
        response = await userData.update(id, data)
        
        return new ResponseDTO('Success', 200, '')  
    } catch (e) {
        return new ResponseDTO('Error', 500, 'Error acessing database', e.stack)    
    }    
}