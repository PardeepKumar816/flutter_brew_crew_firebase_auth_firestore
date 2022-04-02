import 'package:brew_crew/service/auth.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, this.toggleView}) : super(key: key);

  final Function? toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.brown[50],
            appBar: AppBar(
              title: Text('Sign in to Brew Crew'),
              backgroundColor: Colors.brown[400],
              elevation: 0,
              actions: [
                TextButton.icon(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () => widget.toggleView!(),
                    icon: Icon(Icons.person),
                    label: Text('Register'))
              ],
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Please Enter an Email' : null,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) => value!.length < 6
                          ? 'Password length must be 6+'
                          : null,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInUserWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'could not sign in';
                              loading = false;
                            });
                          }
                        }
                      },
                      child: Text('Sign In'),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      error,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
