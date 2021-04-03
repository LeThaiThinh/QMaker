const createUserHandler = async (req, res) => {
  const user = req.body

  res.json(user)
}

export default createUserHandler
