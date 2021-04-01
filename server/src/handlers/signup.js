const { User } = require("../model")

const signupHandler = async function (req, res, next) {
  var user = req.body
  console.log(user)
  user = await User.create(user)
  res.json(user)
}

module.exports = signupHandler