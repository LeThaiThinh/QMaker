const express = require("express")
const app = express()
const morgan = require("morgan")
const database = require("./database")

database.initDB()

const handleErrors = (err, req, res, next) => {
  return res.status(500).json(err)
}

app.use(morgan("dev"))
app.use(express.json())
app.use(express.urlencoded({ extended: false }))
app.use("/", require("./routes"))
app.use(handleErrors)

export default app
