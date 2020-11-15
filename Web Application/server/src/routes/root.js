const router = require("express").Router();

router.get("/", (req, res, next) => {
    res.redirect("https://www.youtube.com");
});

module.exports = router;