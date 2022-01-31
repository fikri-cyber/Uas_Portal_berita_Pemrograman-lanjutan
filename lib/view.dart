import 'package:flutter/material.dart';

class View extends StatefulWidget {
  //const View({ Key? key }) : super(key: key);
  List list;
  int index;
  View({required this.index, required this.list});

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: new Text("Detail Berita"),
        backgroundColor: Colors.red[900]
      ),
      body: Stack(
        children:[ new SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: new Center(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only
                (top: 20.0)),
                new Image.network(
                  "${widget.list[widget.index]['img']}",
                ),
                SizedBox (
                  height: 10.0,
                ),
                new Padding(padding:
                 const EdgeInsets.symmetric(horizontal: 8.0),
                 child: Column(
                   children: [
                     Text("${widget.list[widget.index]['title']}",
                     style: new TextStyle(
                       fontSize: 22.0,
                       fontWeight: FontWeight.w500
                       ),
                     ),
                     SizedBox(
                       height: 10.0,
                     ),
                     Row(children: [
                       Icon(Icons.person),
                       Text(
                         "",
                         style: TextStyle(
                           fontSize: 12.0,
                         ),
                       ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(Icons.date_range),
                       Text(
                         "",
                         style: TextStyle(
                           fontSize: 12.0,
                         ),
                       ),
                     ],
                    ),
                    SizedBox(height: 20.0,),
                    Text(
                      "${widget.list[widget.index]['short_desc']}",
                      style: TextStyle(
                        fontSize: 18.0
                      ),
                    ),
                  ],
                 ),
                ),
                new Text(
                  "${widget.list[widget.index]['desc']}",
                  style: new TextStyle(fontSize: 20.0),
                ),
                
              ],
            ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}