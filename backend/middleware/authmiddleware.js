const jwt = require("jsonwebtoken");

// FIXME : fix this verification

// ? Middleware : for authentic user to access the apis 
const requireAuth = (req, res, next) => {
  const bearerToken = req.get("authorization");

  // * check json web token & is verified
  if (bearerToken) {
    const token = bearerToken.trim().split(" ")[1];
    jwt.verify(token, process.env.JWT_KEY, (err, decodedToken) => {
      if (err) {
        console.log("error in token :> ",err.message);
        res.status(403).send(err.message);
      } else {
        console.log(decodedToken);
        next();
      }
    });
  } else {
    if (bearerToken === undefined){
        return res.status(400).send('Request header must content a Bearer token');
    }
    res.status(401).send("Invalid Token");
  }
};

module.exports = { requireAuth };
