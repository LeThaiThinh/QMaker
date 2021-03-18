var sequelize=require('../database')
const Sequelize = require('sequelize');

let Rating = sequelize.define('rating', {
    questionnaireId:{
        type: Sequelize.INTEGER,
        references:{
            model:'questionnaires', // <<< Note, its table's name, not object name
            key: 'id' // <
    },
    },
    rating:{
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


module.exports=Rating 