const router = require("express").Router();
const middleware = require("../../middlewares");
const controller = require("../../controllers/post");

router.get("/", async (req, res, next) => {
    const { id, author_id, author_username, shortcode, tag, type } = req.query;
    let result = null;
    if (author_id) result = await controller.getByAuthorID(author_id);
    if (id) result = await controller.getById(id);
    if (author_username) result = await controller.getByAuthorUsername(author_username);
    if (shortcode) result = await controller.getByShortcode(shortcode);
    if (tag) result = await controller.getByTag(tag);
    if (type) result = await controller.getByType(type);
    if (result)
        res.json(result);
    else next({ status: 404, message: "Post not found" });
});

router.get("/all", middleware.isAdmin, async (req, res, next) => {
    const result = await controller.getPosts();
    res.json(result);
});

router.post("/create/", middleware.canCreate, async (req, res, next) => {
    const body = req.body;
    const result = await controller.createPost(body);
    if (!result.errors)
        res.json(result);
    else
        next({ status: 400, message: result.message });
});

module.exports = router;