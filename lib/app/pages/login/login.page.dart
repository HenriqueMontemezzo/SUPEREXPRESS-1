import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:superexpress/app/pages/home/home.page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required String title}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /*Conexao ao API
  //var carregando = false;
  var dados;
  var BDemail, BDpassword;

  _loginBD() async {
    final url = "http://192.168.100.9/flutter/login/login.php";
    //no lugar de local host, dar um ip config e colar o IPV4 da maquina
    final response = await http.get(url as Uri); //Uri url
    final map = json.decode(response.body);
    final usuario = map["result"];
    this.dados = usuario;
  }*/

  Future<void> _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.100.9/flutter/login/login.php'), // URL do servidor local
        body: {
          'username': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Login bem-sucedido, redirecione para a página inicial
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      } else {
        // Login falhou, exiba uma mensagem de erro
        final responseData = jsonDecode(response.body);
        final errorMessage = responseData['error'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('Ocorreu um erro: $e');
    }
  }

  Future<void> _resetPassword() async {
    final email = _emailController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: const Color(0xFFFFFFFF),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                width: 128,
                height: 128,
                child: Image.asset("assets/logo.png"),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Entrar'),
              ),
              // Restante do código para construir a interface de login
            ],
          ),
        ),
      ),
    );
  }
}
