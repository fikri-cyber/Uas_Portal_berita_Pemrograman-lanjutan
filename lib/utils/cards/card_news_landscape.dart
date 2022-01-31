import 'package:flutter/material.dart';
import 'package:portal_berita/utils/custom_colors.dart';


class CardNewsLandscape extends StatelessWidget {
  
  String image, title, genre, publisher;
  VoidCallback onTap;
  CardNewsLandscape({required this.image, required this.title, required this.genre, required this.publisher, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.baseColor,
      child: InkWell(
        child: Row(
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              child: _sectionImage(image),
            ),
            Expanded(
              child: _sectionContent(title: title, genre: genre, publisher: publisher)
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  _sectionImage(String image){
    return Image.network(image);

  }

  _sectionContent({required String title, required String genre, required String publisher}){
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        Row(
          children: <Widget>[
            Text(
              genre,
              style: TextStyle(
                color: Colors.red
              ),
            ),
            Text(
              publisher,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}