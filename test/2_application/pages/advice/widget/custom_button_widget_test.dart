import 'package:clean_architecture/2_application/pages/advice/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

abstract class OnCustomButtonTap {
  void call();
}

class MockOnCustomButtonTap extends Mock implements OnCustomButtonTap {}

void main() {
  Widget widgetUnderTest({Function()? callback}) {
    return MaterialApp(
      home: Scaffold(
        body: CustomButton(
          onTap: callback,
        ),
      ),
    );
  }

  group('Custom Button', () {
    testWidgets('Check if the Button rendered correctly', (widgetTester) async {
      await widgetTester.pumpWidget(widgetUnderTest());

      final buttonLabelFinder = find.text('Give me Advice');

      expect(buttonLabelFinder, findsOneWidget);
    });

    testWidgets('Button Press action', (widgetTester) async {
      final mockOnCustomButtonTap = MockOnCustomButtonTap();
      await widgetTester
          .pumpWidget(widgetUnderTest(callback: mockOnCustomButtonTap));

      final customButtonFinder = find.byType(CustomButton);

      await widgetTester.tap(customButtonFinder);

      verify(mockOnCustomButtonTap).called(1);
    });
  });
}
