import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class FullNewsPage extends StatefulWidget {
  var data;
  FullNewsPage({Key? key, this.data}) : super(key: key);

  @override
  State<FullNewsPage> createState() => _FullNewsPageState();
}

class _FullNewsPageState extends State<FullNewsPage> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    final String formatted = formatter.format(widget.data.publishedAt);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.grey,
            )),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.data.urlToImage))),
              ),
              Text(
                widget.data.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'source :' + widget.data.source.name,
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatted,
                    style: TextStyle(
                        color: Colors.grey[600], fontWeight: FontWeight.bold),
                  )
                ],
              ),
              // SizedBox(
              //   height: 5,
              // ),
              // Text(widget.data.description),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.data.content,
                style: TextStyle(fontSize: 17),
                textAlign: TextAlign.justify,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: MaterialButton(
                  color: Colors.grey,
                  onPressed: () async {
                    await launch(widget.data.url);
                  },
                  child: Text(
                    'Read more from website,',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
