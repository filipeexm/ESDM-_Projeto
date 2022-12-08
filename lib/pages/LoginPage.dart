import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/pages/Homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 100.0),
              child: Text(
                "Loja\nVirtual",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 58.0,
                  color: Color(0xFF4C53A5),
                  fontWeight: FontWeight.w900,
                  fontFamily: "Cursive",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "E-mail",
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                obscureText: true,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0),
              child: SizedBox(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF4C53A5)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0)),
                    textStyle:
                        MaterialStateProperty.all(TextStyle(fontSize: 23)),
                  ),
                  child: Text(
                    "Login",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  login() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (userCredential != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => HomePage())));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário não encontrado'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sua senha está errada'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
