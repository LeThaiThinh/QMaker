import { ISignupRequest } from "../interfaces/database"
import { db } from "../database"
import { getSignupQuery } from "../database/queries/user"
import * as express from "express"
import { getSequelizeErrorResponse } from "../utils"

const signupHandler = async function (
  req: express.Request,
  res: express.Response,
) {
  var user: ISignupRequest = req.body

  const sql = getSignupQuery(user)

  try {
    const result = await db.query(sql)
    res.json(result[0])
  } catch (queryError) {
    res.status(500).send(getSequelizeErrorResponse(queryError))
  }
}

export default signupHandler
