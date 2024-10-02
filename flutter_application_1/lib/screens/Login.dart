import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/provider/Modelhud.dart';
import 'package:flutter_application_1/provider/adminMode.dart';
import 'Home.dart';
import 'package:flutter_application_1/services/authService.dart';
import 'package:flutter_application_1/admin/adminHome.dart';

class Login extends StatefulWidget {
  static String id = 'LoginScreen';
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  static String id = "Login";
  static const kMainColor = Color(0xFFFFC107);
  String email = '';
  String password = '';
  final auth = AuthService();

  final adminPassword = 'Admin1234';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Container(
        child: Form(
          key: widget.globalKey,
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
                margin: EdgeInsets.only(
                    left: 100, right: 100, top: 100, bottom: 15),
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
                padding:
                    EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 5),
                child: TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Field is empty";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                  maxLength: 50,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    fillColor: Color.fromARGB(197, 231, 241, 242),
                    filled: true,
                    prefixIcon: Icon(Icons.email),
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
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Field is empty";
                    }
                    return null;
                  },
                  maxLength: 20,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    fillColor: Color.fromARGB(197, 221, 230, 231),
                    filled: true,
                    prefixIcon: Icon(Icons.key_rounded),
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
                child: MaterialButton(
                  onPressed: () async {
                    _validate(context);
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                width: 60,
                height: 50,
                margin:
                    EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 2),
                decoration: BoxDecoration(
                  color: Color(0xFF88ae45),
                  borderRadius: BorderRadiusDirectional.circular(20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 100, top: 5),
                child: Row(
                  children: [
                    Text("Don't have an Account ?  "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'Signup');
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<adminMode>(context, listen: false)
                              .changeisadmin(true);
                        },
                        child: Text(
                          'I\'m an admin',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Provider.of<adminMode>(context).isAdmin
                                ? kMainColor
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<adminMode>(context, listen: false)
                              .changeisadmin(false);
                        },
                        child: Text(
                          'I\'m a user',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Provider.of<adminMode>(context).isAdmin
                                ? Colors.white
                                : kMainColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<Modelhud>(context, listen: false);
    modelhud.changeisLoading(true);
    if (widget.globalKey.currentState!.validate()) {
      widget.globalKey.currentState!.save();
      try {
        if (Provider.of<adminMode>(context, listen: false).isAdmin) {
          if (password == adminPassword) {
            await auth.createUserWithEmailAndPassword(
                email.trim(), password.trim());
            Navigator.pushNamed(context, AdminHome.id);
          } else {
            throw Exception("Incorrect admin password!");
          }
        } else {
          await auth.createUserWithEmailAndPassword(
              email.trim(), password.trim());
          Navigator.pushNamed(context, AdminHome.id);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
      }
    }
    modelhud.changeisLoading(false);
  }
}
