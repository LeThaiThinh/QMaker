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
router.post(`/users/:userId/changePass`, async function (req, res, next) {
  var userId = req.params['userId']
  var password = req.body
  console.log(password)
  const user = await User.update(password, {
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
    var querydata_limit
    var querydata_searchByName
    var querydata_public
    var query_userId
    if (req.query['topic'] != null) {
      querydata_where_topic = { topic: req.query['topic'], }
    }
    if (req.query['questionId'] != null) {
      querydata_where_questionId = { questionId: req.query['questionId'], }
    }
    if (req.query['recentlyUsed'] != null) {
      querydata_order = [[{ model: User }, { model: History }, 'recentlyUsed', req.query['recentlyUsed']]]
      querydata_limit = 3
    }
    else {
      querydata_order = [['id', 'ASC']]; querydata_limit = 1000
    }
    if (req.query['name'] != null) {
      querydata_searchByName = {
        name: {
          [Op.substring]: req.query['name']
        },
      }
      querydata_public = {
        public: true
      }
    } else {
      query_userId = {
        userId: userId,
      }
    }
    var questionnaires = await Questionnaire.findAll({
      include: [{
        model: User,
        // attributes:[],
        through: {
          model: History,
          attributes: ['recentlyUsed', 'rating', 'score', 'totalTime', 'userId', 'questionnaireId']
        },
      }],
      where: {
        [Op.and]: [
          query_userId,
          querydata_where_topic,
          querydata_searchByName,
          querydata_public
        ]
      },
      attributes: [
        "id", "name", "description", "topic", "timeLimit", "public", "userId", "createdAt", "updatedAt",
      ],
      order: querydata_order,
      limit: querydata_limit,
    })
    console.log(questionnaires)
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
        { id: questionnaireId },
      ]
    },
  });
  console.log(questionnaire)
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
router.get('/users/:userId/questionnaire/:questionnaireId/rating', async function (req, res, next) {
  var userId = req.params['userId']
  var questionnaireId = req.params["questionnaireId"]
  var rating = await History.findOne({
    where: {
      questionnaireId: questionnaireId,
      rating: {
        [Op.not]: 0
      }
    },
    attributes: [[Sequelize.fn('AVG', Sequelize.col('rating')), 'avgRating'],],
  });
  res.json(rating)
});
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
router.post('/users/:userId/questionnaire/:questionnaireId/updateHistory', async function (req, res, next) {
  history = req.body
  history.recentlyUsed = Date.now() / 1000;
  history.userId = parseInt(req.params.userId);
  history.questionnaireId = parseInt(req.params.questionnaireId);
  history0 = await History.findOne({
    where: {
      questionnaireId: parseInt(req.params.questionnaireId),
      userId: parseInt(req.params.userId)
    }
  })
  if (history.rating == 0) history.rating = history0.rating
  if (history0 != null && history.score > history0.score) {
    await History.update(history, {
      where: {
        questionnaireId: parseInt(req.params.questionnaireId),
        userId: parseInt(req.params.userId)
      }
    })
  } else if (history0 != null && history.score == history0.score) {
    history.totalTime > history0.totalTime ?
      history.totalTime = history0.totalTime : {};
    await History.update(history, {
      where: {
        questionnaireId: parseInt(req.params.questionnaireId),
        userId: parseInt(req.params.userId)
      }
    })
  } else if (history0 != null && history.score < history0.score) {
    history.score = history0.score
    await History.update(history, {
      where: {
        questionnaireId: parseInt(req.params.questionnaireId),
        userId: parseInt(req.params.userId)
      }
    })
  } else if (history0 == null) {
    await History.create(history, {
      where: {
        questionnaireId: parseInt(req.params.questionnaireId),
        userId: parseInt(req.params.userId)
      }
    })
  }
  res.json(history)
})
router.post('/users/:userId/questionnaire/:questionnaireId/createHistory', async function (req, res, next) {
  var history = await History.findOne({
    where: {
      userId: req.params['userId'],
      questionnaireId: req.params['questionnaireId']
    }
  })

  if (history == null) {
    history = req.body
    history = await History.create(history)
  }

  res.json(history)
})
router.post('/users/:userId/questionnaire/:questionnaireId/delete', async function (req, res, next) {
  console.log(req.params)
  await Questionnaire.destroy({
    where: {
      id: req.params["questionnaireId"],
      userId: req.params["userId"]
    }
  })
  res.json()
})
router.post('/users/:userId/questionnaire/:questionnaireId/question/:questionId/delete', async function (req, res, next) {
  console.log(req.params)
  await Question.destroy({
    where: {
      id: req.params["questionId"],
    }
  })
  res.json()
})
module.exports = router;
