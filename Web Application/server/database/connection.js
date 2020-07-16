const monk = require('monk');
const db = monk(process.env.MONGODB_URI || "localhost/bucketdesign");

module.exports = db;