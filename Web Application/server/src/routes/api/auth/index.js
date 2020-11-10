const router = require("express").Router();
const controller = require("../../../controllers/auth");

router.post("/login", async (req, res, next) => {
    const body = req.body;
    const cookies = req.cookies;
    if (cookies.__bucketdesign_user_token) {
        next({ status: 401, message: "Already logged in!" });
    } else {
        const result = await controller.login(body);
        if (result.message)
            next(result);
        else {
            res.cookie("__bucketdesign_user_token", result.token);
            res.json(result);
        }
    }
});

router.post("/register", async (req, res, next) => {
    const body = req.body;
    const result = await controller.register(body);
    if (result.message)
        next(result);
    else {
        res.cookie("__bucketdesign_user_token", result.token);
        res.json(result.user);
    }
});

router.get("/logout", (req, res, next) => {
    const token = req.cookies;
    if (token.__bucketdesign_user_token) {
        res.clearCookie("__bucketdesign_user_token");
        res.json({ message: "Logged out" });
    } else next({ status: 401, message: "You're not logged in." });
});

router.get("/authenticate", async (req, res, next) => {
    const token = req.headers.authorization;
    if (token) {
        const result = await controller.checkValidUser(token);
        if (result)
            res.status(200).json({ message: "User authenticated." });
        else
            next({ status: 401, message: "Invalid token" });
    } else {
        next({ status: 400, message: "Authentication is required" });
    }
});

module.exports = router;