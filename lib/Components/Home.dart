
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/ANN.dart';
import 'package:flutter_application_1/Components/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Components/signup.dart';




class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    print('User signed in: ${user?.email}');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: Center(
          child:  Column(children: [
            // ElevatedButton(
            // onPressed: () {
              
            // },
            // child: Text('CNN'),
            // ),
            ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ImageUploadScreen()),
              );
            },
            child: Text('CNN'),
            )
            ,
          ],)
      ),
      ),
    );
  }
}