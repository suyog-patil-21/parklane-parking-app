const User = require("../model/User");
const jwt = require("jsonwebtoken");

// * Handle Errors
var handleErrors = (err) => {
  // console.log(err.message, err.code);
  let errors = { email: "", password: "" };
  // ? incorrect email
  if (err.message === "Incorrect Email") {
    errors.email = "Email is not register";
  }
  // ? incorrect password
  if (err.message === "Incorrect Password") {
    errors.password = "That password is incorrect";
  }
  // ? duplicate code error
  if (err.code == 11000) {
    errors.email = "That email is already registered";
  }
  // ? validation error
  if (err.message.includes("user validation failed")) {
    Object.values(err.errors).forEach(({ properties }) => {
      errors[properties.path] = properties.message;
    });
  }
  return errors;
};

// * function for creating token taking the _id from the database of the users collection
//  Token Age is 3 hrs 3 * 60 * 60 = 10800
const maxAge = 10800;
const createToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_KEY, {
    expiresIn: maxAge,
  });
};

// * auth controllers
// TODO : implement a secure way to send json to the client
module.exports.signup_post = async (req, res) => {
  const { email, password, username } = req.body;
  try {
    const user = await User.create({ email, password, username });
    const token = createToken(user._id);
    res.status(201).json({ accessToken: token, _id : user._id });
  } catch (err) {
    const error = handleErrors(err);
    res.status(400).json({ error });
  }
};

module.exports.login_post = async (req, res) => {
  const { email, password } = req.body;
  try {
    const user = await User.login(email, password);
    const token = createToken(user._id);
    res.status(200).json({ accessToken: token, _id : user._id });
  } catch (err) {
    const error = handleErrors(err);
    res.status(400).json({ error });
  }
};

module.exports.logout_get = (req, res) => {
  const token = createToken('');
  res.status(200).json({accessToken:token});
};
