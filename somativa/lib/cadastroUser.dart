import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _Tela2State();
}

class _Tela2State extends State<Cadastro> {
  TextEditingController id = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController login = TextEditingController();
  TextEditingController senha = TextEditingController();

  String url = "http://10.109.83.13:3000/usuarios";

  get() async {
    http.Response resposta = await http.get(Uri.parse(url));
    var dado = jsonDecode(resposta.body) as List;
    print(dado);
  }

  _post() {
    // estrutura do arquivo json para realizar o post
    Map<String, dynamic> usuario = {
      "id": id.text,
      "nome": nome.text,
      "login": login.text,
      "senha": senha.text
    };
    http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(usuario),
    );
    print("Post: ${usuario}");
    //Navigator.push(context,MaterialPageRoute(builder: (context) => Tela3("${nome.text}", "${preco.text}", "${quantidade.text}" )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Usuarios"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: id,
              decoration: InputDecoration(
                  labelText: 'ID Usuario',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: nome,
              decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: login,
              decoration: InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: senha,
              decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60))),
            ),
          ),
          ElevatedButton(onPressed: _post, child: Text('Cadastrar'))
        ],
      ),
    );
  }
}
