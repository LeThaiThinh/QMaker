var express = require('express');
var router = express.Router();
var {User:User,Questionnaire:Questionnaire}=require('../model/relation')
var faker=require('faker')
/* GET users listing. */
router.get('/users',async function (req, res, next)  {
  const users= await User.findAll();
  res.json(users);
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
  var userId=req.params['id']
  const questionnaires=await Questionnaire.findAll({
    include:{
      model:User,
      where:{
        id:userId,
      }
    },
    distinct:'toppic',
  })
  res.json(questionnaires);
});
router.get(`/users/:id/questionnaireByTopic`,async function(req, res, next) {
  var id=req.params['id']
  const questionnaires=await Questionnaire.findAll({
    include:{
      model:User,
      where:{
        id:id,
      }
    },
    group:'toppic',
  })
  res.json(questionnaires);
});
router.get('/users/:id/questionnaire/create',async function(req, res, next) {
  var userId=parseInt(req.params['id'])
  const user=User.findOne({where:{
    id:userId
  }})
  const questionnaire=await Questionnaire.create({
    topic:faker.name.title(),
    description:faker.name.jobDescriptor(),
    public:Math.random() < 0.5?true:false,
    time_limit:parseInt(Math.random()*600),
    // userId:userId
  })
  user.addQuestionnaire(Questionnaire)
  res.json(questionnaire);
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
router.get('/users/questionnaire',async function(req, res, next) {
  questionnaires=await Questionnaire.findAll()
  res.json(questionnaires);
});
module.exports = router;
