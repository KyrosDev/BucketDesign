// Packages
import 'package:BucketDesign/utils/Theme.dart';
import 'package:flutter/material.dart';

class PostPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("asd"),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          height: 250,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(
                "https://instagram.fcia1-1.fna.fbcdn.net/v/t51.2885-15/e35/99435530_688882545270142_7984536088211009073_n.jpg?_nc_ht=instagram.fcia1-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=fJIgQobqAOsAX_BgaHo&oh=5b0be728646f442dcd2db3ae258c1a8b&oe=5F1961EE",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Kyros Design",
                    style: TextStyle(
                      color: CustomTheme.white,
                      fontSize: CustomTheme.subtitleSize,
                    ),
                  ),
                  Text(
                    "Valentina ArtWork",
                    style: TextStyle(
                      color: CustomTheme.white,
                      fontSize: CustomTheme.titleSize,
                    ),
                  ),
                  Text(
                    "2 Hours Ago",
                    style: TextStyle(
                      color: CustomTheme.white,
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
