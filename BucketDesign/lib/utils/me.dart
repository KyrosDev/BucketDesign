// Packages
import 'package:flutter/material.dart';

// Utils
import '../utils/Theme.dart';

// Models
import '../models/Designer.dart';
import '../models/Post.dart';
import '../models/Tags.dart';

Designer me = Designer(
  id: "kyrosdesignid",
  username: "Kyros Design",
  profileImage:
      "https://instagram.fcia1-1.fna.fbcdn.net/v/t51.2885-15/e35/99435530_688882545270142_7984536088211009073_n.jpg?_nc_ht=instagram.fcia1-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=fJIgQobqAOsAX_BgaHo&oh=5b0be728646f442dcd2db3ae258c1a8b&oe=5F1961EE",
  userProfession: Profession.UiDesigner,
  color: Colors.purple,
  biography:
      "📱 The app for every Digital Designer. Create 🎨, Share 🗣️ and have fun with Designers 👩‍🎨 from all the world 🌐.",
  posts: <Post>[
    Post(
      id: "postid",
      author: "Kyros Design",
      title: "Dev's Corner Process Logo",
      description:
          "I make this work for a team of developers. During the process i thinked much to create simply and cool at the same time.",
      difficulty: Difficulty.Intermediate,
      date: DateTime.now(),
      attachments: <String>[
        "https://instagram.fcia1-1.fna.fbcdn.net/v/t51.2885-15/e35/105967987_109298877395551_5200763215978526691_n.jpg?_nc_ht=instagram.fcia1-1.fna.fbcdn.net&_nc_cat=107&_nc_ohc=Ppo1ply0LQIAX-uPdFb&oh=874e680d34c2684485d9bf1599bb84b2&oe=5F1D5C99",
        "https://instagram.fcia1-1.fna.fbcdn.net/v/t51.2885-15/e35/105414467_934482380326018_3248675213670211155_n.jpg?_nc_ht=instagram.fcia1-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=g-m5iRgT5kQAX9RWEQ6&oh=cd4f94a23fe0ba506eb85dd8f148297f&oe=5F1D33A0",
      ],
      preview:
          "https://instagram.fcia1-1.fna.fbcdn.net/v/t51.2885-15/e35/105967987_109298877395551_5200763215978526691_n.jpg?_nc_ht=instagram.fcia1-1.fna.fbcdn.net&_nc_cat=107&_nc_ohc=Ppo1ply0LQIAX-uPdFb&oh=874e680d34c2684485d9bf1599bb84b2&oe=5F1D5C99",
      mediaType: MediaType.Photo,
      tags: <Tag>[
        Tag(
          name: "Graphic Design",
          shortcode: "graphic_design",
          id: "246dsf",
          color: CustomTheme.mainColor,
        ),
      ],
    ),
  ],
  postsCounter: 1,
);
