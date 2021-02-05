import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'model/authentication.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // logo
            buildLogo(),
            SizedBox(
              height: 50,
            ),
            Text(
              'Welcome back!',
              style: TextStyle(fontSize: 24),
            ),

            SizedBox(
              height: 50,
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LoginForm(),
            ),

// signin with google
            OutlineButton(
              color: Colors.blue,
              splashColor: Colors.grey,
              onPressed: () {
                // signin
                AuthenticationProvider().signInWithGoogle().then((result) {
                  if (result != null) {
                    Navigator.pushReplacementNamed(context, '/');
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('error'),
                    ));
                  }
                });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              child: Text('Login with google'),
            ),

// signin with facebook
            // OutlineButton(
            //   color: Colors.blue,
            //   splashColor: Colors.grey,
            //   onPressed: () {
            //     // signin
            //     AuthenticationProvider().signInWithGoogle().then((result) {
            //       if (result != null) {
            //         Navigator.pushReplacementNamed(context, '/');
            //       } else {
            //         Scaffold.of(context).showSnackBar(SnackBar(
            //           content: Text('error'),
            //         ));
            //       }
            //     });
            //   },
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(40)),
            //   child: Text('Login with Facebook'),
            // ),

            Row(
              children: <Widget>[
                Text('New here', style: TextStyle(fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text('Get Registered Now!!',
                      style: TextStyle(fontSize: 20, color: Colors.blue)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildLogo() {
    return Container(
      height: 80,
      width: 80,
      // padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.blue),
      child: Center(
        child: Text(
          "T",
          style: TextStyle(color: Colors.white, fontSize: 60.0),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TextFormField(
            // initialValue: 'Input text',
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email_outlined),
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  const Radius.circular(100.0),
                ),
              ),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (val) {
              email = val;
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            // initialValue: 'Input text',
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  const Radius.circular(100.0),
                ),
              ),
              suffixIcon: Icon(
                Icons.visibility_off,
              ),
            ),
            onSaved: (val) {
              password = val;
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          RaisedButton(
            onPressed: () {
              // Respond to button press

              if (_formKey.currentState.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.

                _formKey.currentState.save();

                AuthenticationProvider()
                    .signIn(email: email, password: password)
                    .then((result) {
                  if (result == null) {
                    Navigator.pushReplacementNamed(context, '/');
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                        result,
                        style: TextStyle(fontSize: 16),
                      ),
                    ));
                  }
                });
              }
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            color: Colors.blue[400],
            textColor: Colors.white,
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
