import 'dart:async';

import 'package:rxdart/rxdart.dart';

abstract class RxStreamFactory {
  StreamController<T> create<T>();
}

class AppRxStreamFactory implements RxStreamFactory {
  StreamController<T> create<T>() => BehaviorSubject<T>();
}

/// In order to use the emitsInOrder in tests
/// expect(bloc.stream, emitsInOrder([true,false]));
class TestRxStreamFactory implements RxStreamFactory {
  StreamController<T> create<T>() => ReplaySubject<T>();
}
