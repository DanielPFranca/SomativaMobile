import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Filme>> fetchFilmes() async {
  final response = await http.get(Uri.parse(
      'https://raw.githubusercontent.com/danielvieira95/DESM-2/master/filmes.json'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((filme) => Filme.fromJson(filme)).toList();
  } else {
    throw Exception('Falha ao carregar filmes');
  }
}

class Filmes extends StatefulWidget {
  @override
  _FilmesState createState() => _FilmesState();
}

class _FilmesState extends State<Filmes> {
  late Future<List<Filme>> futureFilmes;

  @override
  void initState() {
    super.initState();
    futureFilmes = fetchFilmes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filmes'),
      ),
      body: Center(
        child: FutureBuilder<List<Filme>>(
          future: futureFilmes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Filme> filmes = snapshot.data!;
              return ListView.builder(
                itemCount: filmes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(
                    filmes[index].imagem,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                    title: Text(filmes[index].nome),
                    subtitle: Text(
                    'Lançamento: ${filmes[index].ano} Nota: ${filmes[index].nota}'),);
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class Filme {
  final String nome;
  final String imagem;
  final String duracao;
  final String ano;
  final String nota;

  Filme(
      {required this.nome,
      required this.imagem,
      required this.duracao,
      required this.ano,
      required this.nota});

  factory Filme.fromJson(Map<String, dynamic> json) {
    return Filme(
      nome: json['nome'],
      imagem: json['imagem'],
      duracao: json['duração'],
      ano: json['ano de lançamento'],
      nota: json['nota'],
    );
  }
}
