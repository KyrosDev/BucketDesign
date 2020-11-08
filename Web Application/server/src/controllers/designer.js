const Designer = require("../models/Designer");

async function getDesigners() {
    const result = Designer.find();
    return result;
}

async function getByUsername(username) {
    const result = await Designer.findOne({ username });
    return result;
}

async function getById(id) {
    const result = await Designer.findById(id);
    return result
}

async function getByEmail(email) {
    const result = await Designer.findOne({ email });
    return result;
}

async function getByProfession(id) {
    let result = [];
    const designers = await Designer.find();
    designers.map(designer => {
        if (designer.profession.id === id)
            result.push(designer);
    });
    return result;
}

module.exports = {
    getDesigners,
    getByUsername,
    getById,
    getByProfession,
    getByEmail,
};