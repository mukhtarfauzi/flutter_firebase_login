import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  static String routeName = 'login-page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final _formKey = GlobalKey<FormState>();

  bool _validateAndSave() {
    final _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      return true;
    }
    return false;
  }

  void _submit() async {
    if (_validateAndSave()) {
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        print("Singed in: ${user.uid}");
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                validator: (value) => value.isEmpty ? "Email cant empty" : null,
                decoration:
                    InputDecoration(hintText: "Email", labelText: "E-Mail"),
                onSaved: (value) => _email = value,
              ),
              TextFormField(
                validator: (value) =>
                    value.isEmpty ? "Password must fill" : null,
                decoration: InputDecoration(
                    hintText: "Password", labelText: "Password"),
                onSaved: (value) => _password = value,
              ),
              RaisedButton(
                child: Text("Login"),
                onPressed: _submit,
              ),
              FlatButton(
                child: Text("Create an Account"),
                onPressed: null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
