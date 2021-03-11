var sequelize=require('../database')
const Sequelize = require('sequelize');

let User = sequelize.define('users', {
    id:{
        primaryKey:true,
        type:Sequelize.INTEGER,
        autoIncrement: true,
        allowNull: false
    },
    name: {
        type:Sequelize.STRING,
        allowNull: false
    },
    username:{
        type:Sequelize.STRING,
        allowNull: false
    },
    password:{
        type:Sequelize.STRING,
        allowNull: false
    }
});

User.sync({force:false}).then(() => {
    console.log('New table created');
}).finally(() => {
    // sequelize.close();
})
module.exports=User 