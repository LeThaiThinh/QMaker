var express = require('express');
var router = express.Router();
var {User:User}=require('../model/relation')
const { Op } = require("sequelize");
/* GET home page. */

router.post('/signin',async function(req, res, next) {
  var user= req.body
  console.log(user)
  var user0=await User.findOne({where:{
    [Op.and]:[
    {username:user['username']},
    {password:user['password']}
    ]
  }})
  if(user0!=null){
    res.statusCode=200,res.json(user0)
  }else res.json(null)
});
router.post('/signup',async function(req, res, next) {
  var user=req.body
  var userName=req.body['name']
  var userUsername=req.body['username']
  var password=req.body['password']
  await User.create(user)
  res.redirect(`users/${user.id}`)
});

module.exports = router;
