import 'package:flutter/material.dart';

import 'model/product.dart';

class CategoryMenuPage extends StatelessWidget {
  final Category currentCategory;
  final ValueChanged<Category> onCategoryTap;
  final List<Category> _categories = Category.values;

  const CategoryMenuPage({
    Key? key,
    required this.currentCategory,
    required this.onCategoryTap,
  }) : super(key: key);

  Widget _buildCategory(Category category, BuildContext context) {
    final categoryString = category.toString().replaceAll('Category.', '').toUpperCase();
    // Definisi variabel theme berdasarkan BuildContext
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onCategoryTap(category),
      child: category == currentCategory
          ? Column(
              children: <Widget>[
                const SizedBox(height: 16.0),
                Text(
                  categoryString,
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 14.0),
                Container(
                  width: 70.0,
                  height: 2.0,
                  color: theme.colorScheme.primary,
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                categoryString,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onPrimary.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 40.0),
        color: theme.colorScheme.primary,
        child: ListView(
          children: _categories
              .map((Category c) => _buildCategory(c, context))
              .toList(),
        ),
      ),
    );
  }
}