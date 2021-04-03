import {
  ISigninRequest,
  ISignupRequest,
  IUserGETRequest,
} from "../../interfaces/database"

export const getSignupQuery = (props: ISignupRequest) => {
  const { username, name, password } = props

  return `
    INSERT INTO user (username, name, password)
    VALUES (
      "${username}", 
      "${name}",
      "${password}"
    );
  `
}

export const getSigninQuery = (props: ISigninRequest) => {
  const { username, password } = props

  return `
    SELECT user_id
    FROM user
    WHERE username = "${username}" AND password = "${password}";
  `
}

export const getGETUserQuery = (props: IUserGETRequest) => {
  const { user_id, username } = props

  return `
    SELECT user_id, username, name
    FROM user
    WHERE user_id = "${user_id}" OR username = "${username}";
  `
}
