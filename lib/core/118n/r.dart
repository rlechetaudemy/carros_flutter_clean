class R {
  static final strings = Strings();
}

class Strings {
  String get cars => "Cars";

  String get msgNoInternet => "Internet unavailable, check your connection.";
  String get msgTimeoutException => "Internet unavailable, check your connection.";
  String get msgGenericError => "Oops, generic error.";
  String get msgApiFailure => "Oops, server unavailable.";

  String get cars_list_is_empty => "The list of cars is empty.";

  String get loginRequired => "Login is required";
  String get passwordRequired => "Password is required";
  String get passwordMinLength => "Password must have at least 3 numbers";
}
