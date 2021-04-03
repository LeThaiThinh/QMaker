import * as express from "express"
import { db } from "../../database"
import { getGETUserQuery } from "../../database/queries/user"
import { IUserGETRequest } from "../../interfaces/database"
import { getSequelizeErrorResponse } from "../../utils"

const readUserHandler = async (req: express.Request, res: express.Response) => {
  const user = (req.query as unknown) as IUserGETRequest

  const sql = getGETUserQuery(user)
  try {
    const result = await db.query(sql)

    const sqlResult = result[0]

    if (!sqlResult.length) {
      res.status(404).json({ error: "User not found" })
    } else {
      res.status(200).send(sqlResult[0])
    }
  } catch (queryError) {
    res.status(500).send(getSequelizeErrorResponse(queryError))
  }
}

export default readUserHandler
