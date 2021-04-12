const express = require('express');
const router = express.Router();
const UserController = require('../controllers/user');
const checkAuth = require('../middleware/check-auth');



router.get('/profiles/personal',checkAuth,UserController.user_get_profile);
router.get('/profiles',checkAuth,UserController.user_profile);
router.post('/signup',UserController.user_signup);

router.post('/login',UserController.user_login);
// router.get('/logout',UserController.user_logout);

router.delete('/:userId',checkAuth,UserController.user_delete)

module.exports = router;