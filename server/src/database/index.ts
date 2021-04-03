import DBConfig from "../configs/database"
import sqlQueries from "./queries"
import { Sequelize } from "sequelize"
// const Sequelize = require("sequelize")

const path = `mysql://${DBConfig.DB_USER}:${DBConfig.DB_PASSWORD}@${DBConfig.DB_HOST}:${DBConfig.DB_PORT}/${DBConfig.DB_NAME}`

// const db = new Sequelize(path, {
//   operatorsAliases: 0,
//   logging: false,
// })

export const db = new Sequelize(
  DBConfig.DB_NAME,
  DBConfig.DB_USER,
  DBConfig.DB_PASSWORD,
  {
    dialect: "mysql",
    host: DBConfig.DB_HOST,
    port: DBConfig.DB_PORT,
    logging: false,
  },
)

export const initDB = async () => {
  // await db.query(`DROP TABLE IF EXISTS history;`)
  // await db.query(`DROP TABLE IF EXISTS rating;`)
  // await db.query(`DROP TABLE IF EXISTS question;`)
  // await db.query(`DROP TABLE IF EXISTS questionnaire;`)
  // await db.query(`DROP TABLE IF EXISTS user;`)
  await db.query(sqlQueries.CREATE_TABLE_USER)
  await db.query(sqlQueries.CREATE_TABLE_QUESTIONNAIRE)
  await db.query(sqlQueries.CREATE_TABLE_QUESTION)
  await db.query(sqlQueries.CREATE_TABLE_HISTORY)
  await db.query(sqlQueries.CREATE_TABLE_RATING)
}

export default {
  db,
  initDB,
}
