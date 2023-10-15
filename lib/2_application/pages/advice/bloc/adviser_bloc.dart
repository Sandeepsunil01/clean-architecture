import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'adviser_event.dart';
part 'adviser_state.dart';

class AdviserBloc extends Bloc<AdviserEvent, AdviserState> {
  AdviserBloc() : super(AdviserInitial()) {
    on<AdviserRequestEvent>((event, emit) async {
      emit(AdviserStateLoading());
      //   Execute Business Login
      //   For Example get and advice
      debugPrint("fake get advice triggered");
      await Future.delayed(const Duration(seconds: 3), () {});
      debugPrint("Thank you got the advice");
      // emit(AdviserStateLoaded(advice: "test advice to test blog"));
      emit(AdviserStateError(errorMessage: "hey something went wrong!"));
    });
  }
}
