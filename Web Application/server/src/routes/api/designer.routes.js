const router = require("express").Router();
const middleware = require("../../middlewares");
const controller = require("../../controllers/designer");

router.get("/", async (req, res, next) => {
    let result = null;
    const { id, username, pid, email } = req.query;
    if (id) result = await controller.getById(id);
    if (username) result = await controller.getByUsername(username);
    if (pid) result = await controller.getByProfession(pid);
    if (email) result = await controller.getByEmail(email);
    if (result)
        res.json(result);
    else next({ status: 404, message: "User not found" });
});

router.get("/all", middleware.isAdmin, async (req, res, next) => {
    const result = await controller.getDesigners();
    res.json(result);
});

router.get("/token/:token", async (req, res, next) => {
    const { token } = req.params;
    const result = await controller.getByToken(token);
    res.json(result);
});

module.exports = router;