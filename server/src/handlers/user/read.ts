import * as express from "express"

const readUserHandler = async (req: express.Request, res: express.Response) => {
  const user = req.query
  res.json(user)
}

export default readUserHandler
