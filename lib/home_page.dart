import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:portal_berita/about_app.dart';
import 'package:portal_berita/add.dart';
import 'package:portal_berita/edit.dart';
import 'package:portal_berita/home_page.dart';
import 'package:portal_berita/login.dart';
import 'package:portal_berita/view.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);
  static String tag = 'home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();
   final TextEditingController _shortdescController = TextEditingController();
  //  final TextEditingController _image = TextEditingController();

   final CollectionReference _newsCollection =
      FirebaseFirestore.instance.collection('news');

      Future<void> _deleteProduct(String productId) async {
    await _newsCollection.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You Have SuccesFully Deleted a Product')));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        backgroundColor: Colors.red[900],
      ),
       drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Muhammad Fikri'),
              accountEmail: Text('fikrimuhammad206@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network('https://lh3.googleusercontent.com/ogw/ADea4I5yCJf5gorGlVarnIqUkxJEgI3C5y_b2B1GNJDaEdg=s83-c-mo',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.red[900]
              ),
              ),
            ListTile(
              leading: Icon(Icons.post_add),
              textColor: Colors.red[900],
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=> new Add()));
              },
              title: Text(
                'Tambah Data',
                style: TextStyle(color: Colors.red, fontSize: 20.0)
              )
            ),
            ListTile(
              leading: Icon(Icons.copyright),
              textColor: Colors.red[900],
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=> new AboutApp()));
              },
              title: Text(
                'AboutApp',
                style: TextStyle(color: Colors.red, fontSize: 20.0)
              )
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              textColor: Colors.red[900],
            onTap: () {
              Login.statusLogin = 0;
              Navigator.of(context).pushReplacementNamed(Login.tag);
            },
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.red, fontSize: 20.0)
              ),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
       ),
      body: StreamBuilder(
        stream: _newsCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return new Container(
                  padding: const EdgeInsets.all(10.0),
                  child: new GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new View(
                                list: streamSnapshot.data!.docs,
                                index: index))),
                    child: Card(
                      elevation: 2.0,
                      margin: EdgeInsets.only(bottom: 20),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(documentSnapshot['img']),
                                  fit: BoxFit.fill 
                                ),
                                borderRadius: BorderRadius.circular(8.0)
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(documentSnapshot['title'],
                                  style: TextStyle(
                                    fontSize: 18.0
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        documentSnapshot['short_desc'],
                                        style: TextStyle(
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () => Navigator.of(context).push(
                                          new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new Edit(
                                                    list:
                                                        streamSnapshot.data!.docs,
                                                    index: index),
                                          ),
                                        )),
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () =>
                                        _deleteProduct(documentSnapshot.id)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new Add())),
        child: Icon(Icons.add,),
      ),
    );
  }
}