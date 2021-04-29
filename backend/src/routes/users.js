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
router.get(`/users/:userId`, async function (req, res, next) {
  var userId = parseInt(req.params['userId'])
  const user = await User.findOne({
    where: { id: userId }
  })
  res.json(user);
});
router.post(`/users/:userId/changePass`, async function (req, res, next) {
  var userId = parseInt(req.params['userId'])
  var password = req.body
  console.log(password)
  await User.update(password, {
    where: { id: userId }
  })
  var user = await User.findOne({
    where: { id: userId }

  })
  console.log(user)
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
router.post('/questionnaire/create', async function (req, res, next) {
  try {
    var questionnaire = req.body
    var userId = req.body.userId
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
router.get('/questionnaire', async function (req, res, next) {
  try {
    var userId = req.query.userId
    var querydata_where_topic
    var querydata_order
    var querydata_limit
    var querydata_searchByName
    var querydata_public
    var query_userId
    if (req.query['topic'] != "") {
      querydata_where_topic = { topic: req.query['topic'], }
    }
    if (req.query['questionId'] != "") {
      querydata_where_questionId = { questionId: req.query['questionId'], }
    }
    if (req.query['recentlyUsed'] != "") {
      querydata_order = [[{ model: User }, { model: History }, 'recentlyUsed', req.query['recentlyUsed']]]
      querydata_limit = 3
    }
    else {
      querydata_order = [['id', 'ASC']]; querydata_limit = 1000
    }
    if (req.query['name'] != "") {
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
    res.json(questionnaires);
  } catch (err) {
    console.log(err);
  }
});
router.get('/questionnaire/:questionnaireId', async function (req, res, next) {
  var userId = req.query.userId
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
  res.json(questionnaire)

});
router.get('/questionnaire/:questionnaireId/rating', async function (req, res, next) {
  var userId = req.query.userId
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
  if (rating.dataValues.avgRating == null)
    rating = { avgRating: '0' };
  res.json(rating)
});
router.post('/question/create', async function (req, res, next) {
  var questionnaireId = req.query.questionnaireId
  var question = req.body
  question.questionnaireId = parseInt(questionnaireId)
  var question = await Question.create(question)
  // //clear history
  // await History.destroy({
  //   where: {
  //     [Op.and]: {
  //       questionnaireId: questionnaireId,
  //       userId: { [Op.not]: userId }
  //     }
  //   }
  // })
  // newHistory = {
  //   totalTime: 0,
  //   score: 0,
  //   rating: 0,
  //   recentlyUsed: 0,
  // }
  // await History.update(newHistory, {
  //   where: {
  //     [Op.and]: {
  //       questionnaireId: questionnaireId,
  //       userId: userId,
  //     }
  //   }
  // })
  res.json(question);
})
router.get('/question', async function (req, res, next) {
  var userId = req.query.userId
  var questionnaireId = req.query.questionnaireId
  var question = await Question.findAll({
    where: {
      [Op.and]: [
        { questionnaireId: questionnaireId },
      ]
    }
  });
  res.json(question)
});
router.post('/question/:questionId/update', async function (req, res, next) {
  var questionnaireId = req.body.questionnaireId
  var questionId = req.params["questionId"]
  var questionUpdate = req.body
  console.log(questionUpdate)
  // //clear history
  // await History.destroy({
  //   where: {
  //     [Op.and]: {
  //       questionnaireId: questionnaireId,
  //       userId: { [Op.not]: userId }
  //     }
  //   }
  // })
  // newHistory = {
  //   totalTime: 0,
  //   score: 0,
  //   rating: 0,
  //   recentlyUsed: 0,
  // }
  // await History.update(newHistory, {
  //   where: {
  //     [Op.and]: {
  //       questionnaireId: questionnaireId,
  //       userId: userId,
  //     }
  //   }
  // })
  //update Question
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
  res.json(question)
});
router.post('/questionnaire/:questionnaireId/updateHistory', async function (req, res, next) {
  var userId = req.body.userId
  var questionnaireId = req.params['questionnaireId']

  history = req.body
  history.recentlyUsed = Date.now() / 1000;
  history.userId = parseInt(userId);
  history.questionnaireId = parseInt(questionnaireId);
  history0 = await History.findOne({
    where: {
      questionnaireId: parseInt(questionnaireId),
      userId: parseInt(userId)
    }
  })
  if (history.rating == 0) history.rating = history0.rating
  if (history0 != null && history.score > history0.score) {
    await History.update(history, {
      where: {
        questionnaireId: parseInt(questionnaireId),
        userId: parseInt(userId)
      }
    })
  } else if (history0 != null && history.score == history0.score) {
    history.totalTime > history0.totalTime ?
      history.totalTime = history0.totalTime : {};
    await History.update(history, {
      where: {
        questionnaireId: parseInt(questionnaireId),
        userId: parseInt(userId)
      }
    })
  } else if (history0 != null && history.score < history0.score) {
    history.score = history0.score
    await History.update(history, {
      where: {
        questionnaireId: parseInt(questionnaireId),
        userId: parseInt(userId)
      }
    })
  } else if (history0 == null) {
    await History.create(history, {
      where: {
        questionnaireId: parseInt(questionnaireId),
        userId: parseInt(userId)
      }
    })
  }
  res.json(history)
})
router.post('/questionnaire/:questionnaireId/createHistory', async function (req, res, next) {
  var userId = req.body.userId
  var history = await History.findOne({
    where: {
      userId: userId,
      questionnaireId: req.params['questionnaireId']
    }
  })

  if (history == null) {
    history = req.body
    history = await History.create(history)
  }

  res.json(history)
})
router.post('/questionnaire/:questionnaireId/delete', async function (req, res, next) {
  var userId = req.body.userId
  console.log(req.params)
  await Questionnaire.destroy({
    where: {
      id: req.params["questionnaireId"],
      userId: userId
    }
  })
  res.json()
})
router.post('/question/:questionId/delete', async function (req, res, next) {
  console.log(req.params)
  var userId = req.body.userId
  var questionnaireId = req.body.questionnaireId
  // //clear History
  // await History.destroy({
  //   where: {
  //     [Op.and]: {
  //       questionnaireId: questionnaireId,
  //       userId: { [Op.not]: userId }
  //     }
  //   }
  // })
  // newHistory = {
  //   totalTime: 0,
  //   score: 0,
  //   rating: 0,
  //   recentlyUsed: 0,
  // }
  // await History.update(newHistory, {
  //   where: {
  //     [Op.and]: {
  //       questionnaireId: questionnaireId,
  //       userId: userId,
  //     }
  //   }
  // })
  //delete question
  await Question.destroy({
    where: {
      id: req.params["questionId"],
    }
  })
  res.json()
})
module.exports = router;
