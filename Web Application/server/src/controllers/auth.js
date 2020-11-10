const Designer = require("../models/Designer");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");

async function register(body) {
    let result = null;
    let token = null;
    const newPassword = await bcrypt.hash(body.password, 10);
    body.password = newPassword;
    const emailExists = await Designer.findOne({ email: body.email });
    if (!emailExists) {
        const usrExists = await Designer.findOne({ username: body.username });
        if (!usrExists) {
            const designer = new Designer(body);
            token = await jwt.sign({ _id: designer._id }, process.env.SECRET_TOKEN);
            designer.set("token", token);
            try {
                result = await designer.save();
            } catch (e) {
                return e;
            }
        } else
            return { status: 400, message: "Username already taken!" };
    } else
        return { status: 400, message: "Email already exists!" };
    return { token, user: result };
}

async function login(body) {
    const designer = await Designer.findOne({ email: body.email });
    if (designer) {
        const isEqual = await bcrypt.compare(body.password, designer.password);
        if (isEqual) {
            return designer;
        } else {
            return { status: 400, message: "Password doesn't match" };
        }
    }
    return { status: 404, message: "User not found" };
}

async function checkValidUser(userToken) {
    try {
        const valid = await jwt.verify(userToken, process.env.SECRET_TOKEN);
        if (valid) {
            return true;
        }
    } catch (e) {
        return false;
    }
}

module.exports = {
    login,
    register,
    checkValidUser,
};