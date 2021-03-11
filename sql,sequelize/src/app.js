const express=require('express')
const app=express()
const morgan=require('morgan')
const cors=require('cors')
// app.use(cors)
app.use(morgan('dev'))
app.use('/',require('./routes/index'))
app.use('/',require('./routes/users'))
module.exports=app