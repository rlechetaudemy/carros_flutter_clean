import 'package:app/imports.dart';
import 'package:app/utils/generic_stream.dart';

// ignore: must_be_immutable
class ViewState<T> extends GenericStream<ViewState<T>> {
  T? _value;
  bool _loading = true;
  ErrorState? _error;

  ViewState();

  ViewState.loading(this._loading);

  ViewState.value(this._value);

  ViewState.error(this._error);

  T? get value => _value;

  bool get loading => _loading;

  ErrorState? get error => _error;

  set value(T? value) {
    this._loading = false;
    this._error = null;
    this._value = value;
    add(ViewState<T>.value(_value));
  }

  set loading(bool b) {
    this._loading = b;
    this._error = null;
    this._value = null;
    add(ViewState<T>.loading(_loading));
  }

  set error(ErrorState? error) {
    this._error = error;
    this._loading = false;
    this._value = null;
    add(ViewState<T>.error(_error));
  }

  @override
  List<Object> get props {
    List<Object> objs = <Object>[_loading];

    if (_error != null) {
      objs.add(_error!.props);
    }

    if (_value != null) {
      objs.add(_value!);
    }

    return objs;
  }

  @override
  bool get stringify => true;
}
