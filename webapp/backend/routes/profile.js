const express = require('express');
const router = express.Router();
const dirname = require('../public/dir.js');
const HOST = "localhost:5000/uploads/"

const Designer = require('../models/Designer');

router.get('/asd', (req, res) => {res.render('login')})

router.post('/upload', (req, res) => {
    let avatar;
    let uploadPath;

    if (!req.files || Object.keys(req.files).length === 0) {
      res.status(400).send('No files were uploaded.');
      return;
    }
  
    avatar = req.files.avatar;
    console.log(avatar)
    const fileName = req.user.username + "." + avatar.mimetype.split("/")[1]
  
    uploadPath = dirname + fileName;
  
    avatar.mv(uploadPath, (err) => {
        Designer.findById(req.user._id).then( user => {
            user.updateOne({
                profile_picture_url: {
                    url: HOST + fileName,
                    contentType: req.files.avatar.mimetype
                }
            }, (err) => {
                if (err)
                    console.log(err)
                else
                    console.log(user)
            });
            res.render("dashboard", {user: req.user})
        }).catch(err => {
            res.send(err)
        });
        if (err)
            res.send(err)
    });
});

module.exports = router;