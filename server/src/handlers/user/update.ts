const updateUserHandler = async (req, res) => {
  const user = req.body

  res.json(user)
}

export default updateUserHandler
