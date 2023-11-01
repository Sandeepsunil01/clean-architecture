part of 'adviser_cubit.dart';

abstract class AdviserCubitState extends Equatable {
  const AdviserCubitState();

  @override
  List<Object?> get props => [];
}

class AdviserCubitInitial extends AdviserCubitState {
  const AdviserCubitInitial();
}

class AdviserCubitStateLoading extends AdviserCubitState {
  const AdviserCubitStateLoading();
}

class AdviserCubitStateLoaded extends AdviserCubitState {
  final String advice;

  const AdviserCubitStateLoaded({required this.advice});

  @override
  List<Object?> get props => [advice];
}

class AdviserCubitStateError extends AdviserCubitState {
  final String errorMessage;

  const AdviserCubitStateError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
