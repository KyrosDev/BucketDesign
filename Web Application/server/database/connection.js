const monk = require('monk');
const db = monk("localhost/bucketdesign");

module.exports = db;