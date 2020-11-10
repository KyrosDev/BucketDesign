const auth = require("../controllers/auth");
const jwt = require("jsonwebtoken");
const designerController = require("../controllers/designer");

function isAdmin(req, res, next) {
  const secret = req.header("X-Admin-Secret");
  if (secret === process.env.ADMIN_SECRET) return next();
  return next({ status: 401, message: "Not-Allowed. You need to be and admin to see the content of this route." });
}

function canCreate(req, res, next) {
  const user = req.header("Authorization");
  if (user) return next()
  return next({ status: 400, message: "Authentication is required! Log in and try again" });
}

async function authenticate(req, res, next) {
  const token = req.headers.authorization;
  if (token) {
    const designer = await designerController.getByToken(token);
    if (designer.status) return next(designer);
    const body = {
      username: designer.username,
      _id: designer._id,
      profile_picture: designer.profile_picture,
    }
    req.body = body;
    return next();
  }
  return next({ status: 400, message: "Authentication is required." })
}

async function checkToken(req, res, next) {
  const token = req.headers.authorization;
  if (token) {
    const result = await auth.checkValidUser(token);
    if (result) {
      const validToken = jwt.decode(token);
      req.body = { token: validToken };
      return next();
    }
    return next({ status: 401, message: "The token is invalid" })
  }
  return next({ status: 400, message: "Un-Authorizated. Please serve as your token" });
}

module.exports = {
  isAdmin,
  canCreate,
  checkToken,
  authenticate,
};