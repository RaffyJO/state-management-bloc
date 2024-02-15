import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial(number: 0)) {
    on<CounterEvent>((event, emit) {
      if (event is CounterIncrement) {
        emit(CounterSuccess(number: state.number + 1));
      }

      if (event is CounterDecrement) {
        emit(CounterSuccess(number: state.number - 1));
      }
    });
  }
}
