import 'dart:async';

import 'package:bloc/counter_event.dart';

class CounterBloc {
  int _counter = 0;

  final _counterStateController = StreamController<int>();

  StreamSink<int> get _intCounter => _counterStateController.sink;

  //for state exposing only a stream which controls data
  Stream<int> get counter => _counterStateController.stream;

  //forevents exposing only a sink which is an output
  final _counterEventController = StreamController<CounterEvent>();

  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if(event is IncrementEvent) {
      _counter++;
    }
    else {
      _counter--;
    }
    _intCounter.add(_counter);
  }

  void dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }

}