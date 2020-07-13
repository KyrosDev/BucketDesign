const { Router } = require("express");
const router = Router();

// Models
const Designer = require("../models/Designer");

// Get all Designers
router.get("/", async (req, res) => {
  const designers = await Designer.find();
  res.json(designers);
});

// Create a new Designer
router.post("/", (req, res) => {
  const { username, image, biography, profession, location } = req.body;

  Designer.findOne({ username: username })
    .then((designer) => {
      if (designer === null) {
        const designer = new Designer({
          username,
          image,
          biography,
          profession,
          location,
        });

        designer
          .save()
          .then(() => res.json(designer))
          .catch((e) => console.log(e.message));
      } else {
        res.json({ error: "Username already exists" });
      }
    })
    .catch((e) => {
      if (e === "ValiditationError") {
        res.json({ error: `${e}` });
      }
    });
});

// Get Designer by id and Update
router.put("/:id", (req, res) => {
  const id = req.params.id;
  const { username, image, biography, profession, location } = req.body;

  Designer.findByIdAndUpdate(id, null, (err, designer) => {
    designer.username = username;
    designer.image = image;
    designer.biography = biography;
    designer.profession = profession;
    designer.location = location;
    Designer.updateOne(designer).then(
      res.json("Designer updated successfully!!! 🎇")
    );
  }).catch((e) => {
    console.log(e.toString());
  });
});

// Get Designer by id
router.get("/:id", (req, res) => {
  const id = req.params.id;
  Designer.findById(id)
    .then((designer) => {
      if (designer === null) res.status(404).json("Designer not found. 🆔");
      else res.json(designer);
    })
    .catch(() => {
      res.status(404).json("Designer not found. 🆔");
    });
});

// Delete a Designer by id
router.delete("/:id", (req, res) => {
  const id = req.params.id;
  Designer.findById(id)
    .then((designer) => {
      designer.deleteOne().then(() => {
        res.json("Deleted");
      });
    })
    .catch(() => {
      res.status(404).json("Designer not found. 🆔");
    });
});

module.exports = router;
