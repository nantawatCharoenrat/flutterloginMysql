// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  final fromkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future sign_in() async {
    String url = "http://192.168.2.39/php/login.php"; 
    final response = await http.post(Uri.parse(url), body: {
      'email': email.text,
      'password': pass.text,
    });

    var data = json.decode(response.body);
    print(data);
    if (data == "Error") {
      Navigator.pushNamed(context, 'login');
    } else {
      await User.setsignin(true);
      Navigator.pushNamed(context, 'home');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: Form(
          key: fromkey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Project management system',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'To continue using this app',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Please login in first.',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset('assets/img/Picture.png'),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email or Username',
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Empty';
                        }
                        return null;
                      },
                      controller: email,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Empty';
                        }
                        return null;
                      },
                      controller: pass,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3F60A0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () {
                        bool pass = fromkey.currentState!.validate();

                        if (pass) {
                          sign_in();
                        }
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // TextButton(
                  //   style: TextButton.styleFrom(
                  //     textStyle: const TextStyle(fontSize: 15),
                  //   ),
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, 'register');
                  //   },
                  //   child: const Text("Didn't have any Account? Sign Up now"),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
