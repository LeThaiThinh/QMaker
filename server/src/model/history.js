var sequelize = require("../database")
const Sequelize = require("sequelize")

let History = sequelize.define("histories", {
  totalTime: {
    type: Sequelize.INTEGER,
    allowNull: false,
  },
  score: {
    type: Sequelize.INTEGER,
    allowNull: false,
  },
  recentlyUsed: {
    type: Sequelize.INTEGER,
  },
  rating: {
    type: Sequelize.INTEGER,
  },
})

module.exports = History
