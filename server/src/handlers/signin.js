const { Op } = require("sequelize")
const { User } = require("../model")

const signinHandler = async (req, res, next) => {
  var user = req.body
  
  console.log(user)
  var user0 = await User.findOne({
    where: {
      [Op.and]: [
        { username: user["username"] },
        { password: user["password"] },
      ],
    },
  })
  if (user0 != null) {
    ;(res.statusCode = 200), res.json(user0)
  } else res.json(null)
}

module.exports = signinHandler