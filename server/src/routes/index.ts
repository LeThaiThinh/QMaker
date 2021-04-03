const express = require("express")
import userHandler from "../handlers/user"
import signupHandler from "../handlers/signup"
import signinHandler from "../handlers/signin"

const router = express.Router()

router.post("/signup", signupHandler)
router.post("/signin", signinHandler)
router.all("/user", userHandler)

module.exports = router
