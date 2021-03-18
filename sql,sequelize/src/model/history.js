var sequelize=require('../database')
const Sequelize = require('sequelize');

let History = sequelize.define('history', {
    questionnaireId:{
        type: Sequelize.INTEGER,
        references:{
            model:'questionnaires', // <<< Note, its table's name, not object name
            key: 'id' // <
    },},
    totalTime:{
        type:Sequelize.INTEGER,
        allowNull: false
    },
    score:{
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


module.exports=History 