const Questionnaire = require("./questionnaire")
const User = require("./user")
const Question = require("./question")
const History = require("./history")
var Rating = require("./rating")
const sequelize = require("../database")

// async function createTables() {
//   // await User.drop()
//   // await Questionnaire.drop()
//   // await Question.drop()
//   // await History.drop()
//   // await Rating.drop()

//   Questionnaire.belongsTo(User, {
//     foreignKey: "user_id",
//   })

//   User.belongsToMany(Questionnaire, {
//     through: History,
//     foreignKey: "userId",
//   })

//   User.hasMany(Questionnaire)

//   Questionnaire.belongsTo(User)

//   Questionnaire.hasMany(Question)

//   Question.belongsTo(Questionnaire)

//   await User.sync({
//     // force:true
//   }).then(() => {})
//   await Questionnaire.sync({
//     // force:true
//   }).then(() => {})
//   await Question.sync({
//     // force:true
//   }).then(() => {})
//   await History.sync({
//     // force:true
//   }).then(() => {})
// }

// createTables()

sequelize.sync({ force: true })

module.exports = {
  Questionnaire,
  User,
  Question,
  History,
  Rating,
}
