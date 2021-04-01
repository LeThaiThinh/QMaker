const app = require("./app")
const port = 4000
async function main() {
  await app.listen(port)
  console.log("server on port " + port)
}
main()
