var sequelize=require('../database')
const Sequelize = require('sequelize');

let Questionnaire = sequelize.define('questionnaire', {
    id:{
        primaryKey:true,
        type:Sequelize.INTEGER,
        autoIncrement: true,
        allowNull: false
    },
    topic: {
        type:Sequelize.STRING,
        allowNull: false
    },
    public:{
        type:Sequelize.BOOLEAN,
        allowNull: false
    },
    description:{
        type:Sequelize.STRING,
        allowNull: false
    },
    time_limit:{
        type:Sequelize.INTEGER,
        allowNull: false
    },
});


module.exports=Questionnaire 