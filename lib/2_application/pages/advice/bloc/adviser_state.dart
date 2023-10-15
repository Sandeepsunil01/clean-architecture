part of 'adviser_bloc.dart';

@immutable
sealed class AdviserState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class AdviserInitial extends AdviserState {}

final class AdviserStateLoading extends AdviserState {}

final class AdviserStateLoaded extends AdviserState {
  final String advice;
  AdviserStateLoaded({required this.advice});

  @override
  List<Object?> get props => [advice];
}

final class AdviserStateError extends AdviserState {
  final String errorMessage;
  AdviserStateError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
