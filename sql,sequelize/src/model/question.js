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
    correct_answer:{
        type:Sequelize.BOOLEAN,
        allowNull: false
    },
    incorrect_answer:{
        type:Sequelize.STRING,
        allowNull: false
    },
    incorrect_answer2:{
        type:Sequelize.STRING,
        allowNull: false
    },
    incorrect_answer3:{
        type:Sequelize.STRING,
        allowNull: false
    },

});
module.exports=Question 