import 'package:flutter/material.dart';
import 'package:warung_digital/core/widgets/price_tag.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Warung Digital')),
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
            trailing: PriceTag(price: 13000, stock: 0), // Akan memunculkan badge "Habis"
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