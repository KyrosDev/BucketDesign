module.exports = (app) => {
    const designer = require('../controllers/designer.controller.js');

    // Create a new Designer Account
    app.post('/designer', designer.create);

    // Retrieve all Designer Account
    app.get('/designer', designer.findAll);

    // Retrieve a single Designer Account with noteId
    app.get('/designer/:id', designer.findOne);

    // Update a Designer Account with noteId
    app.put('/designer/:id', designer.update);

    // Update Designer Account Picture
    app.put('/designer/:username/picture', designer.updatePic)

    // Delete a Designer Account with noteId
    app.delete('/designer/:id', designer.delete);
}
