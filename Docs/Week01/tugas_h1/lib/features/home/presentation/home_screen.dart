import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Warung Digital'),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Nasi Goreng'),
            subtitle: Text('Pedas / Sedang / Tidak Pedas'),
            trailing: PriceTag(price: 15000, stock: 10),
          ),
          ListTile(
            title: Text('Mie Ayam'),
            subtitle: Text('Pangsit Kuah'),
            trailing: PriceTag(price: 13000, stock: 0),
          ),
          ListTile(
            title: Text('Es Teh Manis'),
            subtitle: Text('Es dipisah'),
            trailing: PriceTag(price: 5000, stock: 50),
          ),
        ],
      ),
    );
  }
}

class PriceTag extends StatelessWidget {
  const PriceTag({super.key, required this.price, required this.stock});

  final int price;
  final int stock;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('Rp$price'),
        Text(stock > 0 ? 'Stok: $stock' : 'Stok habis'),
      ],
    );
  }
}