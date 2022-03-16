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
        res.locals.tokenUserID = null;
        res.status(403).send(err.message);
      } else {
        console.log(decodedToken);
        res.locals.tokenUserID = decodedToken.id;
        next();
      }
    });
  } else {
    res.locals.tokenUserID = null;
    if (bearerToken === undefined) {
      return res.status(400).send("Request header must content a Bearer token");
    }
    res.status(401).send("Invalid Token");
  }
};

module.exports = { requireAuth };
