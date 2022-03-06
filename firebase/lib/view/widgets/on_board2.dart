import 'package:firebase/services/auth.dart';
import 'package:firebase/view/HomePage.dart';
import 'package:firebase/view/sing_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoardWidget extends StatefulWidget {
  const OnBoardWidget({Key? key}) : super(key: key);
  @override
  _OnBoardWidgetState createState() => _OnBoardWidgetState();
}
class _OnBoardWidgetState extends State<OnBoardWidget> {

  @override

  @override
  Widget build(BuildContext context) {

    final _auth=Provider.of<Auth>(context,listen:false);

    return StreamBuilder<User?>(
      stream: _auth.autStatus(),
      builder: (
          // verinin paketlendiği sınıf = snapshat
          // paketin ne olduğunu bilmiyorsak dynamic yaz
          BuildContext context, AsyncSnapshot<dynamic>snapshot){
          if(snapshot.connectionState==ConnectionState.active){
            // verinin gelip gelmediğini kontrol et.
            //bağlantı durumu (connectionState) aktif mi
            return snapshot.data!= null ? HomePage():SignInPage();
          }
          else{
            return SizedBox(height: 300,width: 300,child: CircularProgressIndicator(),);
          }
      }
    );
  }
}


