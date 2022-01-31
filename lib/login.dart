import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portal_berita/home_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static String tag = 'login-page';
  static int statusLogin = 0;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  CollectionReference _newsCollection =
      FirebaseFirestore.instance.collection('admin');

  Future<void> login([DocumentSnapshot? documentSnapshot]) async {
    final String? varuser = _username.text;
    final String? varpwd = _password.text;
    var result = await _newsCollection
        .where("user", isEqualTo: varuser)
        .where("pwd", isEqualTo: varpwd)
        .get();
    if (result.docs.length == 1) {
      Login.statusLogin = 1;
      Navigator.of(context).pushReplacementNamed(HomePage.tag);
    } else {
      var snackBar = const SnackBar(
        content: Text('username atau Password Salah'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    Future(() {
      if (Login.statusLogin == 1) {
        Navigator.of(context).pushReplacementNamed(HomePage.tag);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40,),
            Icon(Icons.account_circle_rounded, size: 100.0, color: Colors.red[900],),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _username,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter Valid Username'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
              child: TextField(
                controller: _password,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Masukan Password'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.red[900], borderRadius: BorderRadius.circular(20)),
              child: MaterialButton(
                onPressed: () {
                  login();
                },
                
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
