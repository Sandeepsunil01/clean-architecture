part of 'adviser_bloc.dart';

@immutable
sealed class AdviserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AdviserRequestEvent extends AdviserEvent {}
