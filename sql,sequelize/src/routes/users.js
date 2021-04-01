var express = require('express');
var router = express.Router();
var { User, Questionnaire, Question, History } = require('../model/relation')
var faker = require('faker')
const { Op, NOW, json } = require("sequelize");
const Sequelize = require('sequelize');

/* GET users listing. */
router.get('/users', async function (req, res, next) {
  const users = await User.findAll();
  res.json(users);
});
router.get('/users/create', async function (req, res, next) {
  for (var i = 1; i < 5; i++)
    var user = await User.create({
      name: faker.name.lastName(),
      username: faker.name.firstName(),
      password: faker.name.middleName(),
    })
  res.json(user);
});
router.get(`/users/:userId`, async function (req, res, next) {
  var userId = req.params['userId']
  const user = await User.findOne({
    where: { id: userId }
  })
  res.json(user);
});
router.get(`/users/:userId/questionnaireTopic`, async function (req, res, next) {
  try {
    var userId = parseInt(req.params['userId'])
    const questionnaires = await Questionnaire.findAll({
      where: {
        userId: userId,
      },
      attributes: [
        [Sequelize.fn('DISTINCT', Sequelize.col('topic')), 'topic'],
      ]
    })
    res.json(questionnaires);
  } catch (err) {
    console.log(err);
  }
});
router.get('/users/:userId/questionnaire/createRandom', async function (req, res, next) {
  try {
    var userId = parseInt(req.params['userId'])
    const user = await User.findOne({
      where: {
        id: userId
      }
    })
    var topic = Math.random()
    var questionnaire = {
      name: faker.name.title(),
      topic: topic < 0.2 ? "Toán" : topic < 0.4 ? "Ứng dụng di động" : topic < 0.6 ? "Âm nhạc" : topic < 0.8 ? "phim ảnh" : "Hóa học",
      description: faker.random.words(6),
      public: Math.random() < 0.5 ? true : false,
      time_limit: parseInt(Math.random() * 600),
      userId: userId
    }

    questionnaire = await Questionnaire.create(questionnaire)
    var history = await History.create({
      userId: userId,
      questionnaireId: questionnaire.id,
      totalTime: 0,
      score: 0,
      rating: 0,
      recentlyUsed: 0,
    })
    // user.createQuestionnaire(questionnaire)
    res.json(questionnaire);
  } catch (err) {
    console.log(err);
  }
});
router.post('/users/:userId/questionnaire/create', async function (req, res, next) {
  try {
    var userId = parseInt(req.params['userId'])
    var questionnaire = req.body
    questionnaire.userId = userId
    console.log(questionnaire)
    questionnaire = await Questionnaire.create(questionnaire)
    var history = await History.create({
      userId: userId,
      questionnaireId: questionnaire.id,
      totalTime: 0,
      score: 0,
      rating: 0,
      recentlyUsed: 0,
    })
    questionnaire0 = await Questionnaire.findOne({
      include: [{
        model: User,
        through: {
          attributes: ['recentlyUsed', 'rating', 'score', 'totalTime', 'userId', 'questionnaireId']
        }
      }, {
        model: Question,
        attributes: ['id', 'question', 'correctAnswer', 'incorrectAnswer1', 'incorrectAnswer2', 'incorrectAnswer3']
      },],
      where: {
        [Op.and]: [
          { userId: userId, },
          { id: questionnaire.id },
        ]
      }
    });
    res.json(questionnaire0);
  } catch (err) {
    console.log(err);
  }
});
router.get('/users/:userId/questionnaire', async function (req, res, next) {
  try {
    var userId = req.params['userId']
    var querydata_where_topic
    var querydata_where_questionId
    var querydata_order
    var querydate_limit
    if (req.query['topic'] != null) {
      querydata_where_topic = { topic: req.query['topic'], }
    }
    if (req.query['questionId'] != null) {
      querydata_where_questionId = { questionId: req.query['questionId'], }
    }
    if (req.query['recentlyUsed'] != null) {
      querydata_order = [[{ model: User }, { model: History }, 'recentlyUsed', req.query['recentlyUsed']]]
      querydate_limit = 3
    }
    else { querydata_order = [['id', 'ASC']]; querydate_limit = 1000 }
    var questionnaires = await Questionnaire.findAll({
      include: {
        model: User,
        // attributes:[],
        through: {
          model: History,
          attributes: ['recentlyUsed', 'rating', 'score', 'totalTime', 'userId', 'questionnaireId']
        },
      },
      where: {
        [Op.and]: [
          { userId: userId, },
          querydata_where_topic,
        ]
      },
      attributes: [
        "id", "name", "description", "topic", "timeLimit", "public", "userId", "createdAt", "updatedAt",
      ],
      order: querydata_order,
      limit: querydate_limit,
    })
    res.json(questionnaires);
  } catch (err) {
    console.log(err);
  }
});
router.get('/users/:userId/questionnaire/:questionnaireId', async function (req, res, next) {
  var userId = req.params['userId']
  var questionnaireId = req.params["questionnaireId"]
  var questionnaire = await Questionnaire.findOne({
    include: [{
      model: User,
      through: {
        attributes: ['recentlyUsed', 'rating', 'score', 'totalTime', 'userId', 'questionnaireId']
      },
    }, {
      model: Question,
      attributes: ['id', 'question', 'correctAnswer', 'incorrectAnswer1', 'incorrectAnswer2', 'incorrectAnswer3']
    },],
    where: {
      [Op.and]: [
        { userId: userId, },
        { id: questionnaireId },
      ]
    }
  });
  res.json(questionnaire)
});
router.get('/users/:userId/questionnaire/:questionnaireId/count', async function (req, res, next) {
  var userId = req.params['userId']
  var questionnaireId = req.params["questionnaireId"]
  var numberOfQuestion = await Question.count({
    where: {
      [Op.and]: [
        { questionnaireId: questionnaireId },
      ]
    }
  });
  res.json(numberOfQuestion)
});
router.get('/users/:userId/questionnaire/:questionnaireId/history', async function (req, res, next) {
  var userId = req.params['userId']
  var questionnaireId = req.params["questionnaireId"]
  var rating = await History.findOne({
    where: {
      questionnaireId: questionnaireId,
    },
    attributes: [[Sequelize.fn('MAX', Sequelize.col('rating')), 'avgRating'],],
  });
  var history = await History.findOne({
    attributes: [[Sequelize.fn('MAX', Sequelize.col('score')), 'maxScore'], 'totalTime'],
    where: {
      questionnaireId: questionnaireId,
      userId: userId
    }
  });
  console.log(history)
  console.log(rating)

  res.json(history)
});
router.get('/users/:userId/questionnaire/:questionnaireId/question/createRandom', async function (req, res, next) {
  var userId = req.params['userId']
  var questionnaireId = req.params["questionnaireId"]
  var question = await Question.create({
    question: faker.random.words(10),
    correct_answer: faker.random.words(3),
    incorrect_answer1: faker.random.words(3),
    incorrect_answer2: faker.random.words(3),
    incorrect_answer3: faker.random.words(3),
    questionnaireId: questionnaireId
  })

  res.json(question);
})
router.post('/users/:userId/questionnaire/:questionnaireId/question/create', async function (req, res, next) {
  var question = req.body
  var userId = req.params['userId']
  question.questionnaireId = parseInt(req.params["questionnaireId"])
  var question = await Question.create(question)

  res.json(question);
})
router.get('/users/:userId/questionnaire/:questionnaireId/question', async function (req, res, next) {
  var userId = req.params['userId']
  var questionnaireId = req.params["questionnaireId"]
  var question = await Question.findAll({
    where: {
      [Op.and]: [
        { questionnaireId: questionnaireId },
      ]
    }
  });
  res.json(question)
});
router.post('/users/:userId/questionnaire/:questionnaireId/question/:questionId/update', async function (req, res, next) {
  var userId = req.params['userId']
  var questionnaireId = req.params["questionnaireId"]
  var questionId = req.params["questionId"]
  var questionUpdate = req.body
  console.log(questionUpdate)
  await Question.update(questionUpdate, {
    where: {
      [Op.and]: [
        { id: questionId },
        { questionnaireId: questionnaireId },
      ]
    }
  });
  var question = await Question.findOne({
    where: {
      [Op.and]: [
        { id: questionId },
      ]
    }
  })
  // console.log(question)
  res.json(question)
});
router.post('/users/:userId/questionnaire/:questionnaireId/setRecentlyUsed', async function (req, res, next) {
  console.log(req.params)
  var history = History.update({
    recentlyUsed: Date.now() / 1000
  }, {
    where: {
      questionnaireId: req.params["questionnaireId"],
      userId: req.params["userId"]
    }
  })
  res.json(history)
})
module.exports = router;
