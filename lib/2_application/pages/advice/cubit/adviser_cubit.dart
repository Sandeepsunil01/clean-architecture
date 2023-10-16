import 'package:clean_architecture/1_domain/failure/failures.dart';
import 'package:clean_architecture/1_domain/usercases/advice_usercases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'adviser_state.dart';

const serverFailureMessage = "Our Servers are down. Please try again later";
const generalFailureMessage = "Something went wrong. Please try again";
const cacheFailureMessage = "Data not cached. Please try again";

class AdviserCubit extends Cubit<AdviserCubitState> {
  AdviserCubit() : super(AdviserCubitInitial());
  final AdviceUseCases adviceUseCases = AdviceUseCases();
  // This can also user other use cases;

  void adviceRequested() async {
    emit(AdviserCubitStateLoading());
    final failureOrAdvice = await adviceUseCases.getAdvice();
    failureOrAdvice.fold(
      (failure) =>
          emit(AdviserCubitStateError(errorMessage: _mapFailure(failure))),
      (advice) => emit(AdviserCubitStateLoaded(advice: advice.advice)),
    );
  }

  String _mapFailure(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}
