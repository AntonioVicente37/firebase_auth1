import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_page.dart';

import 'cadastro_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                label: Text('E-mail')
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                label: Text('Password')
              ),
            ),
            ElevatedButton(
              onPressed: () {
                login();
              }, 
              child: const Text('Entrar')),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => CadastroPage()),  
                );
              }, 
              child: const Text('Criar Conta'))
          ],
      ),
    );
  }


  login() async {
    try {
     UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text, 
          password: _passwordController.text
        ); 
      if (userCredential != null) {
        Navigator.pushReplacement(
          context, 
            MaterialPageRoute(
              builder: (context) => const HomePage()
            ),
          );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuário não encontrado'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sua senha esta errada'),
            backgroundColor: Colors.redAccent,
          ),  
        );
      }
    }
  }
}