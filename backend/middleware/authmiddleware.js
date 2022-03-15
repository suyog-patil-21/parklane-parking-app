//@ts-check
const jwt = require("jsonwebtoken");
const User = require("../model/User");

// FIXME : fix this verification

// ? Middleware : for authentic user to access the apis
const requireAuth = (req, res, next) => {
  // checking the token in header with name authorization
  const bearerToken = req.get("authorization");

  // * check json web token & is verified
  if (bearerToken) {
    const token = bearerToken.trim().split(" ")[1];
    jwt.verify(token, process.env.JWT_KEY, (err, decodedToken) => {
      if (err) {
        console.log("error in token :> ", err.message);
        res.status(403).send(err.message);
      } else {
        console.log(decodedToken);
        next();
      }
    });
  } else {
    if (bearerToken === undefined) {
      return res.status(400).send("Request header must content a Bearer token");
    }
    res.status(401).send("Invalid Token");
  }
};

// FIXME : check if this function helps 
// * checking the current user
const checkUser = (req, res, next) => {
  const bearerToken = req.get("authorization");
  if (bearerToken) {
    const token = bearerToken.trim().split(" ")[1];
    jwt.verify(token, process.env.JWT_KEY, async (err, decodedToken) => {
      if (err) {
        console.log("error in token :> ", err.message);
        res.locals.user = null;
        next();
      } else {
        console.log(decodedToken);
        let user = await User.findById(decodedToken.id);
        res.locals.user = user;
        next();
      }
    });
  } else {
    res.locals.user = null;
    next();
  }
};

module.exports = { requireAuth, checkUser };
