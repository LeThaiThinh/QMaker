var sequelize = require('../database')
const Sequelize = require('sequelize');

let Questionnaire = sequelize.define('questionnaires', {
    id: {
        primaryKey: true,
        type: Sequelize.INTEGER,
        autoIncrement: true,
        allowNull: false
    },
    name: {
        type: Sequelize.STRING,
        allowNull: false
    },
    topic: {
        type: Sequelize.STRING,
        allowNull: false
    },
    public: {
        type: Sequelize.BOOLEAN,
        allowNull: false
    },
    description: {
        type: Sequelize.STRING,
        allowNull: false
    },
    timeLimit: {
        type: Sequelize.INTEGER,
        allowNull: false
    },

});


module.exports = Questionnaire