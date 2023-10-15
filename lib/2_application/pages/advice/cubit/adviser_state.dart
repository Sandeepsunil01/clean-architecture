part of 'adviser_cubit.dart';

abstract class AdviserCubitState extends Equatable {
  const AdviserCubitState();

  @override
  List<Object?> get props => [];
}

class AdviserCubitInitial extends AdviserCubitState {}

class AdviserCubitStateLoading extends AdviserCubitState {}

class AdviserStateLoaded extends AdviserCubitState {
  final String advice;

  const AdviserStateLoaded({required this.advice});

  @override
  List<Object?> get props => [advice];
}

class AdviserStateError extends AdviserCubitState {
  final String errorMessage;

  const AdviserStateError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
