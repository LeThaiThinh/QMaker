var sequelize=require('../database')
const Sequelize = require('sequelize');

let Question = sequelize.define('question', {
    id:{
        primaryKey:true,
        type:Sequelize.INTEGER,
        autoIncrement: true,
        allowNull: false
    },
    question: {
        type:Sequelize.STRING,
        allowNull: false
    },
    correctAnswer:{
        type:Sequelize.STRING,
        allowNull: false
    },
    incorrectAnswer1:{
        type:Sequelize.STRING,
        allowNull: false
    },
    incorrectAnswer2:{
        type:Sequelize.STRING,
        allowNull: false
    },
    incorrectAnswer3:{
        type:Sequelize.STRING,
        allowNull: false
    },

});
module.exports=Question 