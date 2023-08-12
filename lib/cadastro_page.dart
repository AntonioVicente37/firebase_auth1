import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/checagem_page.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagina de cadastro'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          TextFormField(
            controller: _nomeController,
            decoration: const InputDecoration(
              label: Text('Nome completo'),
            ),
          ),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(label: Text('E-mail')),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(label: Text('PassWord')),
          ),
          ElevatedButton(
            onPressed: () {
              cadastrar();
            }, 
            child: const Text('Cadastrar')
          ),
        ],
      ),
    );
  }

  cadastrar() async{
    try {
        UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);
        if(userCredential != null){
           userCredential.user!.updateDisplayName(_nomeController.text);
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(
                builder: (context) => const ChecagemPage()
              )
            );
        }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Crie uma senha mas forte'),
            backgroundColor: Colors.redAccent,
          )
        );
      } else if(e.code == 'email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Este email ja foi cadastrado'),
            backgroundColor: Colors.redAccent,
          )
        );
      }
    }
  }
}
