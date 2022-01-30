

import 'package:app/imports.dart';
import 'package:equatable/equatable.dart';

class ErrorState extends Equatable {

  // Custom
  late final String msg;

  @override
  List<Object> get props => [msg];

  ErrorState.noInternet() {
    this.msg = R.strings.msgNoInternet;
  }

  ErrorState.create(dynamic error) {
    _logError(error);

    if (error == null) {
      this.msg = R.strings.msgGenericError;
    } else if (error is String) {
      this.msg = error.toString();
    } else if(error is ApiMessageException) {
      this.msg = error.msg;
    } else if(error is ApiFailure) {
      this.msg = R.strings.msgApiFailure;
    } else if(error is MessageFailure) {
      this.msg = error.msg;
    } else if(error is TimeoutFailure) {
      this.msg = R.strings.msgTimeoutException;
    } else if(error is Failure) {
      this.msg = R.strings.msgGenericError;
    } else if (error is TimeoutException) {
      this.msg = R.strings.msgTimeoutException;
    } else if (error is SocketException) {
      this.msg = R.strings.msgTimeoutException;
    } else {
      this.msg = R.strings.msgGenericError;
    }
  }

  void _logError(error) {
    if (kDebugMode && error != null) {
      print("--- ErrorState.create ---");
      print(error);
      print("------------");
    }
  }
}
