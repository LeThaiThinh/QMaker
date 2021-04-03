import { IUser } from "./model"

export type ISignupRequest = Omit<IUser, "user_id">
export type ISigninRequest = Omit<IUser, "user_id" | "name">
