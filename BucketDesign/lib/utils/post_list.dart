// Packages
import 'package:flutter/material.dart';

// Models
import '../models/Post.dart';
import '../models/Tags.dart';

List<Post> posts = [
  Post(
    id: "myfirstid",
    author: "Kyros Design",
    title: "Valentina ArtWork",
    description: "This amazing work was made by me for Valentina.",
    difficulty: Difficulty.Intermediate,
    date: DateTime.now(),
    attachments: [
      "https://instagram.fcia1-1.fna.fbcdn.net/v/t51.2885-15/e35/99435530_688882545270142_7984536088211009073_n.jpg?_nc_ht=instagram.fcia1-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=fJIgQobqAOsAX_BgaHo&oh=5b0be728646f442dcd2db3ae258c1a8b&oe=5F1961EE",
      "https://scontent-otp1-1.cdninstagram.com/v/t51.2885-15/e35/100781760_248063826413324_7965022550723737566_n.jpg?_nc_ht=scontent-otp1-1.cdninstagram.com&_nc_cat=108&_nc_ohc=jWCuoIyextkAX-gYPnv&oh=75208f8c44db75e56427ed181f9194e1&oe=5F1E0B36"
    ],
    preview:
        "https://instagram.fcia1-1.fna.fbcdn.net/v/t51.2885-15/e35/99435530_688882545270142_7984536088211009073_n.jpg?_nc_ht=instagram.fcia1-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=fJIgQobqAOsAX_BgaHo&oh=5b0be728646f442dcd2db3ae258c1a8b&oe=5F1961EE",
    mediaType: MediaType.Photo,
    tags: [
      Tag(
        name: "Graphic Design",
        shortcode: "graphic_design",
        id: "124dgs",
      ),
      Tag(
        name: "Web Design",
        shortcode: "web_design",
        id: "34652",
        color: Colors.red,
      ),
    ],
  ),
  Post(
    id: "mysecondid",
    author: "Media Design",
    title: "Never Stop, Keep Creating!",
    description: "This amazing work was made by me for Valentina.",
    difficulty: Difficulty.Intermediate,
    date: DateTime.now(),
    attachments: [
      "https://scontent-otp1-1.cdninstagram.com/v/t51.2885-15/e35/100781760_248063826413324_7965022550723737566_n.jpg?_nc_ht=scontent-otp1-1.cdninstagram.com&_nc_cat=108&_nc_ohc=jWCuoIyextkAX-gYPnv&oh=75208f8c44db75e56427ed181f9194e1&oe=5F1E0B36",
    ],
    preview:
        "https://scontent-otp1-1.cdninstagram.com/v/t51.2885-15/e35/100781760_248063826413324_7965022550723737566_n.jpg?_nc_ht=scontent-otp1-1.cdninstagram.com&_nc_cat=108&_nc_ohc=jWCuoIyextkAX-gYPnv&oh=75208f8c44db75e56427ed181f9194e1&oe=5F1E0B36",
    mediaType: MediaType.Photo,
    tags: [
      Tag(
        name: "Graphic Design",
        shortcode: "graphic_design",
        id: "124dgs",
      ),
    ],
  ),
  Post(
    id: "mythirdid",
    author: "Karl M.",
    title: "Un Semplice Ti Amo.",
    description: "This amazing work was made by me for Valentina.",
    difficulty: Difficulty.Intermediate,
    date: DateTime.now(),
    attachments: [
      "https://scontent-otp1-1.cdninstagram.com/v/t51.2885-15/e35/82562330_272512647140248_4367216450983926214_n.jpg?_nc_ht=scontent-otp1-1.cdninstagram.com&_nc_cat=104&_nc_ohc=zpdt00GbFBgAX9-vaau&oh=5160b727c020ec43ccaeba97c54d6d7b&oe=5F1CD6A1",
    ],
    preview:
        "https://scontent-otp1-1.cdninstagram.com/v/t51.2885-15/e35/82562330_272512647140248_4367216450983926214_n.jpg?_nc_ht=scontent-otp1-1.cdninstagram.com&_nc_cat=104&_nc_ohc=zpdt00GbFBgAX9-vaau&oh=5160b727c020ec43ccaeba97c54d6d7b&oe=5F1CD6A1",
    mediaType: MediaType.Photo,
    tags: [
      Tag(
        name: "Graphic Design",
        shortcode: "graphic_design",
        id: "124dgs",
      ),
    ],
  ),
  Post(
    id: "myfourthid",
    author: "Franco Martinez",
    title: "Your Kiss hurt Me.",
    description: "This amazing work was made by me for Valentina.",
    difficulty: Difficulty.Intermediate,
    date: DateTime.now(),
    attachments: [
      "https://scontent-otp1-1.cdninstagram.com/v/t51.2885-15/e35/93223155_127170552256846_7815318463050634127_n.jpg?_nc_ht=scontent-otp1-1.cdninstagram.com&_nc_cat=110&_nc_ohc=JAZz4HE0NswAX-aINLR&oh=b7650d9f583f47a76db1422e92f0bf02&oe=5F1DF875",
    ],
    preview:
        "https://scontent-otp1-1.cdninstagram.com/v/t51.2885-15/e35/93223155_127170552256846_7815318463050634127_n.jpg?_nc_ht=scontent-otp1-1.cdninstagram.com&_nc_cat=110&_nc_ohc=JAZz4HE0NswAX-aINLR&oh=b7650d9f583f47a76db1422e92f0bf02&oe=5F1DF875",
    mediaType: MediaType.Photo,
    tags: [
      Tag(
        name: "Graphic Design",
        shortcode: "graphic_design",
        id: "124dgs",
      ),
    ],
  ),
];
