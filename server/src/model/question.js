const sequelize = require("../database")
const Sequelize = require("sequelize")
const Questionnaire = require("./questionnaire")

let Question = sequelize.define("question", {
  question_id: {
    primaryKey: true,
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
  },
  questionnaire_id: {
    type: Sequelize.INTEGER,
    allowNull: false,
    references: {
      modal: Questionnaire,
      key: "questionnaire_id",
    },
  },
  question: {
    type: Sequelize.STRING,
    allowNull: false,
  },
  correctAnswer: {
    type: Sequelize.STRING,
    allowNull: false,
  },
  incorrectAnswer1: {
    type: Sequelize.STRING,
    allowNull: false,
  },
  incorrectAnswer2: {
    type: Sequelize.STRING,
    allowNull: false,
  },
  incorrectAnswer3: {
    type: Sequelize.STRING,
    allowNull: false,
  },
})
module.exports = Question
