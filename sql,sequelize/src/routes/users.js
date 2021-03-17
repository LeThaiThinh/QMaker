var express = require('express');
var router = express.Router();
var {User:User,Questionnaire:Questionnaire,Question:Question}=require('../model/relation')
var faker=require('faker')
const Sequelize = require('sequelize');

/* GET users listing. */
router.get('/users',async function (req, res, next)  {
  const users= await User.findAll();
  res.json(users);
});
router.get('/users/questionnaire',async function(req, res, next) {
  questionnaires=await Questionnaire.findAll({

  })
  res.json(questionnaires);
});
router.get('/users/create',async function(req, res, next) {
  for(var i=1;i<5;i++)
  await User.create({
    name:faker.name.lastName(),
    username:faker.name.firstName(),
    password:faker.name.middleName(),
  })
  res.json();
});
router.get(`/users/:id`,async function(req, res, next) {
  var id=req.params['id']
  const user=await User.findOne({
    where:{id:id}
  })
  res.json(user);
});
router.get(`/users/:id/questionnaireTopic`,async function(req, res, next) {
try{
  var userId=parseInt( req.params['id'])
  const questionnaires=await Questionnaire.findAll({
    where:{
      userId:userId,
    },
    attributes: [
      [Sequelize.fn('DISTINCT', Sequelize.col('topic')) ,'topic'],
  ]
  })
  res.json(questionnaires);
}catch(err){
  console.log(err);
}
});
router.get(`/users/:id/questionnaireByTopic`,async function(req, res, next) {
  var userId=req.params['id']
  const questionnaires=await Questionnaire.findAll({
    include:{
      model:User,
      where:{
        userId:Id,
      }
    },

  })
  res.json(questionnaires);
});
router.get('/users/:id/questionnaire/create',async function(req, res, next) {
  try{
  var userId=parseInt(req.params['id'])
  const user=User.findOne({where:{
    id:userId
  }})
  var topic=Math.random()
  var questionnaire={
    topic:topic<0.2?"Toán":topic<0.4?"Ứng dụng di động":topic<0.6?"Âm nhạc":topic<0.8?"phim ảnh":"Hóa học",
    description:faker.name.jobDescriptor(),
    public:Math.random() < 0.5?true:false,
    time_limit:parseInt(Math.random()*600),
    userId:userId
  }
  questionnaire=await Questionnaire.create(questionnaire)
  // user.createQuestionnaire(questionnaire)
  res.json(questionnaire);
}catch(err){
  console.log(err);
}
});
router.get('/users/:id/questionnaire',async function(req, res, next) {
  var userId=req.params['id']
  questionnaires=await Questionnaire.findAll({
    where:{
      userId:userId
    }
  })
  res.json(questionnaires);
});
module.exports = router;
