import 'package:clean_architecture/2_application/pages/advice/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderTest({Function()? onTap}) {
    return MaterialApp(
      home: Scaffold(
        body: CustomButton(onTap: onTap),
      ),
    );
  }

  group('Golden Test', () {
    group('Custom Button', () {
      testWidgets('Is Disabled', (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest(onTap: () {}));
        await expectLater(find.byType(CustomButton),
            matchesGoldenFile('goldens/custom_button_enabled.png'));
      });

      testWidgets('Is Enabled', (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderTest());
        await expectLater(find.byType(CustomButton),
            matchesGoldenFile('goldens/custom_button_disabled.png'));
      });
    });
  });
}
