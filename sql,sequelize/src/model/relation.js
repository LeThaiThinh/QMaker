var Questionnaire=require('./questionnaire')
var User=require('./users')
var Question=require('./question')
const { Op } = require("sequelize");

User.hasMany(Questionnaire)
// Questionnaire.belongsToMany(User, {
//     through:'History'
//   })
Questionnaire.belongsTo(User)
Questionnaire.hasMany(Question)
Question.belongsTo(Questionnaire)
// Question.belongsTo(Questionnaire, {
//     // foreignKey: 'questionnaireId',
//     // allowNull: false
//   })
async function createTables(){
    await User.sync({force:false}).then(() => {
        console.log('New table created');
    }).finally(() => {
        // sequelize.close();
    })
    await Questionnaire.sync({force:false}).then(() => {
        console.log('New table created');
    }).finally(() => {
        // sequelize.close();
    })
    await Question.sync({force:false}).then(() => {
        console.log('New table created');
    }).finally(() => {
        // sequelize.close();
    })
}
createTables();

module.exports={Questionnaire:Questionnaire,User:User,Question:Question}