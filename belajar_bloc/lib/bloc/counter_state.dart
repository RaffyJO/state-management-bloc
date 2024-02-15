part of 'counter_bloc.dart';

@immutable
sealed class CounterState {
  int number;

  CounterState({required this.number});
}

final class CounterInitial extends CounterState {
  CounterInitial({required super.number});
}

final class CounterSuccess extends CounterState {
  CounterSuccess({required super.number});
}
