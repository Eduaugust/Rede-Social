const express = require('express');
const indexRoute = require('./routes/indexRoute');
const userRoute = require('./routes/userRoute');
const dotenv = require('dotenv');

const app = express();

dotenv.config();

app.use(express.json());

app.use('/', indexRoute)

app.use('/user', userRoute)

app.listen(process.env.PORT, () => {
    console.log(`Servidor rodando na porta ${process.env.PORT}`)
})