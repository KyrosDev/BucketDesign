// Packages
import 'package:flutter/material.dart';

// Widgets
import './recommended_content.dart';

class RecommendedCard extends StatelessWidget {

  final int index;
  final String author, profession;

  RecommendedCard(this.index, this.author, this.profession);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("Tapped"),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: 250.0,
          margin: EdgeInsets.all(20),
          child: Content(index, author, profession),
        )
      )
    );
  }
}