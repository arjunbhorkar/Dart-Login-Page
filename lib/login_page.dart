import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0), 
              Text(
                'Login Information',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20.0), 
              TextFormField(
                  onSaved: (value) => _email = value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email Address")),
              TextFormField(
                  onSaved: (value) => _password = value,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password")),
              SizedBox(height: 20.0), 
              RaisedButton(
                  child: Text("LOGIN"),
                  onPressed: () async {
       final form = _formKey.currentState;
       form.save();

       if (form.validate()) {
         try {
           FirebaseUser result =
               await Provider.of<AuthService>(context , listen: false).loginUser(
                   email: _email, password: _password);
           print(result);  
         } on AuthException catch (error) {
           print('error');
         } on Exception catch (error) {    
           print('error');
         }
       }
     },),
            ],
          ),
        ),
      ),
    );
  }



}
