var Questionnaire=require('./questionnaire')
var User=require('./users')
var Question=require('./question')
var History=require('./history')
// var Rating=require('./rating')
const sequelize = require('../database')


async function createTables(){
    // await User.drop()
    // await Questionnaire.drop()
    // await Question.drop()
    // await History.drop()
    // await Rating.drop()
    Questionnaire.belongsToMany(User, {
      through:History,
      foreignKey: 'questionnaireId'
    })
    User.belongsToMany(Questionnaire, {
      through:History,
      foreignKey: 'userId',
    })
    User.hasMany(Questionnaire)
    Questionnaire.belongsTo(User)
    Questionnaire.hasMany(Question)
    Question.belongsTo(Questionnaire)

    await User.sync({
        // force:true
    }).then(() => {})
    await Questionnaire.sync({
        // force:true
    }).then(() => {})
    await Question.sync({
        // force:true
    }).then(() => {})
    await History.sync({
        // force:true
    }).then(() => {})
}
createTables();

module.exports={Questionnaire:Questionnaire,User:User,Question:Question,History:History}