var sequelize=require('../database')
const Sequelize = require('sequelize');

let Questionnaire = sequelize.define('questionnaire', {
    id:{
        primaryKey:true,
        type:Sequelize.INTEGER,
        autoIncrement: true,
        allowNull: false
    },
    name:{
        type:Sequelize.STRING,
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
    userId: {
            type: Sequelize.INTEGER,
            references:{
                model:'users', // <<< Note, its table's name, not object name
                key: 'id' // <<< Note, its a column name
            }}
});


module.exports=Questionnaire 