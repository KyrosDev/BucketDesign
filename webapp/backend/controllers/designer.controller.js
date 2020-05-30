const Designer = require('../models/Designer.js');
const bcrypt = require('bcryptjs');
const dir = require('../public/dir');



// Create and Save a new Note
exports.create = (req, res) => {

    const createDesigner = () => {
        // Create a Designer
        const designer = new Designer({
            name,
            username,
            biography,
            profile_picture_url,
            edge_follows,
            edge_followers,
            edge_posts,
            location,
            profession,
            email,
            password
        });

        bcrypt.genSalt(10, (err, salt) => {
            bcrypt.hash(designer.password, salt, (err, hash) => {
                if (err) throw err;
                designer.password = hash;

                // Save Note in the database
                designer.save()
                .then(data => {
                    res.send(data);
                }).catch(err => {
                    res.status(500).send({
                        message: err.message || "Some error occurred while creating the Note."
                    });
                });

            });
        });
    }

    const { name, username, biography, profile_picture_url, edge_follows, edge_followers, edge_posts, location, profession, email, password } = req.body;

    // Validate request
    if(!name || !username || !email || !password) {
        return res.status(400).send({
            message: "Required fields can not be empty"
        });
    }

    let createProcess = 0

    Designer.find({username: username}).then(designer => {
        if (designer)
            res.send({"message": "Username already taken"})
        else
            createProcess += 1;
            console.log(createProcess)
    }).catch(
        console.log("catch1")
    )

    Designer.find({email: email}).then(designer => {
        if (designer)
            res.send({"message": "Email already taken"})
        else
            createProcess += 1;
            console.log(createProcess)
            if (createProcess == 2)
                createDesigner()
    }).catch(
        console.log("catch2")
    )

}



// Retrieve and return all notes from the database.
exports.findAll = (req, res) => {
    Designer.find()
    .then(designer => {
        res.send(designer);
    }).catch(err => {
        res.status(500).send({
            message: err.message || "Some error occurred while retrieving notes."
        });
    });
};



// Find a single note with a noteId
exports.findOne = (req, res) => {
    Designer.findById(req.params.id)
    .then(designer => {
        if(!designer) {
            return res.status(404).send({
                message: "Note not found with id " + req.params.id
            });            
        }
        res.send(designer);
    }).catch(err => {
        if(err.kind === 'ObjectId') {
            return res.status(404).send({
                message: "Note not found with id " + req.params.id
            });                
        }
        return res.status(500).send({
            message: "Error retrieving note with id " + req.params.id
        });
    });
};



// Update a note identified by the noteId in the request
exports.update = (req, res) => {

    const { name, username, biography, profile_picture_url, edge_follows, edge_followers, edge_posts, location, profession, email, password } = req.body;
    // Validate Request
    if(!name || !username || !email || !password) {
        return res.status(400).send({
            message: "Required fields can not be empty"
        });
    }

    // Find note and update it with the request body
    Designer.findById(req.params.id, (err, designer) => {
        if (!err)
            if (!designer) {
                return res.status(404).send({
                    message: "Note not found with id " + req.params.id
                });
            }
            designer.name = name;
            designer.username = username;
            designer.biography = biography;
            designer.profile_picture_url = profile_picture_url;
            designer.edge_follows = edge_follows;
            designer.edge_followers = edge_followers;
            designer.edge_posts = edge_posts;
            designer.location = location;
            designer.profession = profession;
            designer.email = email;
            designer.password = password;

            bcrypt.genSalt(10, (err, salt) => {
                bcrypt.hash(designer.password, salt, (err, hash) => {
                    if (err) throw err;
                    designer.password = hash;
                    designer.save().then(() => {
                        res.send(designer)
                    }).catch(err => {
                        if(err)
                            res.status(400).send({"message": "Can't save modified fields"});
                    });
                });
            });
    })
};



// Delete a note with the specified noteId in the request
exports.delete = (req, res) => {
    Designer.findByIdAndRemove(req.params.id)
    .then(designer => {
        if(!designer) {
            return res.status(404).send({
                message: "Note not found with id " + req.params.id
            });
        }
        res.send({message: "Note deleted successfully!"});
    }).catch(err => {
        if(err.kind === 'ObjectId' || err.name === 'NotFound') {
            return res.status(404).send({
                message: "Note not found with id " + req.params.id
            });                
        }
        return res.status(500).send({
            message: "Could not delete note with id " + req.params.id
        });
    });
};


// Update a Designer applying the profile picture
exports.updatePic = (req, res) => {

    console.log(req.body)
    const files = req.body;
    const { mimetype } = files;


    if (!files || Object.keys(files).length === 0) {
        res.status(400).send({"message": "File not uploaded"});
        return;
    }

    console.log(files)

    const avatar = files.avatar;
    const fileName = req.user.username + "." + mimetype.split("/")[1];

    const uploadFile = dir.pictures + fileName;

    avatar.mv(uploadFile, (err) => {
        Designer.findOne({ username: req.params.username}).then(user => {
            user.updateOne({
                profile_picture_url: {
                    url: "http://localhost:5000/" + uploadFile,
                    contentType: avatar.mimetype 
                }
            }, (err) => {
                if (err)
                    res.status(400).send({"message": "File not uploaded"})
            })
        }).catch(err => {
            res.send(err)
        });

        if (err)
            res.status(500).send({"message": "I don't know what happend"});
    });

}
