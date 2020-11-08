const jwt = require("jsonwebtoken");

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

module.exports = {
  isAdmin,
  canCreate,
};