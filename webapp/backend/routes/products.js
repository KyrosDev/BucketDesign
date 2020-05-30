const router = require('express').Router();
let Product = require('../models/Product.model');

router.route('/').get((req, res) => {
    Product.find()
    .then(products => res.json(products))
    .catch(err => res.status(400).json('Error: ' + err));
});

router.route('/new').post((req, res) => {
  const name = req.body.name;
  const description = req.body.description;
  const price = Number(req.body.price);
  const availability = req.body.availability;
  const worktime = req.body.worktime;

  const newProduct = new Product({
    name,
    description,
    price,
    availability,
    worktime,
  });
  newProduct.save()
  .then(() => res.json('Product added!'))
  .catch(err => res.status(400).json('Error: ' + err));
});

router.route('/:name').get((req, res) => {
    Product.findOne({"name": req.params.name})
      .then(product => res.json(product))
      .catch(err => res.status(400).json('Error: ' + err));
  });

router.route('/:name').delete((req, res) => {
    Product.findOneAndDelete({"name": req.params.name})
    .then(() => res.json('Product deleted.'))
    .catch(err => res.status(400).json('Error: ' + err));
});

router.route('/update/:name').post((req, res) => {
    Product.findOneAndUpdate({"name": req.params.name})
    .then(product => {
        product.name = req.body.name;
        product.description = req.body.description;
        product.price = Number(req.body.price);
        product.availability = Boolean(req.body.availability);
        product.worktime = req.body.worktime;

      product.save()
        .then(() => res.json('Product updated!'))
        .catch(err => res.status(400).json('Error: ' + err));
    })
    .catch(err => res.status(400).json('Error: ' + err));
});

module.exports = router;