const sequelize = require("../database")
const Sequelize = require("sequelize")
const User = require("./user")

let Rating = sequelize.define("rating", {
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
  rating: {
    type: Sequelize.INTEGER,
    allowNull: false,
  },
})

module.exports = Rating
