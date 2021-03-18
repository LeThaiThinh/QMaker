var Questionnaire=require('./questionnaire')
var User=require('./users')
var Question=require('./question')
var History=require('./history')
var Rating=require('./rating')

User.hasMany(Questionnaire)
Questionnaire.belongsTo(User)
Questionnaire.belongsToMany(User, {
    through:History
  })
User.belongsToMany(Questionnaire, {
    through:History
  })
Questionnaire.belongsToMany(User, {
    through:Rating
  })
User.belongsToMany(Questionnaire, {
    through:Rating
  })
Questionnaire.hasMany(Question)
Question.belongsTo(Questionnaire)

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
    await History.sync({force:false}).then(() => {
        console.log('New table created');
    }).finally(() => {
        // sequelize.close();
    })
    await Rating.sync({force:true}).then(() => {
        console.log('New table created');
    }).finally(() => {
        // sequelize.close();
    })
}
createTables();

module.exports={Questionnaire:Questionnaire,User:User,Question:Question}