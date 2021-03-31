const Sequelize = require("sequelize")

const path = "mysql://hieutran:hieutran@113.190.217.246:7002/quizapp"
const sequelize = new Sequelize(path, {
  operatorsAliases: 0,
  logging: false,
})
module.exports = sequelize
