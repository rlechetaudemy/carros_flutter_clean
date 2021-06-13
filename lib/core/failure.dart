abstract class Failure implements Exception {
  @override
  String toString() => '$runtimeType Exception';
}

class GenericFailure extends Failure {}

class TimeoutFailure extends Failure {}

class ApiFailure extends Failure {}

class MessageFailure extends Failure {
  final String msg;

  MessageFailure(this.msg);
}