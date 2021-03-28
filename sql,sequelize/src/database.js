const Sequelize = require('sequelize');

const path = 'mysql://root:18021228@localhost:3306/quizapp';
const sequelize = new Sequelize(path, {
    operatorsAliases: 0,
    logging: false
});
module.exports=sequelize
