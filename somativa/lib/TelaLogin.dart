import 'package:flutter/material.dart';
import 'package:formativa1/cadastroUser.dart';
import 'package:formativa1/tela2.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: telaLogin(),
  ));
}

class telaLogin extends StatefulWidget {
  const telaLogin({super.key});

  @override
  State<telaLogin> createState() => _telaLoginState();
}

class _telaLoginState extends State<telaLogin> {
  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();

  String? userLogin;
  String? userSenha;

  _verificarlogin() async {
  String url = "http://10.109.83.13:3000/usuarios";
  http.Response resposta = await http.get(Uri.parse(url));
  bool encuser = false;
  List clientes = json.decode(resposta.body);

  for (int i = 0; i < clientes.length; i++) {
    if (user.text == clientes[i]["login"] && password.text == clientes[i]["senha"]) {
      encuser = true;
      print("Usuário encontrado");
      break;
    }
  }

  if (encuser) {
    print("Usuário encontrado");
    Navigator.push(context, MaterialPageRoute(builder: (context) => Filmes()));
    encuser = false;
    user.text = "";
    password.text = "";
  } else {
    print("Usuário não encontrado, realize o cadastro");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Usuário não cadastrado"),
        duration: Duration(seconds: 2),
      ),
    );
    encuser = false;
    showDialog(
      context: context,
      builder: (BuildContext) {
        return AlertDialog(
          content: Text('Usuário inválido'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            )
          ],
        );
      },
    );
  }
}

        
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Login'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.name,
              controller: user,
              decoration: InputDecoration(
                  labelText: 'Usuário',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.name,
              controller: password,
              decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60))),
            ),
          ),
          ElevatedButton(onPressed: _verificarlogin, child: Text('Login')),
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastro()));
          }, child: Text('Cadastrar')),
        ],
      ),
    );
  }
}

