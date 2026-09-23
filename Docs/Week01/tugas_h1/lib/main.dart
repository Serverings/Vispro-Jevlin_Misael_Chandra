class MenuItem {
  String name;
  double price;
  double? discountPercent;

  MenuItem({
    required this.name,
    required this.price,
    this.discountPercent,
  });

  double finalPrice() {
    final discount = discountPercent;

    if (discount == null) {
      return price;
    }

    return price - (price * discount / 100);
  }
}

void main() {
  final menu = <MenuItem>[
    MenuItem(
      name: 'Nasi Goreng',
      price: 18000,
      discountPercent: 10,
    ),
    MenuItem(
      name: 'Mie Goreng',
      price: 14000,
    ),
    MenuItem(
      name: 'Es Teh',
      price: 5000,
      discountPercent: 20,
    ),
  ];

  final names = menu
      .map((item) => item.name)
      .toList();

  final itemsUnder15000 = menu
      .where((item) => item.finalPrice() < 15000)
      .toList();

  final totalPrice = menu.fold(
    0.0,
    (total, item) => total + item.finalPrice(),
  );

  print('All names: $names');

  print(
    'Items under Rp15.000: '
    '${itemsUnder15000.map((item) => item.name).toList()}',
  );

  print('Total price: Rp$totalPrice');
}