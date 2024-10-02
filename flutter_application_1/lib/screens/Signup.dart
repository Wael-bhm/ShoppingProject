import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/services/authService.dart';

class Signup extends StatelessWidget {
  final Function onclick;
  String _email = '', _password = '';
  final _auth = AuthService();
  Signup({super.key, required this.onclick});
  static String id = "Signup";
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBCD59),
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            Container(
              child: Image.asset(
                'assets/images/shop.png',
                alignment: Alignment.center,
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ),
              margin:
                  EdgeInsets.only(left: 100, right: 100, top: 50, bottom: 15),
              alignment: Alignment.center,
              width: 200,
              height: 200,
            ),
            Text(
              "ShopMarket",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Playwrite Ísland',
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 17, right: 15, bottom: 0),
              child: TextFormField(
                onTap: () {},
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Field is empty";
                  }
                  return null;
                },
                maxLength: 14,
                decoration: const InputDecoration(
                  hintText: "Enter Username",
                  fillColor: Color.fromARGB(197, 231, 241, 242),
                  filled: true,
                  prefixIcon:
                      Icon(Icons.verified_user_rounded), // Example icon usage
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 135, 133, 132),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
              child: TextFormField(
                onSaved: (value) {
                  _email = value!;
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Field is empty";
                  } else {
                    if (val.length > 14) {
                      return 'Forme invalide';
                    }
                  }
                  return null;
                },
                maxLength: 14,
                decoration: const InputDecoration(
                  hintText: "Enter your email or mobile number",
                  fillColor: Color.fromARGB(197, 231, 241, 242),
                  filled: true,
                  prefixIcon: Icon(Icons.email), // Example icon usage
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 135, 133, 132),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                onSaved: (value) {
                  _password = value!;
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Field is empty";
                  }
                  return null;
                },
                maxLength: 8,
                decoration: const InputDecoration(
                  hintText: 'Enter your password ',
                  fillColor: Color.fromARGB(197, 221, 230, 231),
                  filled: true,
                  prefixIcon: Icon(Icons.key_rounded), // Example icon usage
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 135, 133, 132),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 60,
              height: 50,
              margin: EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 20),
              decoration: BoxDecoration(
                  color: Color(0xFF88ae45),
                  borderRadius: BorderRadiusDirectional.circular(20)),
              child: MaterialButton(
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState?.save();
                    try {
                      print(_email);
                      print(_password);

                      final authresult = await _auth
                          .createUserWithEmailAndPassword(_email, _password);
                      print(authresult?.email);
                      print(_email + 'success');
                      if (authresult == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("nayki madreseti")));
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("nayki madreseti")));
                    }
                  }
                },
                child: Text(
                  "Sign in",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 100, top: 5),
              child: Row(
                children: [
                  Text(
                    "Do have an Account ?    ",
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'Signup');
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'Login');
                        },
                        child: Text(
                          "Log In",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
