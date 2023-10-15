import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'adviser_state.dart';

class AdviserCubit extends Cubit<AdviserCubitState> {
  AdviserCubit() : super(AdviserCubitInitial());

  void adviceRequested() async {
    emit(AdviserCubitStateLoading());
    //   Execute Business Login
    //   For Example get and advice
    debugPrint("fake get advice triggered");
    await Future.delayed(const Duration(seconds: 3), () {});
    debugPrint("Thank you got the advice");
    // emit(AdviserCubitStateLoaded(advice: "test advice to test blog"));
    emit(const AdviserCubitStateError(
        errorMessage: "hey something went wrong!"));
  }
}
