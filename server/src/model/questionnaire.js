const sequelize = require("../database")
const Sequelize = require("sequelize")
const User = require("./user")

let Questionnaire = sequelize.define("questionnaire", {
  questionnaire_id: {
    primaryKey: true,
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: false,
  },
  user_id: {
    type: Sequelize.INTEGER,
    allowNull: false,
    references: {
      modal: User,
      key: "user_id",
    },
  },
  name: {
    type: Sequelize.STRING,
    allowNull: false,
  },
  topic: {
    type: Sequelize.STRING,
    allowNull: false,
  },
  public: {
    type: Sequelize.BOOLEAN,
    allowNull: false,
  },
  description: {
    type: Sequelize.STRING,
    allowNull: false,
  },
  timeLimit: {
    type: Sequelize.INTEGER,
    allowNull: false,
  },
})

module.exports = Questionnaire
