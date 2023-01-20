const { PrismaClient } = require('@prisma/client')

const prisma = new PrismaClient()

exports.register = async (data)=> {
    const response =  await prisma.User.create({
        data
      })
    await prisma.$disconnect()
    return {response}
}

exports.getByEmail = async (email) => {
    const response =  await prisma.User.findUnique({
        where: {
            email
        },
    })
    await prisma.$disconnect()
    return response
}

exports.getAdj = async (id) => {
    const response =  await prisma.User.findMany({
        where: {
                id :{
                    in : id
                }
        },
        select: {
           name: true,
           userType: true,
           email: true,
           number: true,
           id: true,
           numberVisible: true,
           nameVisible: true,
           emailVisible: true,
        }
    })
    await prisma.$disconnect()
    return response
}

exports.getUser = async (id) => {
    const response =  await prisma.User.findUnique({
        where: {
                id: parseInt(id)
        },
        select: {
           name: true,
           nameVisible: true,
           userType: true,
           email: true,
           emailVisible: true,
           number: true,
           numberVisible: true,
        }
    })
    await prisma.$disconnect()
    return response
}

exports.getAll = async (id) => {
    const response =  await prisma.User.findMany({
        where: {
            NOT : {
                id :{
                    in : id
                }
            }
        },
        select: {
           name: true,
           userType: true,
           email: true,
           number: true,
           id: true,
           numberVisible: true,
           nameVisible: true,
           emailVisible: true,
        }
       
    })
    await prisma.$disconnect()
    return response
}

exports.connect = async (srcId, targeId, type) => {
    const response =  await prisma.User.update({
        where: {
            id: srcId,
        },
        data: {
            adj: {
              push: targeId,
            },
            type: {
                push: type,
            },
          },
      })
    await prisma.$disconnect()
    return {response}
}

exports.getConnect = async (id) => {
    const response =  await prisma.User.findUnique({
        where: {
            id: parseInt(id)
        },
        select: {
            adj: true,
            type: true,
            name: true
        }
    })
    await prisma.$disconnect()
    return response
}

exports.getAllNodes = async () => {
    const response =  await prisma.User.findMany({
        select: {
            id: true,
            name: true
        }
    })
    await prisma.$disconnect()
    return response
}

exports.delete = async (id, adj, type) => {
    const response =  await prisma.User.update({
        where: {
            id: parseInt(id)
        },
        data: {
            adj,
            type
        }
    })
    await prisma.$disconnect()
    return response
}

exports.update = async (id, data) => {
    const response =  await prisma.User.update({
        where: {
            id: parseInt(id)
        },
        data
    })
    await prisma.$disconnect()
    return response
}