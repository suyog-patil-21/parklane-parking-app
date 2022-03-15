//@ts-check
const User = require("../model/User");

module.exports.getCurrentUser_get = async (req, res) => {
  const _id = req.body.id;
  if (!_id) res.status(400).json({ error: "no _id pass in the body" });
  try {
    const user = await User.findById(_id);
    if (user) {
      res
        .status(200)
        .json({ username: user.username, _id: user.id, email: user.email });
    }
  } catch (err) {
    console.log("\x1b[31m", err);
    // ! FIXME : try to check if their is error
    res.status(500).json({ error: err });
  }
};
