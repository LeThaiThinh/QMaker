const sequelize = require("../database")
const Sequelize = require("sequelize")
const User = require("./user")
const Questionnaire = require("./questionnaire")

let History = sequelize.define("history", {
  user_id: {
    type: Sequelize.INTEGER,
    allowNull: false,
    references: {
      modal: User,
      key: "user_id",
    },
  },
  questionnaire_id: {
    type: Sequelize.INTEGER,
    allowNull: false,
    references: {
      modal: Questionnaire,
      key: "questionnaire_id",
    },
  },
  score: {
    type: Sequelize.INTEGER,
    allowNull: false,
  },
  totalTime: {
    type: Sequelize.INTEGER,
    allowNull: false,
  },
})

module.exports = History
