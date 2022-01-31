import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portal_berita/main.dart';

class Add extends StatefulWidget {
  const Add({ Key? key }) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _shortdescController = TextEditingController();
  TextEditingController _descall = TextEditingController();
  TextEditingController _image = TextEditingController();
  CollectionReference _newsCollection = FirebaseFirestore.instance.collection('news');

  Future<void> add([DocumentSnapshot? documentSnapshot]) async {
    final String? vartitle = _titleController.text;
    final String? varshortdesc = _shortdescController.text;
    final String? vardesc = _descall.text;
    final String? varimage = _image.text;
    await _newsCollection.add(
      //tambah image
      {
        "title" : vartitle,
        "short_desc" : varshortdesc,
        "desc" : vardesc,
        "img" : varimage
      });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new MyApp()),
    );
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: new Text("Tambah Data Berita"),
          backgroundColor: Colors.red[900],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _titleController,
                    minLines: 1,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'title',
                      labelStyle: TextStyle(
                        color: Colors.black 
                      ),
                      suffixIcon: Icon(
                        Icons.title
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                      ),
                    ),
                  ),
                    TextField(
                      controller: _shortdescController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 20,
                      decoration: InputDecoration(
                        labelText: 'Short desc',
                        labelStyle: TextStyle(
                        color: Colors.black 
                      ),
                      suffixIcon: Icon(
                        Icons.short_text
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                      ),
                      ),
                    ),
                    TextField(
                      controller: _descall,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 20,
                      decoration: InputDecoration(
                        labelText: 'Desc',
                        labelStyle: TextStyle(
                        color: Colors.black 
                      ),
                      suffixIcon: Icon(
                        Icons.description
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _image,
                    minLines: 1,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Image Url',
                      labelStyle: TextStyle(
                        color: Colors.black 
                      ),
                      suffixIcon: Icon(
                        Icons.image_search
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    child: new Text("Tambah Data", style: TextStyle( color: Colors.white),
                    ),
                    color: Colors.red.shade900,
                    onPressed: () => add()),
                    
                ],
              ),
            ),
          ),
      ),
    );
  }
}