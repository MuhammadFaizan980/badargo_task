import 'package:badargo_task/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  //=====MAKE SURE TO RUN & GRANT PERMISSIONS FIRST=====
  group('End-to-End App Flow Test', () {
    testWidgets('Splash to home and starting order', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 4));

      final startOrderButton = find.text('Start Order');
      expect(startOrderButton, findsOneWidget);

      await tester.tap(startOrderButton);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.text('Order in progress...'), findsOneWidget);

      final endOrderButton = find.text('End Order');
      expect(endOrderButton, findsOneWidget);

      await tester.tap(endOrderButton);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.text('Order in progress...'), findsNothing);
    });
  });
}
