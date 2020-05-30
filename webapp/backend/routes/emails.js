const router = require('express').Router();
let Email = require('../models/Emails.model');

router.route('/').get((req, res) => {
    Email.find()
    .then(emails => res.json(emails))
    .catch(err => res.status(400).json('Error: ' + err));
});

router.route('/new').post((req, res) => {
  const name = req.body.name;
  const email = req.body.email;
  const message = req.body.message;
  const isResolved = false;

  const newEmail = new Email({
    name,
    email,
    message,
    isResolved,
  });

  newEmail.save()
  .then(() => res.json(true))
  .catch(err => res.status(400).json('Error: ' + err));
});

router.route('/:id').get((req, res) => {
  Email.findOne({"id": req.params.id}).then(emails => res.json(emails)).catch(err => res.status(400).json('Error: ' + err));
});

router.route('/resolve/:id').post((req, res) => {
  console.log(req)
  Email.findOneAndUpdate({"id": req.params.id})
  .then(email => {
      email.isResolved = req.body.isResolved;

      email.save()
      .then(() => res.json(true, email.isResolved))
      .catch(err => res.status(400).json('Error: ' + err));
  })
  .catch(err => res.status(400).json('Error: ' + err));
});

router.route('/:id').delete((req, res) => {
  Email.findOneAndDelete({"id": req.params.id})
  .then(() => res.json(true))
  .catch(err => res.status(400).json('Error: ' + err));
});

module.exports = router;