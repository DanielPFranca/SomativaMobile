import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Tela2 extends StatefulWidget {
  const Tela2({super.key});

  @override
  State<Tela2> createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  TextEditingController id = TextEditingController();
  TextEditingController nome = TextEditingController();
  TextEditingController preco = TextEditingController();
  TextEditingController quantidade = TextEditingController();

  String url = "http://10.109.83.13:3000/produtos";

  get() async {
    http.Response resposta = await http.get(Uri.parse(url));
    var dado = jsonDecode(resposta.body) as List;
    print(dado);
  }

  _post() {
    // estrutura do arquivo json para realizar o post
    Map<String, dynamic> produto_a = {
      "id": id.text,
      "nome": nome.text,
      "preco": preco.text,
      "quantidade": quantidade.text
    };
    http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(produto_a),
    );
    print("Post: ${produto_a}");
    //Navigator.push(context,MaterialPageRoute(builder: (context) => Tela3("${nome.text}", "${preco.text}", "${quantidade.text}" )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Pordutos"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: id,
              decoration: InputDecoration(
                  labelText: 'ID Produto',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.name,
              controller: nome,
              decoration: InputDecoration(
                  labelText: 'Produto',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: preco,
              decoration: InputDecoration(
                  labelText: 'Preço',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: quantidade,
              decoration: InputDecoration(
                  labelText: 'Quantidade',
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
