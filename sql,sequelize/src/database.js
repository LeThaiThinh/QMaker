const Sequelize = require('sequelize');
// const path = 'mysql://hieutran:hieutran@113.190.217.246:7002/quizapp';
const path = 'mysql://root:18021228@127.0.0.1:3306/quizapp';
const sequelize = new Sequelize(path, {
    operatorsAliases: 0,
    logging: false
});
module.exports = sequelize
