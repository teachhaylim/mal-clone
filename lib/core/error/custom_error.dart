class CustomError {
  final int statusCode;
  final String message;

  static CustomError get unauthenticated => const CustomError(statusCode: 605, message: "Required Authentication");

  const CustomError({this.statusCode = -1, this.message = "Unknown Error"});
}

class StatusCode {
  static int requiredAuthentication = 605;
  static int unknownError = -1;
  static int timeout = 408;
  static int somethingWentWrong = 999;
}

class StatusMessage {
  static String requiredAuthentication = "Required Authentication";
  static String unknownError = "Unknown Error";
  static String timeout = "Timeout";
  static String somethingWentWrong = "Something went wrong";
  static String socketError = "Socket Error";
}
