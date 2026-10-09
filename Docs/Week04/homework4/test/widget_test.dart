import 'package:flutter_test/flutter_test.dart';
import 'package:homework2/app.dart';

void main() {
  testWidgets('GameVault app test', (WidgetTester tester) async {
    await tester.pumpWidget(const GameVaultApp());

    expect(find.text('GameVault'), findsOneWidget);
  });
}