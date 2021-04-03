import app from "./app"
const port = 4000

const main = async () => {
  await app.listen(port)
  console.log("Server is listening on port " + port)
}

main()
