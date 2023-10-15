part of 'adviser_bloc.dart';

@immutable
sealed class AdviserState {}

final class AdviserInitial extends AdviserState {}

final class AdviserStateLoading extends AdviserState {}

final class AdviserStateLoaded extends AdviserState {
  final String advice;
  AdviserStateLoaded({required this.advice});
}

final class AdviserStateError extends AdviserState {
  final String errorMessage;
  AdviserStateError({required this.errorMessage});
}
