import 'package:app/failure/failure.dart';
import 'package:app/functions/firebase.dart';
import 'package:app/model/model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_event.dart';
part 'call_state.dart';
part 'call_bloc.freezed.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  CallBloc() : super(CallState.initial()) {
    on<_Started>((event, emit) async {
      final _result = await FirebaseFunction().firebaseGetData();
      print(_result);

      final emitOf = _result.fold((MainFailure l) {
        return CallState(result: []);
      }, (List<model> r) {
        return CallState(result: r);
      });
      emit(emitOf);
    });
  }
}
