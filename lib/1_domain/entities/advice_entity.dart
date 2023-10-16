// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AdviceEntity extends Equatable {
  final String advice;
  final int id;

  const AdviceEntity({
    required this.advice,
    required this.id,
  });

  @override
  List<Object> get props => [advice, id];
}
