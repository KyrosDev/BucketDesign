const router = require("express").Router();
const { authenticate, checkToken, isAdmin } = require("../../middlewares/index");
const controller = require("../../controllers/post");
const designer = require("../../controllers/designer");

router.get("/", authenticate, async (req, res, next) => {
    const { id, author_id, author_username, shortcode, tag, type } = req.query;
    let result = null;
    if (author_id) result = await controller.getByAuthorID(author_id);
    if (id) result = await controller.getById(id);
    if (author_username) result = await controller.getByAuthorUsername(author_username);
    if (shortcode) result = await controller.getByShortcode(shortcode);
    if (tag) result = await controller.getByTag(tag);
    if (type) result = await controller.getByType(type);
    res.json(result);
});

router.post("/create", checkToken, async (req, res, next) => {
    const { designer, body } = req.body;
    const result = await controller.createPost(designer, body);
    res.json(result);
});

router.get("/getFeed", authenticate, async (req, res, next) => {
    const { token } = req.body;
    const user = await designer.getById(token._id);
    const result = await controller.getFeed(user.edge_follows.follows);
    res.json(result);
});

router.get("/all", isAdmin, async (req, res, next) => {
    const result = await controller.getPosts();
    res.json(result);
});

module.exports = router;