import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  const PriceTag({super.key, required this.price, required this.stock});

  final int price;
  final int stock;

  // Sesuai konsep declarative Bab 3: kita gunakan getter untuk mengecek stok
  bool get isSoldOut => stock == 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Agar row tidak mengambil seluruh lebar layar
      children: [
        Text(
          'Rp $price',
          style: TextStyle(
            color: isSoldOut ? Colors.grey : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Menampilkan badge "Habis" hanya jika isSoldOut bernilai true
        if (isSoldOut) ...[
          const SizedBox(width: 8),
          const Chip(
            label: Text('Habis', style: TextStyle(fontSize: 12)),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ],
    );
  }
}