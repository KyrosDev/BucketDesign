const express = require('express');
const expressLayouts = require('express-ejs-layouts');
const mongoose = require('mongoose');
const passport = require('passport');
const flash = require('connect-flash');
const fileUpload = require('express-fileupload');
const session = require('express-session');
const path = require('path')
const bodyParser = require("body-parser");

const app = express();
app.use(fileUpload());

app.use(bodyParser.urlencoded({
  extended: true
}));
app.use(bodyParser.json());

// Passport Config
require('./config/passport')(passport);

// DB Config
const db = require('./config/keys').mongoURI;

// Connect to MongoDB
mongoose
  .connect(
    db,
    {
      useUnifiedTopology: true,
      useNewUrlParser: true,
      useFindAndModify: false
    }
  )
  .then(() => {
    console.log('MongoDB Connected')
  })
  .catch(err => console.log(err));

// EJS
app.use(expressLayouts);
app.set('view engine', 'ejs');

// Express body parser
app.use(express.urlencoded({ extended: true }));

// Express session
app.use(
  session({
    secret: 'secret',
    resave: true,
    saveUninitialized: true
  })
);

// Passport middleware
app.use(passport.initialize());
app.use(passport.session());
app.use(express.static(path.join(__dirname, 'public')));

// Connect flash
app.use(flash());

// Global variables
app.use(function(req, res, next) {
  res.locals.success_msg = req.flash('success_msg');
  res.locals.error_msg = req.flash('error_msg');
  res.locals.error = req.flash('error');
  next();
});

require('./routes/designers.routes.js')(app);
require('./routes/post.routes.js')(app);

// Routes
app.use('/', require('./routes/index.js'));
app.use('/admin', require('./routes/admins.js'));
app.use('/profile', require('./routes/profile.js'));

const PORT = process.env.PORT || 5000;

app.listen(PORT, console.log(`Server started on port ${PORT}`));