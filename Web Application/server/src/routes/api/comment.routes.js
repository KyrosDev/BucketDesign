const router = require("express").Router();
const controller = require("../../controllers/comment");
const { authenticate, isAdmin, checkToken } = require("../../middlewares");

router.post("/create", checkToken, async (req, res, next) => {
    const { post_id } = req.query;
    const { designer, body } = req.body;
    const result = await controller.createComment(designer, post_id, body);
    res.json(result);
});

router.post("/", authenticate, async (req, res, next) => {
    const { comment_id } = req.query;
    if (comment_id) {
        const result = controller.deleteComment(comment_id);
        res.json(result)
    } else next({ status: 400, message: "Please provide us your comment_id" });
});

router.get("/", async (req, res, next) => {
    const { post_id } = req.query;
    if (post_id) {
        const result = await controller.getPostComments(post_id);
        res.json(result);
    }
    else next({ status: 400, message: "Please provide us the post_id." });
});

module.exports = router;