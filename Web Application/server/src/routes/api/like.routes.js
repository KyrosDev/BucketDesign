const router = require("express").Router();
const { authenticate, isAdmin } = require("../../middlewares");
const controller = require("../../controllers/like");

router.get("/", isAdmin, async (req, res, next) => {
    const result = await controller.getAllLikes();
    res.json(result);
});

router.post("/", authenticate, async (req, res, next) => {
    const { addLike, removeLike, post_id, comment_id } = req.query;
    const designer = req.body;
    let result = null;
    if (addLike) result = await controller.addLike(designer, post_id, comment_id);
    if (removeLike) result = await controller.removeLike(designer, post_id, comment_id);
    if (result.status)
        next(result);
    else
        res.json(result);
});

module.exports = router;