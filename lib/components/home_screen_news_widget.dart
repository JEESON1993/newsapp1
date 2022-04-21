import 'package:flutter/material.dart';

class HomeScreenNewsWidget extends StatelessWidget {
  String newsheadline, newsimage, smalldescription;
  HomeScreenNewsWidget(
      {Key? key,
      required this.newsheadline,
      required this.newsimage,
      required this.smalldescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              newsheadline,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      image: NetworkImage(newsimage), fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              smalldescription,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
