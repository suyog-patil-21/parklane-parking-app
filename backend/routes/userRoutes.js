const { Router } = require("express");
const router = Router();
const { requireAuth } = require("../middleware/authmiddleware");
const userController = require("../controller/userController");

router.get("/getCurrentUser", requireAuth, userController.getCurrentUser_get);

module.exports = router;
