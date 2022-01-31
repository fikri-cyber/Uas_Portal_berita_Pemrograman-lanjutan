import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({ Key? key }) : super(key: key);

  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Copyright'),
        backgroundColor: Colors.red[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image(image:  NetworkImage('https://images.unsplash.com/photo-1612442443556-09b5b309e637?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80'),
            ),
            SizedBox(

              height: 20,
            ),
            ListTile(
              title: Text('Copyright by Kelompok 1'), 
              subtitle: Text('Muhammad Fikri Ash D111811057'),
            ),
            ListTile(
               subtitle: Text('Salsabila Rizqia D111811019'),
            ),
            ListTile(
               subtitle: Text('Indah Elviyana D111811131'),
            ),
            ListTile(
               subtitle: Text('Kartika D111811053'),
            ),
          ],
        ),
      ),
    );
  }
}