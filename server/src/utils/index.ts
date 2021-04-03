import * as sequelize from "sequelize"

export const getSequelizeErrorResponse = (queryError: sequelize.Error) => {
  return {
    error: queryError.name,
  }
}
