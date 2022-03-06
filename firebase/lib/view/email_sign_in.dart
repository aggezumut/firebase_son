import 'package:email_validator/email_validator.dart';
import 'package:firebase/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


enum FormStatus { signIn, register }

class EmailSignInPage extends StatefulWidget {
  const EmailSignInPage({Key? key}) : super(key: key);

  @override
  _EmailSignInPageState createState() => _EmailSignInPageState();
}

class _EmailSignInPageState extends State<EmailSignInPage> {
  FormStatus _formStatus = FormStatus.signIn;
  TextEditingController _password1 = TextEditingController();
  TextEditingController _password2 = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _formStatus == FormStatus.signIn
          ? buildsignInForm()
          : buildRegistersignInForm(),
    );
  }

  Form buildsignInForm() {
    final _signInFormKey= GlobalKey<FormState>();

    return Form(
      key: _signInFormKey,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Giriş Yapınız',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value){
                if (EmailValidator.validate(value)){
                  return null;
                }
                else{return 'lütfen geçerli bir adres giriniz';}
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                labelText: 'E-mail',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value){
                if(value!.length<6){
                      return 'Şifreniz en az 6 karakter içermeli';
                }else{
                  return null;
                }
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)),
                  labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {
              print(_signInFormKey.currentState!.validate());

            }, child: Text('Giriş Yap')),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _formStatus = FormStatus.register;
                  });
                },
                child: Text('Kayıt ol'))
          ],
        ),
      ),
    );
  }

  Form buildRegistersignInForm() {
    final _registerFormKey = GlobalKey<FormState>();
    return Form(
      key: _registerFormKey,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Kayıt Sayfası',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              validator: (value){
                if (EmailValidator.validate(value)){
                  return null;
                }
                else{return 'lütfen geçerli bir adres giriniz';}
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  )),
            ),
            SizedBox(height: 10,),
            TextFormField(
              validator: (value){
                if(value!.length<6){
                  return 'Şifreniz en az 6 karakter içermeli';
                }else{
                  return null;
                }
              },
              controller: _password1,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14))
              ),
            ),
            SizedBox(height: 10,),

            TextFormField(
                controller: _password2,
              validator: (value){
                  if(value!= _password1.text){return 'Şifreler aynı değil';}
                  else{return null;}

              },

              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: ' Again Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14))
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () async{
              if(_registerFormKey.currentState!.validate()){
                final user= await Provider.of<Auth>(context,listen:false).createUserWithEmailAndPassword(_emailController.text, _password1.text);
                print(user!.uid);

                if (user!= null && !user.emailVerified) {
                  await user.sendEmailVerification();
                }

                await _showMyDialog();


                setState(() {
                  _formStatus == FormStatus.signIn;
                });

              }
            },
                child: Text('Kayıt ol')),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _formStatus = FormStatus.signIn;
                  });
                },
                child: Text('Zaten kayıt oldum. Giriş Yap ...'))
          ],
        ),
      ),
    );
  }


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Onay Gerekli'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Merhaba, lütfen mailinizi kontrol ediniz'),
                Text('Onay linkine tıklayıp tekrar giriş yapmalısınız'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Anladım'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
