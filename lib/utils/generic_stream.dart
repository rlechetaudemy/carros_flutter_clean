import 'package:app/imports.dart';
import 'package:app/utils/rx_stream_factory.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class GenericStream<T> extends Equatable {
  StreamController<T> controller = get<RxStreamFactory>().create<T>();

  Stream<T> get stream => controller.stream;

  bool get isClosed => controller.isClosed;

  void add(T object) {
    if (!isClosed) {
      controller.add(object);
    }
  }

  @override
  List<Object?> get props => [];

  void close() {
    controller.close();
  }
}

// ignore: must_be_immutable
class BooleanStream extends GenericStream<bool> {}
