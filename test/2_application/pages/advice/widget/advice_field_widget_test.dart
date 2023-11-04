import 'package:clean_architecture/2_application/pages/advice/widgets/advice_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderTest({required String adviceText}) {
    return MaterialApp(
      home: AdviceField(advice: adviceText),
    );
  }

  group('Advice Field', () {
    testWidgets(
      "When a short text is given",
      (WidgetTester tester) async {
        const text = "a";
        await tester.pumpWidget(widgetUnderTest(adviceText: text));
        await tester.pumpAndSettle();

        final adviceFieldFinder = find.textContaining('a');

        expect(adviceFieldFinder, findsOneWidget);
      },
    );

    testWidgets("When a long text is given", (WidgetTester tester) async {
      const text =
          "Hello, This is a new project on Clean Architecture Pattern. Have a great time viewing this project. As I am still learning it might contain mistakes. Please feel free fork the repo and make necessary changes";
      await tester.pumpWidget(widgetUnderTest(adviceText: text));
      await tester.pumpAndSettle();

      final adviceFieldFinder = find.byType(AdviceField);

      expect(adviceFieldFinder, findsOneWidget);
    });
  });
}
