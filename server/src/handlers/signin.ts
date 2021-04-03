import { db } from "../database"
import { getSigninQuery } from "../database/queries/user"
import { ISigninRequest } from "../interfaces/database"
import * as express from "express"

const signinHandler = async function (
  req: express.Request,
  res: express.Response,
) {
  var user: ISigninRequest = req.body

  const sql = getSigninQuery(user)
  try {
    const result = await db.query(sql)
    if (!result[0].length) {
      res.status(400).json({ error: "Wrong username or password" })
    } else {
      res.status(200).send("OK")
    }
  } catch (queryError) {
    console.log(queryError)
  }
}

export default signinHandler
