import 'package:clean_architecture/2_application/pages/advice/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderTest({required String errorString}) {
    return MaterialApp(
      home: Scaffold(
        body: ErrorMessage(message: errorString),
      ),
    );
  }

  group('Error Message', () {
    testWidgets('When a short text is given', (widgetTester) async {
      const text = "something";

      await widgetTester.pumpWidget(widgetUnderTest(errorString: text));
      await widgetTester.pumpAndSettle();

      final errorMessageFieldFinder = find.textContaining(text);

      expect(errorMessageFieldFinder, findsOneWidget);
    });

    testWidgets('When a long text is given', (widgetTester) async {
      const text =
          "Hello, This is a new project on Clean Architecture Pattern. Have a great time viewing this project. As I am still learning it might contain mistakes. Please feel free fork the repo and make necessary changes";

      await widgetTester.pumpWidget(widgetUnderTest(errorString: text));
      await widgetTester.pumpAndSettle();

      final errorMessageFieldFinder = find.byType(ErrorMessage);

      expect(errorMessageFieldFinder, findsOneWidget);
    });
  });
}
