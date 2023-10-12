import 'package:flutter/material.dart';
import 'package:superexpress/app/pages/home/productList.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Super Express',
            style: TextStyle(
              color: Color(0xFFEE3F3E),
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(2, 2),
                  blurRadius: 3,
                ),
              ],
            )),
      ),
      body: const Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Login',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Senha',
            ),
            obscureText: true,
          ),
          ProductList(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xFFEE3F3E)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Color(0xFFEE3F3E)),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xFFEE3F3E)),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
