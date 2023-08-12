import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/checagem_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _firabeAuth = FirebaseAuth.instance;
  String nome = '';
  String email = '';

  @override
  void initState() {
    pegarUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader ( 
              accountName:  Text(nome), 
              accountEmail: Text(email)
            ),
            ListTile(
              dense: true,
              title: const Text('Sair'),
              trailing: const Icon(Icons.exit_to_app),
              onTap: (){
                sair();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            Center(child: Text(nome))
        ],
      )
    );
  }

  pegarUsuario() async{
    User? usuario = await FirebaseAuth.instance.currentUser;
    if(usuario != null){
      setState(() {
        nome = usuario.displayName!;
        email = usuario.email!;
      });
    }
  }

  sair() async{
    await _firabeAuth.signOut().then(
      (user) => Navigator.pushReplacement(
        context, MaterialPageRoute(
          builder: (context) => const ChecagemPage())
        ,)
    );
  }
}