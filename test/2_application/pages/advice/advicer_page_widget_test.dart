import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture/2_application/core/services/theme_service.dart';
import 'package:clean_architecture/2_application/pages/advice/advice_page.dart';
import 'package:clean_architecture/2_application/pages/advice/bloc/adviser_bloc.dart';
import 'package:clean_architecture/2_application/pages/advice/cubit/adviser_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class MockAdviserCubit extends MockCubit<AdviserCubitState>
    implements AdviserCubit {}

void main() {
  Widget widgetUnderTest({required AdviserCubit cubit}) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => ThemeService(),
        child: BlocProvider<AdviserCubit>(
          create: (context) => cubit,
          child: const AdvicePage(),
        ),
      ),
    );
  }

  group('Advise Page ', () {
    late AdviserCubit mockAdviserCubit;

    setUp(() {
      mockAdviserCubit = MockAdviserCubit();
    });

    group('Shuld be displayed in ViewState', () {
      testWidgets('Initial when cubits emits AdvicerInitial()',
          (widgetTester) async {
        whenListen(
          mockAdviserCubit,
          Stream.fromIterable([AdviserInitial()]),
          initialState: AdviserInitial(),
        );

        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdviserCubit));
      });
    });
  });
}
