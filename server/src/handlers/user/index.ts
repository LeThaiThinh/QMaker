import createUserHandler from "./create"
import deleteUserHandler from "./delete"
import readUserHandler from "./read"
import updateUserHandler from "./update"

const userHandler = async (req, res) => {
  switch (req.method) {
    case "POST":
      createUserHandler(req, res)
      return
    case "GET":
      readUserHandler(req, res)
      return
    case "PUT":
      updateUserHandler(req, res)
      return
    case "DELETE":
      deleteUserHandler(req, res)
      return
  }
  res.json({})
}

export default userHandler
