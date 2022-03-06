import 'package:firebase/services/auth.dart';
import 'package:firebase/view/widgets/my_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'email_sign_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  Future<void>_signInAnonymously() async{

    setState(() {
      // isLoadingleri değiştirme..
      _isLoading = true;
    });
    final user =
    await Provider.of<Auth>(context, listen: false)
        .signInAnonymously();

    setState(() {
      // Kullanıcı bilgisi geldikten sonra
      // false pozisyonuna aldık..
      _isLoading = false;
    });

    print(user?.uid);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                Provider.of<Auth>(context, listen: false).signOut();

                print('cikis yapildi');
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sing in Page"),
            SizedBox(
              height: 10,
            ),
            MyElevatedButton(

              color: Colors.orange,
              child: Text(
                "Sing in Anonymous",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _isLoading
                  ? null
                  : _signInAnonymously,

            ),
            SizedBox(
              height: 10,
            ),
            MyElevatedButton(
              color: Colors.yellow,
              child: Text(
                "Sing in Email/Password",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> EmailSignInPage()));
              },
            ),
            SizedBox(
              height: 10,
            ),
            MyElevatedButton(
              color: Colors.blue,
              child: Text(
                "Google Sing in",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  print('basildi');
                },
                child: Text('Buton bas')),
          ],
        ),
      ),
    );
  }
}
