const express = require("express")
const userHandler = require("../handlers/user")
const signupHandler = require("../handlers/signup")
const signinHandler = require("../handlers/signin")

const router = express.Router()

router.post("/signup", signupHandler)
router.post("/signin", signinHandler)
router.all("/user", userHandler)

module.exports = router
