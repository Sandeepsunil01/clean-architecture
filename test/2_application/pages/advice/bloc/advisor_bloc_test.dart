import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture/2_application/pages/advice/bloc/adviser_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Advisor Bloc', () {
    blocTest<AdviserBloc, AdviserState>(
      'when no event is Added',
      build: () => AdviserBloc(),
      expect: () => const <AdviserState>[],
    );

    blocTest(
      '[AdviserStateLoading, AdviserStateError] when AdviserRequestEvent is added',
      build: () => AdviserBloc(),
      act: (bloc) => bloc.add(AdviserRequestEvent()),
      wait: const Duration(seconds: 3),
      expect: () => <AdviserState>[
        AdviserStateLoading(),
        AdviserStateError(errorMessage: 'hey something went wrong!')
      ],
    );
  });
}
