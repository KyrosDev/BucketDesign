const router = require("express").Router();
const controller = require("../../controllers/follow");
const { authenticate } = require("../../middlewares");

router.get("/getFollowers", authenticate, async (req, res, next) => {
    const { designer_id } = req.query;
    const result = await controller.getFollowers(designer_id);
    res.json(result);
});

router.post("/follow", authenticate, async (req, res, next) => {
    const designer = req.body;
    const { user_id } = req.query;
    const result = await controller.follow(designer, user_id);
    console.log(result);
    if (result.status) {
        next(result);
    } else {
        res.json(result);
    }
});

router.post("/unfollow", authenticate, async (req, res, next) => {
    const designer = req.body;
    const { user_id } = req.query;
    const result = await controller.unfollow(designer, user_id);
    res.json(result);
});

router.get("/getFollowing", authenticate, async (req, res, next) => {
    const designer = req.body;
    const result = await controller.getFollowing(designer);
    res.json(result);
});

module.exports = router;