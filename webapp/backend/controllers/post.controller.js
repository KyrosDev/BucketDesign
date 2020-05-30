const Post = require('../models/Post');
//const Designer = require('../models/Designer');
//const dir = require('../public/dir');



//Create and Save a new Post
exports.create = (req, res) => {

    let shortcut;
    const characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    const charactersLength = characters.length;

    for (let i = 0; i < 10; i++) {
        shortcut += characters.charAt(Math.floor(Math.random() * charactersLength))
    }

    console.log(shortcut)

    const {
        image_urls,
        description,
        edge_likes,
        edge_comments
    } = req.body

    Post.find({shortcut: shortcut}).then(post => {
        if(post)
            return res.status(400).send({"message": "Shortcut already exists"});
        else {
            const post = new Post({
                author: req.params.id,
                shortcut,
                image_urls,
                description,
                edge_likes,
                edge_comments
            });
            
            post.save().then(post => {
                res.send(post)
            }).catch(err => {
                if (err)
                    res.send({"message": "post not uploaded"})
            });
        } 

    }).catch(err => {
        if(err)
            return res.status(400).send({"message": err});
    })

}