import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/AddProduct.dart';
import 'package:flutter_application_1/admin/ManageProducts.dart';
import 'package:flutter_application_1/admin/adminHome.dart';
import 'package:flutter_application_1/screens/Home.dart';
import 'package:provider/provider.dart';
import 'screens/Signup.dart';
import 'screens/Login.dart';
import 'package:flutter_application_1/provider/Modelhud.dart';
import 'package:flutter_application_1/provider/adminMode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  void y() {
    print("Signup button clicked");
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Modelhud>(
          create: (context) => Modelhud(),
        ),
        ChangeNotifierProvider<adminMode>(
          create: (context) =>
              adminMode(), // ici on cree une instance de la classe adminMode de cette facon  , ARetenirrrr
        ),
      ],
      child: MaterialApp(
        initialRoute: Login.id,
        routes: {
          Login.id: (context) => Login(),
          Signup.id: (context) => Signup(onclick: y),
          Home.id: (context) => Home(),
          AddProduct.id: (context) => AddProduct(),
          AdminHome.id: (context) => AdminHome(),
          ManageProducts.id: (context) => ManageProducts(),
        },
      ),
    );
  }
}
