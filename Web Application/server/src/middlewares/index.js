const auth = require("../controllers/auth");
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
    const body = {
      username: designer.username,
      _id: designer._id,
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
      const designer = await designerController.getByToken(token);
      req.body = { body: req.body, designer: { username: designer.username, _id: designer._id, } };
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