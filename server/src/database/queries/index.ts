const CREATE_TABLE_USER = `
  CREATE TABLE IF NOT EXISTS user (
    user_id   INT UNSIGNED  AUTO_INCREMENT,
    name      VARCHAR(30)   NOT NULL,
    username  VARCHAR(30)   NOT NULL,
    password  VARCHAR(50)   NOT NULL,

    CONSTRAINT unique_username UNIQUE (username),
    CONSTRAINT pk_user PRIMARY KEY (user_id)
  );
`
const CREATE_TABLE_QUESTIONNAIRE = `
  CREATE TABLE IF NOT EXISTS questionnaire (
    questionnaire_id  INT UNSIGNED AUTO_INCREMENT,
    user_id           INT UNSIGNED,
    name              VARCHAR(50) NOT NULL,
    topic             VARCHAR(25) NOT NULL,
    public            ENUM ('public', 'private'),
    description       VARCHAR(100),
    time_limit        INT not null,
    created_at        TIMESTAMP,
    updated_at        TIMESTAMP,

    CONSTRAINT pk_questionnaire PRIMARY KEY (questionnaire_id),
    CONSTRAINT fk_questionnaire_user_id FOREIGN KEY (user_id) REFERENCES user (user_id)
  );
`
const CREATE_TABLE_QUESTION = `
  CREATE TABLE IF NOT EXISTS question (
    question_id       INT UNSIGNED AUTO_INCREMENT,
    questionnaire_id  INT UNSIGNED,
    question          VARCHAR(150) NOT NULL,
    correct_answer    VARCHAR(50) NOT NULL,
    incorrect_answer1 VARCHAR(50) NOT NULL,
    incorrect_answer2 VARCHAR(50) NOT NULL,
    incorrect_answer3 VARCHAR(50) NOT NULL,

    CONSTRAINT pk_question PRIMARY KEY (question_id),
    CONSTRAINT fk_question_questionnaire_id FOREIGN KEY (questionnaire_id) REFERENCES questionnaire (questionnaire_id)
  );
`

const CREATE_TABLE_HISTORY = `
  CREATE TABLE IF NOT EXISTS history (
    user_id INT UNSIGNED,
    questionnaire_id INT UNSIGNED,
    score INT UNSIGNED NOT NULL,
    total_time INT UNSIGNED NOT NULL,

    CONSTRAINT pk_history PRIMARY KEY (user_id, questionnaire_id),
    CONSTRAINT fk_history_user_id FOREIGN KEY (user_id) REFERENCES user (user_id),
    CONSTRAINT fk_history_questionnaire_id FOREIGN KEY (questionnaire_id) REFERENCES questionnaire (questionnaire_id)
  );
`

const CREATE_TABLE_RATING = `
  CREATE TABLE IF NOT EXISTS rating (
    questionnaire_id INT UNSIGNED,
    user_id INT UNSIGNED,
    rating TINYINT UNSIGNED CHECK (rating IN (1, 2, 3, 4, 5)),

    CONSTRAINT fk_rating_user_id FOREIGN KEY (user_id) REFERENCES user (user_id),
    CONSTRAINT fk_rating_questionnaire_id FOREIGN KEY (questionnaire_id) REFERENCES questionnaire (questionnaire_id)
  );
`
export default {
  CREATE_TABLE_USER,
  CREATE_TABLE_QUESTIONNAIRE,
  CREATE_TABLE_QUESTION,
  CREATE_TABLE_HISTORY,
  CREATE_TABLE_RATING,
}
