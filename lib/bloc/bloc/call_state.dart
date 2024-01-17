part of 'call_bloc.dart';

@freezed
class CallState with _$CallState {
  const factory CallState({required List<model> result}) = _Initial;
  factory CallState.initial() => CallState(result: []);
}
