const jwt = require("jsonwebtoken");

const connection = require("../../database/connection");
const designers = connection.get("designers");

// Send error if auth error
const fttError = (res, next) => {
  res.status(422);
  const error = new Error("Email or Password is invalid. 😬");
  next(error);
};

// Create Token and send it to Front-end
function createTokenSendResponse(email, res, next) {
  jwt.sign(
    { email },
    process.env.SECRET_TOKEN,
    {
      expiresIn: "7d",
    },
    (err, token) => {
      if (err) {
        fttError(res, next);
      } else {
        designers
          .findOne({ email })
          .then((user) => {
            res.json({ designer: user, token, email });
          })
          .catch((e) => next(e));
      }
    }
  );
}

module.exports = {
  fttError,
  createTokenSendResponse,
};
