import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/services/auth.dart';
import 'package:firebase/view/sing_in_page.dart';
import 'package:firebase/view/widgets/on_board2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: FirebaseOptions(
      apiKey: "AIzaSyCse9Z23WNILyMfVX5SFOi8Xy9CRFpQOQ8", // Your apiKey
      appId: "1:869815449112:android:dce8b9b58e8467fc67756d",


      messagingSenderId: "869815449112", // Your messagingSenderId
      projectId: "fir-firebase-app-234ad", // Your projectId
    ),

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
      create: (context)=> Auth(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const OnBoardWidget(),
      ),
    );
  }
}

