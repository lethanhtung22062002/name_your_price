import 'package:flutter_test/flutter_test.dart';
import 'package:project_01/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  group('Home page test', () {
    Finder checkBtn() => find.text('Check');
    Finder nextBtn() => find.text('Next');
    Finder priceInput() => find.byKey(const Key('priceInput'));

    testWidgets('Click next to iterate over the product list',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: HomePage(),
      ));

      var product;
      expect(find.text(product[0].name), findsOneWidget);

      for (var i = 1; i < 5; i++) {
        await tester.tap(checkBtn());
        await tester.enterText(priceInput(), '0');
        await tester.pump();
        await tester.tap(nextBtn());
        await tester.pump();
        expect(find.text(product[i].name), findsOneWidget);
      }

      await tester.tap(checkBtn());
      await tester.pump();
      await tester.tap(nextBtn());
      await tester.pump();
      expect(find.text(product[4].name), findsOneWidget);
    });

    testWidgets('Check result & show next product',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: HomePage(),
      ));

      expect(nextBtn(), findsNothing);
      expect(find.byKey(const Key('result')), findsNothing);
      await tester.enterText(priceInput(), '3');
      await tester.tap(checkBtn());
      await tester.pump();
      expect(nextBtn(), findsOneWidget);
      expect(find.byKey(const Key('result')), findsOneWidget);
      expect(find.text('pass'), findsOneWidget);

      await tester.tap(nextBtn());
      await tester.pump();

      expect(nextBtn(), findsNothing);
      expect(find.byKey(const Key('result')), findsNothing);
      await tester.enterText(priceInput(), '4');
      await tester.tap(checkBtn());
      await tester.pump();
      expect(find.byKey(const Key('result')), findsOneWidget);
      expect(find.text('pass'), findsOneWidget);
      expect(find.text('fail'), findsOneWidget);

      await tester.enterText(priceInput(), '5');
      await tester.tap(checkBtn());
      await tester.pump();
      expect(find.text('pass'), findsOneWidget);
    });
  });
}
