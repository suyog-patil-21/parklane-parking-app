//@ts-check
const User = require("../model/User");

module.exports.getCurrentUser_get = async (req, res) => {
  // * res.locals.tokenUserID = containes the Current token user id 
  const _id = res.locals.tokenUserID;
  if (!_id) res.status(401).json({ error: "Unauthorized" });
  try {
    const user = await User.findById(_id);
    if (user) {
      res
        .status(200)
        .json({ username: user.username, _id: user.id, email: user.email });
    }
  } catch (err) {
    console.log("\x1b[31m", err);
    // ! FIXME : debug try to check if their is error
    res.status(500).json({ error: err });
  }
};
