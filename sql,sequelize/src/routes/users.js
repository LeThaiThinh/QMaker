var express = require('express');
var router = express.Router();
var User=require('../model/users')
var faker=require('faker')
/* GET users listing. */
router.get('/users/',async function (req, res, next)  {
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

module.exports = router;
