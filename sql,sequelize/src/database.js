const Sequelize = require('sequelize');

const path = 'mysql://root:18021228@localhost:3306/quizapp';
const sequelize = new Sequelize(path, {
    operatorsAliases: 0,
    // logging: false
});
// sequelize.authenticate().then(() => {
//     console.log('Connection established successfully.');
//   }).catch(err => {
//     console.error('Unable to connect to the database:', err);
//   }).finally(() => {
//     sequelize.close();
//   });
module.exports=sequelize
