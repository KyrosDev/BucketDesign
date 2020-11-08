const Designer = require("../models/Designer");

async function register(body) {
    let result = null;
    const designer = new Designer(body);
    try {
        result = await designer.save();
    } catch (e) {
        return e;
    }
    return result;
}

async function login(body) {
    const designer = await Designer.findOne({email: body.email});
    if (designer) {
        
    }
    return "User not found";
}