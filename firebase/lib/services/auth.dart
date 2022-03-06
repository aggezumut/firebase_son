import 'package:firebase_auth/firebase_auth.dart';

class Auth {

  final _firebaseAuth = FirebaseAuth.instance;
  // servis içerisinde firebaseAuth objesi oluşturdum.
 // daha sonra singInAnonymously objesi oluşturuyorum...
  Future<User?> signInAnonymously()async{ //async olursa Future da olmalı

    final userCredentials = await _firebaseAuth.signInAnonymously();
    //bir şey döndürmem gerek ama. userCredential içerisindeki user'ı alacağım.
    return userCredentials.user; // Döndürülen şey user olduğundan bu sınıf user sınıfı
                                // void yerine user de
  }

  Future<User?> createUserWithEmailAndPassword(String email, String password) async{
    final userCredentials= await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredentials.user;
  }



  Future<void> signOut()async {
    //await FirebaseAuth.instance.signOut(); yerine
    await _firebaseAuth.signOut();
  }


  Stream<User?> autStatus(){
    return _firebaseAuth.authStateChanges();
  }
  // bu methop firebase ile konuşacak

}