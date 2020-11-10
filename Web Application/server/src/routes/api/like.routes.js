const router = require("express").Router();
const middlewares = require("../../middlewares");
const controller = require("../../controllers/like");

router.get("/", middlewares.isAdmin, async (req, res, next) => {
    const result = await controller.getAllLikes();
    res.json(result);
});

router.post("/addLike", async (req, res, next) => {
    const { user_id, post_id, comment_id } = req.query;
    let result = null;
    if (!comment_id) {
        result = await controller.addLikeToPost(user_id, post_id);
    } else {
        result = await controller.addLikeToComment(user_id, comment_id);
    }
    if (result.status)
        next(result);
    else
        res.json(result);
});

router.delete("/removeLike", async (req, res, next) => {
    const { post_id, comment_id } = req.query;
    let result = null;
    if (!comment_id) result = await controller.removeLikeFromPost(post_id);
    else result = await controller.removeLikeFromComment(comment_id);
    if (result.status) next(result);
    else res.json(result);
});

module.exports = router;