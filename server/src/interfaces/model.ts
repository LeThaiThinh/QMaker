export interface IUser {
  user_id: number
  name: string
  username: string
  password: string
}

export interface IQuestionnaire {
  questionnaire_id: number
  user_id: number
  name: string
  topic: string
  public: 0 | 1
  description: string
  timeLimit: number
}

export interface IQuestion {
  question_id: number
  questionnaire_id: number
  question: string
  correctAnswer: string
  incorrectAnswer1: string
  incorrectAnswer2: string
  incorrectAnswer3: string
}

export interface IHistory {
  user_id: number
  questionnaire_id: number
  score: number
  totalTime: number
}

export interface IRating {
  questionnaire_id: number
  user_id: number
  rating: number
}
